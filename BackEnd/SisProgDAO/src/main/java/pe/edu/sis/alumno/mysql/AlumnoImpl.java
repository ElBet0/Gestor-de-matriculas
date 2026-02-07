/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.alumno.dao.AlumnoDAO;
import pe.edu.sis.alumno.dao.FamiliaDAO;
import pe.edu.sis.db.bd.DbManager;
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
public class AlumnoImpl implements AlumnoDAO {
    private ResultSet rs;

    @Override
    public int insertar(Alumno al) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, al.getDni());
        in.put(3, al.getNombre());
        if (al.getFecha_nacimiento() == null) {
            in.put(4, new java.sql.Date(System.currentTimeMillis()));
        } else {
            in.put(4, new java.sql.Date(al.getFecha_nacimiento().getTime()));
        }

        if (al.getFecha_ingreso() == null) {
            in.put(5, new java.sql.Date(System.currentTimeMillis()));
        } else {
            in.put(5, new java.sql.Date(al.getFecha_ingreso().getTime()));
        }

        in.put(6, al.getSexo());
        in.put(7, al.getReligion());
        in.put(8, al.getObservaciones());
        in.put(9, al.getPension_base());
        in.put(10, al.getPadres().getFamilia_id());
        
//        System.out.println("====== DEBUG insertarAlumno ======");
//        System.out.println("Nombre: " + al.getNombre());
//        System.out.println("DNI: " + al.getDni());
//        System.out.println("Familia: " + (al.getPadres() == null ? "NULL" : al.getPadres().getFamilia_id()));
//        System.out.println("Sexo: " + al.getSexo());
//        System.out.println("Fecha Nac: " + al.getFecha_nacimiento());
//        System.out.println("Fecha Ingreso: " + al.getFecha_ingreso());
//        System.out.println("=================================");
        
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_ALUMNO", in, out) < 0)
            return -1;
        al.setAlumno_id((int) out.get(1));
        
        
        
        System.out.println("Se ha realizado el registro del alumno");
        return al.getAlumno_id();
    }

    @Override
    public int modificar(Alumno al) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, al.getAlumno_id());
        in.put(2, al.getDni());
        in.put(3, al.getNombre());
        in.put(4, new Date(al.getFecha_nacimiento().getTime()));
        in.put(5, new Date(al.getFecha_ingreso().getTime()));
        in.put(6, al.getSexo());
        in.put(7, al.getReligion());
        in.put(8, al.getObservaciones());
        in.put(9, al.getPension_base());
        in.put(10, al.getPadres().getFamilia_id());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_ALUMNO", in, null);
        System.out.println("Se ha realizado la modificacion del alumno");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_ALUMNO", in, null);
        System.out.println("Se ha realizado la eliminacion del alumno");
        return resultado;
    }

    @Override
    public Alumno obtener_por_id(int pos) {
        Alumno al = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_ALUMNO_POR_ID", in);
        FamiliaDAO fam = new FamiliaImpl();
        int fam_id = 0;
        try {
            if (rs.next()) {
                al = new Alumno();
                al.setAlumno_id(rs.getInt("alumno_id"));
                al.setDni(rs.getInt("dni"));
                al.setFecha_ingreso(rs.getDate("fecha_ingreso"));
                al.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                al.setNombre(rs.getString("nombre"));
                al.setObservaciones(rs.getString("observaciones"));
                fam_id = rs.getInt("familia_id");
                al.setPension_base(rs.getDouble("pension_base"));
                al.setReligion(rs.getString("religion"));
                al.setSexo(rs.getString("sexo").charAt(0));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        if (al == null)
            return null;

        al.setPadres(fam.obtener_por_id(fam_id));
        return al;
    }

    @Override
    public ArrayList<Alumno> listarTodos() {
        ArrayList<Alumno> alumno = new ArrayList<>();
        Map<Integer, Object> in = new HashMap<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_ALUMNOS", in);
        FamiliaDAO fam = new FamiliaImpl();
        ArrayList<Integer> ids = new ArrayList<>();
        try {
            while (rs.next()) {
                Alumno al = new Alumno();
                Familia f = new Familia();
                al.setAlumno_id(rs.getInt("alumno_id"));
                al.setDni(rs.getInt("dni"));
                al.setFecha_ingreso(rs.getDate("fecha_ingreso"));
                al.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                al.setNombre(rs.getString("nombre"));
                al.setObservaciones(rs.getString("observaciones"));
                ids.add(rs.getInt("familia_id"));
                al.setPension_base(rs.getDouble("pension_base"));
                al.setReligion(rs.getString("religion"));
                al.setSexo(rs.getString("sexo").charAt(0));
                
                f.setFamilia_id(rs.getInt("familia_id"));
                f.setApellido_paterno(rs.getString("apellido_paterno"));
                f.setApellido_materno(rs.getString("apellido_materno"));
                f.setNumero_telefono(rs.getString("num_telf"));
                f.setNumero_telefono(rs.getString("correo_electronico"));
                f.setNumero_telefono(rs.getString("direccion"));
                
                al.setPadres(f);
                
                alumno.add(al);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return alumno;
    }

    @Override
    public ArrayList<Alumno> BuscarAlumno(int familia_id, String ape_pat, String ape_mat, String nombre, int dni) {
        ArrayList<Alumno> alumnos = new ArrayList<>();
        Familia fam;
        Alumno al;
        Map<Integer, Object> in = new HashMap<>();

        in.put(1, familia_id);
        in.put(2, ape_pat);
        in.put(3, ape_mat);
        in.put(4, nombre);
        in.put(5, dni);
        
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_ALUMNO", in);
        try {
            while (rs.next()) {
                al = new Alumno();
                fam= new Familia();
                fam.setFamilia_id(rs.getInt("familia_id"));
                fam.setApellido_paterno(rs.getString("apellido_paterno"));
                fam.setApellido_materno(rs.getString("apellido_materno"));
                al.setSexo(rs.getString("sexo").charAt(0));
                al.setNombre(rs.getString("nombre"));
                al.setDni(rs.getInt("dni"));
                al.setAlumno_id(rs.getInt("alumno_id"));
                al.setPadres(fam);
                alumnos.add(al);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        
        return alumnos;  

    }

    @Override
    public ArrayList<Matricula> ConsultarMatriculas(int alumno_id) {
        ArrayList<Matricula> matriculas=new ArrayList<Matricula>();
        Matricula mat=null;
        GradoAcademico grad=null;
        Aula au=null;
        PeriodoAcademico per=null;
        PeriodoXAula p=null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, alumno_id);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("CONSULTAR_MATRICULA_ALUMNO", in);
        try {
            while (rs.next()) {
                matriculas=new ArrayList<Matricula>();
                mat = new Matricula();
                grad= new GradoAcademico();
                au=new Aula();
                per=new PeriodoAcademico();
                p=new PeriodoXAula();
                per.setFecha_inicio(rs.getDate("fecha"));
                per.setNombre(rs.getString("periodo_nombre"));
                mat.setActivo(rs.getInt("activo"));
                grad.setNombre(rs.getString("grado_nombre"));
                au.setNombre(rs.getString("aula_nombre"));
                au.setGrado(grad);
                p.setAula(au);
                p.setPeriodo(per);
                mat.setPeriodo_Aula(p);
                matriculas.add(mat);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return matriculas;
    }
    
}
