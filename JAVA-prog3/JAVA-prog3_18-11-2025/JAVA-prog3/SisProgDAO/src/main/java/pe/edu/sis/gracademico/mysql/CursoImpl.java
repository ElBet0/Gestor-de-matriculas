/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gracademico.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gracademico.dao.CursoDAO;
import pe.edu.sis.model.grAcademico.Curso;
import pe.edu.sis.model.grAcademico.GradoAcademico;

/**
 *
 * @author seinc
 */
public class CursoImpl implements CursoDAO {
    private ResultSet rs;

    @Override
    public int insertar(Curso curso) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, curso.getNombre());
        in.put(3, curso.getDescripcion());
        in.put(4, curso.getHoras_semanales());
        in.put(5, curso.getAbreviatura());
        in.put(6, curso.getGrado().getGrado_academico_id());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_CURSO", in, out) < 0)
            return -1;
        curso.setCurso_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del Curso ");
        return curso.getCurso_id();
    }

    @Override
    public int modificar(Curso curso) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, curso.getCurso_id());
        in.put(2, curso.getNombre());
        in.put(3, curso.getDescripcion());
        in.put(4, curso.getHoras_semanales());
        in.put(5, curso.getAbreviatura());
        in.put(6, curso.getGrado().getGrado_academico_id());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_CURSO", in, null);
        System.out.println("Se ha realizado la modificacion del Curso ");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_CURSO", in, null);
        System.out.println("Se ha realizado la eliminacion del Curso ");
        return resultado;
    }

    @Override
    public Curso obtener_por_id(int _id) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, _id);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_CURSO_POR_ID", in);
        Curso curso = new Curso();
        try {
            while (rs.next()) {
                curso.setAbreviatura(rs.getString("curso_abreviatura"));
                // curso.setActivo(rs.getInt("activo"));
                curso.setNombre(rs.getString("curso_nombre"));
                curso.setDescripcion(rs.getString("descripcion"));
                curso.setHoras_semanales(rs.getInt("horas_semanales"));
                curso.setCurso_id(rs.getInt("curso_id"));

                GradoAcademico gado = new GradoAcademico();
                gado.setGrado_academico_id(rs.getInt("GRADO_ACADEMICO_ID"));
                gado.setNombre(rs.getString("grado_nombre"));
                gado.setAbreviatura(rs.getString("abreviatura_grado"));
                curso.setGrado(gado);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return curso;
    }

    @Override
    public ArrayList<Curso> listarTodos() {
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_CURSOS", null);
        ArrayList<Curso> lista = new ArrayList<>();
        try {
            while (rs.next()) {
                Curso curso = new Curso();
                curso.setAbreviatura(rs.getString("curso_abreviatura"));
                // curso.setActivo(rs.getInt("activo"));
                curso.setNombre(rs.getString("curso_nombre"));
                curso.setDescripcion(rs.getString("descripcion"));
                curso.setHoras_semanales(rs.getInt("horas_semanales"));
                curso.setCurso_id(rs.getInt("curso_id"));

                GradoAcademico gado = new GradoAcademico();
                gado.setGrado_academico_id(rs.getInt("GRADO_ACADEMICO_ID"));
                gado.setNombre(rs.getString("grado_nombre"));
                gado.setAbreviatura(rs.getString("abreviatura_grado"));
                curso.setGrado(gado);
                lista.add(curso);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return lista;
    }

    
    @Override
    public ArrayList<Curso> buscarCurso(String nombre, String abreviatura, String nombreGrado) {
        
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, nombre);
        in.put(2, abreviatura);
        in.put(3, nombreGrado);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_CURSO_POR_NOMBRE_ABREVIATURA_GRADO_ACADEMICO", in);
        ArrayList<Curso> lista = new ArrayList<>();

        try {

            while (rs != null && rs.next()) {
                Curso c = new Curso();
                c.setCurso_id(rs.getInt("CURSO_ID"));
                c.setNombre(rs.getString("NOMBRE"));
                c.setAbreviatura(rs.getString("ABREVIATURA"));
                c.setHoras_semanales(rs.getInt("HORAS_SEMANALES"));

                GradoAcademico g = new GradoAcademico();
                g.setNombre(rs.getString("NOMBRE_GRADO"));
                c.setGrado(g);

                lista.add(c);
            }
        } catch (SQLException ex) {
            System.out.println("Error en BUSCAR_CURSO...: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvió null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }


}
