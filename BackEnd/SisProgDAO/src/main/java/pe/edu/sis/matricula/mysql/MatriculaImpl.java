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
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_MATRICULA", in, out) < 0) {
            return -1;
        }
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

                // ---- Alumno ----
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
                per.setFecha_fin(rs.getDate("fecha_fin"));

                // ---- Aula ----
                Aula aula = new Aula();
                aula.setAula_id(rs.getInt("ID_AULA"));
                aula.setNombre(rs.getString("aula_nombre"));
                aula.setGrado(grado);

                // ---- Periodo x Aula ----
                PeriodoXAula pa = new PeriodoXAula();
                pa.setPeriodo_aula_id(rs.getInt("PERIODO_AULA_ID"));
                pa.setAula(aula);
                pa.setPeriodo(per);

                // ✅ valores reales desde BD
                pa.setVacantes_disponibles(rs.getInt("VACANTES_DISPONIBLES"));
                pa.setVacantes_ocupadas(rs.getInt("VACANTES_OCUPADAS"));

                // ----- Matricula -----
                mat.setMatricula_id(rs.getInt("MATRICULA_ID")); // mejor que "pos"
                mat.setCosto_matricula(rs.getDouble("COSTO_MATRICULA"));
                mat.setCosto_pension(rs.getDouble("COSTO_PENSION"));
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
                mat.setCosto_matricula(rs.getDouble("COSTO_MATRICULA"));
                mat.setCosto_pension(rs.getDouble("COSTO_PENSION"));
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

    @Override
    public ArrayList<Matricula> BuscarAlumnos(int familia_id, String ape_pat, String ape_mat, String nombre, int dni, int anho) {
        ArrayList<Matricula> matriculas;
        matriculas = new ArrayList<>();
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, familia_id);
        in.put(2, ape_pat);
        in.put(3, ape_mat);
        in.put(4, nombre);
        in.put(5, dni);
        in.put(6, anho);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_ANIO_ALUMNOS_MAT", in);

        try {
            while (rs.next()) {
                Matricula mat = new Matricula();
                Familia fam = new Familia();
                Alumno al = new Alumno();
                PeriodoXAula per = new PeriodoXAula();
                PeriodoAcademico p = new PeriodoAcademico();
                fam.setApellido_paterno(rs.getString("apellido_paterno"));
                fam.setApellido_materno(rs.getString("apellido_materno"));
                al.setSexo(rs.getString("genero").charAt(0));
                al.setNombre(rs.getString("nombre"));
                p.setFecha_inicio(rs.getDate("anio"));
                per.setPeriodo_aula_id(rs.getInt("PERIODO_AULA_ID"));
                al.setAlumno_id(rs.getInt("ALUMNO_ID"));
                fam.setFamilia_id(rs.getInt("FAMILIA_ID"));

                al.setPadres(fam);
                per.setPeriodo(p);
                mat.setAlumno(al);
                mat.setPeriodo_Aula(per);

                matriculas.add(mat);
            }
        } catch (SQLException ex) {
            System.out.println("Error al listar matrículas: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error : rs devolvio null ");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return matriculas;
    }

    @Override
    public ArrayList<PeriodoXAula> listarAulasParaAsignarMatricula() {

        ArrayList<PeriodoXAula> lista = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_AULA_ASIGNAR_MATR", null);
        rs = DbManager.getInstance()
                .ejecutarProcedimientoLectura("LISTAR_AULA_ASIGNAR_MATR", null);
        try {
            while (rs.next()) {
                // ---- Grado ----
                GradoAcademico grado = new GradoAcademico();
                grado.setNombre(rs.getString("grado_nombre"));

                // ---- Aula ----
                Aula aula = new Aula();
                aula.setNombre(rs.getString("aula_nombre"));
                aula.setGrado(grado);

                // ---- Periodo x Aula ----
                PeriodoXAula pa = new PeriodoXAula();
                pa.setPeriodo_aula_id(rs.getInt("periodo_aula_id")); // si lo tienes en tu modelo
                pa.setAula(aula); //c chatgpt y sus fumadas
                pa.setVacantes_disponibles(rs.getInt("vacantes_disponibles"));
                pa.setVacantes_ocupadas(rs.getInt("vacantes_ocupadas"));

                lista.add(pa);
            }
        } catch (SQLException ex) {
            System.out.println("Error en LISTAR_AULA_ASIGNAR_MATR: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvió null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }

    @Override
    public int registrarMatriculaConVacantes(int alumno_id, int aula_id, 
            double costo_matricula, double costo_pension) {

        int periodoAulaId = 0;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, alumno_id);
        in.put(2, aula_id);
        in.put(3, costo_matricula);
        in.put(4, costo_pension);

        rs = DbManager.getInstance()
                .ejecutarProcedimientoLectura("REGISTRAR_MATRICULA_CON_VACANTES", in);

        try {
            if (rs != null && rs.next()) {
                periodoAulaId = rs.getInt("PERIODO_AULA_ID");
            }
        } catch (SQLException ex) {
            System.out.println("Error al registrar matrícula con vacantes: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvio null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return periodoAulaId; // si devuelve 0, es porque falló o SP lanzó error
    }

}
