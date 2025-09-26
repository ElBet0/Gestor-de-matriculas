/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gestmatricula.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gestmatricula.dao.MatriculaDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.grAcademico.GradoAcademico;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoAcademico;

/**
 *
 * @author seinc
 */
public class MatriculaImpl implements MatriculaDAO {

    private ResultSet rs;

    @Override
    public int insertar(Matricula matr) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, matr.getAlumno().getAlumno_id());
        in.put(3, matr.getGrado().getGrado_academico_id());
        in.put(4, matr.getPeriodo().getPeriodo_academico_id());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_MATRICULA", in, out);
        matr.setMatricula_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del Grado Academico");
        return matr.getMatricula_id();
    }

    @Override
    public int modificar(Matricula matr) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, matr.getMatricula_id());
        in.put(2, matr.getAlumno().getAlumno_id());
        in.put(3, matr.getGrado().getGrado_academico_id());
        in.put(4, matr.getPeriodo().getPeriodo_academico_id());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_MATRICULA", in, null);
        System.out.println("Se ha realizado el registro del Grado Academico");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_MATRICULA", in, null);
        System.out.println("Se ha realizado el registro del Grado Academico");
        return resultado;
    }

    @Override
    public Matricula obtener_por_id(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_MATRICULA_POR_ID", in);
        Matricula mat = new Matricula();
        int id_alumno, id_grado, id_periodo;
        try {
            while (rs.next()) {
                mat = new Matricula();

                // ---- Matricula ----
                mat.setMatricula_id(rs.getInt("matricula_id"));
                mat.setEstado(rs.getInt("estado"));

                // ---- Alumno (solo con ID de momento) ----
                Alumno al = new Alumno();
                al.setAlumno_id(rs.getInt("alumno_id"));
                mat.setAlumno(al);

                // ---- Grado Académico ----
                GradoAcademico grado = new GradoAcademico();
                grado.setGrado_academico_id(rs.getInt("grado_academico_id"));
                grado.setNombre(rs.getString("grado"));
                mat.setGrado(grado);

                // ---- Periodo Académico ----
                PeriodoAcademico per = new PeriodoAcademico();
                per.setPeriodo_academico_id(rs.getInt("periodo_academico_id"));
                per.setNombre(rs.getString("periodo"));
                mat.setPeriodo(per);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return mat;
    }

    @Override
    public ArrayList<Matricula> listarTodos() {
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_MATRICULAS", null);
        ArrayList<Matricula> lista = new ArrayList<>();

        try {
            while (rs.next()) {
                Matricula mat = new Matricula();

                // ---- Matricula ----
                mat.setMatricula_id(rs.getInt("matricula_id"));
                mat.setEstado(rs.getInt("estado"));

                // ---- Alumno (solo con ID de momento) ----
                Alumno al = new Alumno();
                al.setAlumno_id(rs.getInt("alumno_id"));
                mat.setAlumno(al);

                // ---- Grado Académico ----
                GradoAcademico grado = new GradoAcademico();
                grado.setGrado_academico_id(rs.getInt("grado_academico_id"));
                grado.setNombre(rs.getString("grado"));
                mat.setGrado(grado);

                // ---- Periodo Académico ----
                PeriodoAcademico per = new PeriodoAcademico();
                per.setPeriodo_academico_id(rs.getInt("periodo_academico_id"));
                per.setNombre(rs.getString("periodo"));
                mat.setPeriodo(per);

                lista.add(mat);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar matrículas: " + ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return lista;
    }

}
