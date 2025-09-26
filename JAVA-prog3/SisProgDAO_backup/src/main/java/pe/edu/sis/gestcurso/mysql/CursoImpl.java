/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gestcurso.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gestcurso.dao.CursoDAO;
import pe.edu.sis.gestgracademico.dao.GradoDAO;
import pe.edu.sis.gestgracademico.mysql.GradoImpl;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author seinc
 */
public class CursoImpl implements CursoDAO {
    private ResultSet rs;
    @Override
    public int insertar(Curso curso) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,curso.getNombre());
        in.put(3,curso.getDescripcion());
        in.put(4,curso.getHoras_semanales());
        in.put(5,curso.getAbreviatura());
        in.put(6,curso.getGrado().getGrado_academico_id());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_CURSO",in,out);
        curso.setCurso_id((int)out.get(1));
        System.out.println("Se ha realizado el registro del Curso ");
        return curso.getCurso_id();
    }

    @Override
    public int modificar(Curso curso) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,curso.getCurso_id());
        in.put(2,curso.getNombre());
        in.put(3,curso.getDescripcion());
        in.put(4,curso.getHoras_semanales());
        in.put(5,curso.getAbreviatura());
        in.put(6,curso.getGrado().getGrado_academico_id());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_CURSO",in,null);
        System.out.println("Se ha realizado la modificacion del Curso ");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_CURSO",in,null);
        System.out.println("Se ha realizado la eliminacion del Curso ");
        return resultado;
    }

    @Override
    public Curso obtener_por_id(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_CURSO_POR_ID", in);
        int id=0;
        Curso curso=new Curso();
        GradoDAO dao= new GradoImpl();
        try{
            while(rs.next()){
                curso.setAbreviatura(rs.getString("abreviatura"));
                curso.setActivo(rs.getInt("activo"));
                curso.setNombre(rs.getString("nombre"));
                curso.setDescripcion(rs.getString("descripcion"));
                curso.setHoras_semanales(rs.getInt("horas_semanales"));
                curso.setCurso_id(rs.getInt("curso_id"));
                id=rs.getInt("grado_academico_id");
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        curso.setGrado(dao.obtener_por_id(id));
        return curso;
    }

    @Override
    public ArrayList<Curso> listarTodos() {
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_CURSOS", null);
        ArrayList<Curso> lista=new ArrayList<>();
        GradoDAO dao= new GradoImpl();
        ArrayList<Integer> id=new ArrayList<>();
        try{
            while(rs.next()){
                Curso curso=new Curso();
                curso.setAbreviatura(rs.getString("abreviatura"));
                curso.setActivo(rs.getInt("activo"));
                curso.setNombre(rs.getString("nombre"));
                curso.setDescripcion(rs.getString("descripcion"));
                curso.setHoras_semanales(rs.getInt("horas_semanales"));
                curso.setCurso_id(rs.getInt("curso_id"));
                id.add(rs.getInt("grado_academico_id"));
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        for(int i=0;i<id.size();i++){
            lista.get(i).setGrado(dao.obtener_por_id((int)id.get(0)));
        }
        return lista;
    }
    
}
