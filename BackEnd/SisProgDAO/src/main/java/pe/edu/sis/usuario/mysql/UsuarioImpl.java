/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.usuario.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.model.usuario.Rol;
import pe.edu.sis.model.usuario.Usuario;
import pe.edu.sis.usuario.dao.UsuarioDAO;

/**
 *
 * @author seinc
 */
public class UsuarioImpl implements UsuarioDAO {
    private ResultSet rs;

    @Override
    public Usuario obtenerDatos(String nombre){
        Usuario user = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, nombre);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("obtener_salt_iteracion", in);
        try {
            while (rs.next()) {
                user=new Usuario();
                user.setSalt(rs.getString("SALT"));
                user.setIteracion(rs.getInt("ITERACION"));
                
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return user;
    }
    @Override
    public int verificarUsuario(String nombre,String clave) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, nombre);
        in.put(2, clave);
        rs=null;
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("verificar_cuenta", in);
        int res=-1;
        try{
            if(rs!=null && rs.next()){
                res=rs.getInt("USUARIO_ID");
            }else{
                res=0;
            }

        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }

        return res;
    }
    
    
    @Override
    public int insertar(Usuario user) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, user.getNombre());
        in.put(3, user.getHashClave());
        in.put(4, user.getSalt());
        in.put(5, user.getIteracion());
        in.put(6, user.getRol().toString());
        in.put(7, new Date(user.getUltimo_acceso().getTime()));
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_USUARIO", in, out) < 0)
            return -1;
        user.setUsuario_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del usuario");
        return user.getUsuario_id();
    }

    @Override
    public int modificar(Usuario user) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, user.getUsuario_id());
        in.put(2, user.getNombre());
        in.put(3, user.getHashClave());
        in.put(4, user.getSalt());
        in.put(5, user.getIteracion());
        in.put(6, user.getRol().toString());
        in.put(7, new Date(user.getUltimo_acceso().getTime()));
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_USUARIO", in, null);
        System.out.println("Se ha realizado la modificacion del usuario");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_USUARIO", in, null);
        System.out.println("Se ha realizado la modificacion del usuario");
        return resultado;
    }

    @Override
    public Usuario obtener_por_id(int pos) {
        Usuario user = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_USUARIO_POR_ID", in);
        try {
            while (rs.next()) {
                Rol rol = Rol.valueOf(rs.getString("rol"));

                user = new Usuario(
                        rs.getString("clave_hash"),
                        rs.getInt("iteracion"),
                        rs.getString("nombre"),
                        rol,
                        rs.getString("salt"),
                        rs.getDate("ultimo_acceso"));

                user.setUsuario_id(rs.getInt("usuario_id"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return user;
    }

    @Override
    public ArrayList<Usuario> listarTodos() {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_USUARIOS", null);
        try {
            while (rs.next()) {
                Rol rol = Rol.valueOf(rs.getString("rol"));

                Usuario user = new Usuario(
                        rs.getString("clave_hash"),
                        rs.getInt("iteracion"),
                        rs.getString("nombre"),
                        rol,
                        rs.getString("salt"),
                        rs.getDate("ultimo_acceso"));

                user.setUsuario_id(rs.getInt("usuario_id"));
                usuarios.add(user);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        
        return usuarios;
    }
}
