/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.usuario.mysql;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.model.usuario.Usuario;
import pe.edu.sis.usuario.dao.UsuarioDAO;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author seinc
 */
public class UsuarioImpl implements UsuarioDAO{
    private ResultSet rs;
    @Override
    public int insertar(Usuario user) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,user.getHashClave());
        in.put(3,user.getNombre());
//        in.put(4,user.getApellido_paterno());
//        in.put(5,user.getApellido_materno());
//        in.put(6,user.getEmail());
        in.put(7,new Date(user.getUltimo_acceso().getTime()));
//        in.put(8,user.getRol().getRol_id());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_USUARIO",in,out);
        user.setUsuario_id((int)out.get(1));
        System.out.println("Se ha realizado el registro del usuario");
        return user.getUsuario_id();
    }

    @Override
    public int modificar(Usuario user) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,user.getUsuario_id());
        in.put(2,user.getHashClave());
        in.put(3,user.getNombre());
//        in.put(4,user.getApellido_paterno());
//        in.put(5,user.getApellido_materno());
//        in.put(6,user.getEmail());
        in.put(7,new Date(user.getUltimo_acceso().getTime()));
//        in.put(8,user.getRol().getRol_id());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_USUARIO",in,null);
        System.out.println("Se ha realizado la modificacion del usuario");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_USUARIO",in,null);
        System.out.println("Se ha realizado la modificacion del usuario");
        return resultado;
    }

    @Override
    public Usuario obtener_por_id(int pos) {
        Usuario user=null;
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_USUARIO_POR_ID", in);
        int rol_id=0; //falta implementar
        try{
            while(rs.next()){
                if(user == null) user = new Usuario();
                user.setUsuario_id(rs.getInt("usuario_id"));
                user.setNombre(rs.getString("nombre"));
//                user.setApellido_paterno(rs.getString("apellido_paterno"));
//                user.setApellido_materno(rs.getString("apellido_materno"));
//                user.setEmail(rs.getString("email"));
                user.setUltimo_acceso(rs.getDate("ultimoacceso"));
                rol_id=rs.getInt("rol_id");
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        return user;
    }

    @Override
    public ArrayList<Usuario> listarTodos() {
        ArrayList<Usuario> usuarios=null;
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_USUARIOS", null);
        ArrayList<Integer> id=new ArrayList<>(); //falta implementar
        try{
            while(rs.next()){
                if(usuarios == null) usuarios = new ArrayList<>();
                Usuario user=new Usuario();
                user.setUsuario_id(rs.getInt("usuario_id"));
                user.setNombre(rs.getString("nombre"));
//                user.setApellido_paterno(rs.getString("apellido_paterno"));
//                user.setApellido_materno(rs.getString("apellido_materno"));
//                user.setEmail(rs.getString("email"));
                user.setUltimo_acceso(rs.getDate("ultimoacceso"));
                usuarios.add(user);
                id.add(rs.getInt("rol_id"));
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        //falta implementar el llenado del tipo de rol al usuario
        return usuarios;
    }
    
}
