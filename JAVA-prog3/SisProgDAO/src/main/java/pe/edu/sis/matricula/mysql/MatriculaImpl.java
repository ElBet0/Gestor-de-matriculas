/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.matricula.dao.MatriculaDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoAcademico;
import pe.edu.sis.model.matricula.PeriodoXAula;

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
        in.put(3, matr.getPeriodo_Aula().getPeriodo_aula_id());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_MATRICULA", in, out) < 0)
            return -1;
        matr.setMatricula_id((int) out.get(1));
        System.out.println("Se ha realizado el registro de la Matricula");
        return matr.getMatricula_id();
    }

    @Override
    public int modificar(Matricula matr) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, matr.getMatricula_id());
        in.put(2, matr.getPeriodo_Aula().getPeriodo_aula_id());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_MATRICULA", in, null);
        System.out.println("Se ha realizado la modificacion de la Matricula");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_MATRICULA", in, null);
        System.out.println("Se ha realizado la baja de la Matricula");
        return resultado;
    }

    @Override
    public Matricula obtener_por_id(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_MATRICULA_POR_ID", in);
        Matricula mat = null;
        try {
            if (rs.next()) {
                mat = new Matricula();

                // ----- Familia -------
                Familia papis = new Familia();
                papis.setFamilia_id(rs.getInt("familia_id"));
                papis.setApellido_paterno(rs.getString("apellido_paterno"));
                papis.setApellido_materno(rs.getString("apellido_materno"));
                papis.setNumero_telefono(rs.getString("num_telf"));
                papis.setCorreo_electronico(rs.getString("correo_electronico"));
                papis.setDireccion(rs.getString("direccion"));

                // ---- Alumno (solo con ID de momento) ----
                Alumno al = new Alumno();
                al.setAlumno_id(rs.getInt("ALUMNO_ID"));
                al.setDni(rs.getInt("dni"));
                al.setNombre(rs.getString("nombre_alumno"));
                al.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                al.setFecha_ingreso(rs.getDate("fecha_ingreso"));
                al.setSexo(rs.getString("sexo").charAt(0));
                al.setReligion(rs.getString("religion"));
                al.setObservaciones(rs.getString("alumno_observacion"));
                al.setPension_base(rs.getDouble("pension_base"));
                al.setPadres(papis);

                // ---- Grado Académico ----
                GradoAcademico grado = new GradoAcademico();
                grado.setGrado_academico_id(rs.getInt("grado_academico_id"));
                grado.setNombre(rs.getString("grado_nombre"));
                grado.setAbreviatura(rs.getString("abreviatura"));

                // ---- Periodo Académico ----
                PeriodoAcademico per = new PeriodoAcademico();
                per.setPeriodo_academico_id(rs.getInt("periodo_academico_id"));
                per.setNombre(rs.getString("periodo_nombre"));
                per.setDescripcion(rs.getString("periodo_descripcion"));
                per.setFecha_inicio(rs.getDate("fecha_inicio"));
                per.setFecha_fin(rs.getDate("FECHA_FIN"));

                // ---- Aula ----
                Aula aula = new Aula();
                aula.setAula_id(rs.getInt("ID_AULA"));
                aula.setNombre(rs.getString("aula_nombre"));
                aula.setGrado(grado);

                // ---- Periodo x Aula ----
                PeriodoXAula pa = new PeriodoXAula();
                pa.setAula(aula);
                pa.setPeriodo(per);
                pa.setVacantes_disponibles(0);
                pa.setVacantes_ocupadas(0);

                // -----Matricula
                mat.setMatricula_id(pos);
                mat.setPeriodo_Aula(pa);
                mat.setAlumno(al);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error : rs devolvio null ");
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

                // ----- Familia -------
                Familia papis = new Familia();
                papis.setFamilia_id(rs.getInt("familia_id"));
                papis.setApellido_paterno(rs.getString("apellido_paterno"));
                papis.setApellido_materno(rs.getString("apellido_materno"));
                papis.setNumero_telefono(rs.getString("num_telf"));
                papis.setCorreo_electronico(rs.getString("correo_electronico"));
                papis.setDireccion(rs.getString("direccion"));

                // ---- Alumno (solo con ID de momento) ----
                Alumno al = new Alumno();
                al.setAlumno_id(rs.getInt("ALUMNO_ID"));
                al.setDni(rs.getInt("dni"));
                al.setNombre(rs.getString("nombre_alumno"));
                al.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                al.setFecha_ingreso(rs.getDate("fecha_ingreso"));
                al.setSexo(rs.getString("sexo").charAt(0));
                al.setReligion(rs.getString("religion"));
                al.setObservaciones(rs.getString("alumno_observacion"));
                al.setPension_base(rs.getDouble("pension_base"));
                al.setPadres(papis);

                // ---- Grado Académico ----
                GradoAcademico grado = new GradoAcademico();
                grado.setGrado_academico_id(rs.getInt("grado_academico_id"));
                grado.setNombre(rs.getString("grado_nombre"));
                grado.setAbreviatura(rs.getString("abreviatura"));

                // ---- Periodo Académico ----
                PeriodoAcademico per = new PeriodoAcademico();
                per.setPeriodo_academico_id(rs.getInt("periodo_academico_id"));
                per.setNombre(rs.getString("periodo_nombre"));
                per.setDescripcion(rs.getString("periodo_descripcion"));
                per.setFecha_inicio(rs.getDate("fecha_inicio"));
                per.setFecha_fin(rs.getDate("FECHA_FIN"));

                // ---- Aula ----
                Aula aula = new Aula();
                aula.setAula_id(rs.getInt("ID_AULA"));
                aula.setNombre(rs.getString("aula_nombre"));
                aula.setGrado(grado);

                // ---- Periodo x Aula ----
                PeriodoXAula pa = new PeriodoXAula();
                pa.setAula(aula);
                pa.setPeriodo(per);
                pa.setVacantes_disponibles(0);
                pa.setVacantes_ocupadas(0);

                // -----Matricula
                mat.setMatricula_id(rs.getInt("matricula_id"));
                mat.setPeriodo_Aula(pa);
                mat.setAlumno(al);

                lista.add(mat);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar matrículas: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error : rs devolvio null ");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return lista;
    }

}
