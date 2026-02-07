/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.alumno.dao.FamiliaDAO;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

/**
 *
 * @author seinc
 */
public class FamiliaImpl implements FamiliaDAO {

    private ResultSet rs;

    @Override
    public int insertar(Familia familia) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();

        out.put(1, Types.INTEGER);
        in.put(2, familia.getApellido_paterno());
        in.put(3, familia.getApellido_materno());
        in.put(4, familia.getNumero_telefono());
        in.put(5, familia.getCorreo_electronico());
        in.put(6, familia.getDireccion());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_FAMILIA", in, out) < 0) {
            return -1;
        }
        familia.setFamilia_id((int) out.get(1));
        System.out.println("Se ha realizado el registro de la familia");
        return familia.getFamilia_id();
    }

    @Override
    public int modificar(Familia familia) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, familia.getFamilia_id());
        in.put(2, familia.getApellido_paterno());
        in.put(3, familia.getApellido_materno());
        in.put(4, familia.getNumero_telefono());
        in.put(5, familia.getCorreo_electronico());
        in.put(6, familia.getDireccion());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_FAMILIA", in, null);
        System.out.println("Se ha realizado la modificacion de la familia");
        return resultado;
    }

    @Override
    public int eliminar(int id) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, id);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_FAMILIA", in, null);
        System.out.println("Se ha realizado la eliminacion de la familia");
        return resultado;
    }

    @Override
    public Familia obtener_por_id(int id) {
        Familia fam = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, id);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_FAMILIA_POR_ID", in);
        try {
            if (rs.next()) {
                fam = new Familia();
                fam.setApellido_materno(rs.getString("apellido_materno"));
                fam.setApellido_paterno(rs.getString("apellido_paterno"));
                fam.setCorreo_electronico(rs.getString("correo_electronico"));
                fam.setDireccion(rs.getString("direccion"));
                fam.setFamilia_id(rs.getInt("familia_id"));
                fam.setNumero_telefono(rs.getString("num_telf"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return fam;
    }

    @Override
    public ArrayList<Familia> listarTodos() {
        ArrayList<Familia> familia = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_FAMILIAS", null);
        try {
            while (rs.next()) {
                Familia fam = new Familia();
                fam.setApellido_materno(rs.getString("apellido_materno"));
                fam.setApellido_paterno(rs.getString("apellido_paterno"));
                fam.setCorreo_electronico(rs.getString("correo_electronico"));
                fam.setDireccion(rs.getString("direccion"));
                fam.setFamilia_id(rs.getInt("familia_id"));
                fam.setNumero_telefono(rs.getString("num_telf"));
                familia.add(fam);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return familia;
    }

    @Override
    public ArrayList<Familia> BuscarFamilia(String ape_pat, String ape_mat) {
        ArrayList<Familia> f=new ArrayList<>();
        Familia fam = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, ape_pat);
        in.put(2, ape_mat);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_FAMILIA", in);
        try {
            while (rs.next()) {
                fam = new Familia();
                fam.setApellido_materno(rs.getString("apellido_materno"));
                fam.setApellido_paterno(rs.getString("apellido_paterno"));
                fam.setFamilia_id(rs.getInt("familia_id"));
                f.add(fam);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return f;
    }

    @Override
    public ArrayList<Alumno> ObtenerHijos(int familia_id) {
        ArrayList<Alumno> alumnos = new ArrayList<>();
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, familia_id);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_HIJOS_FAMILIA", in);
        try {
            while (rs.next()) {
                Alumno al = new Alumno();
                al.setAlumno_id(rs.getInt("alumno_id"));
                al.setNombre(rs.getString("nombre_alumno"));
                al.setDni(rs.getInt("dni"));
                al.setSexo(rs.getString("sexo").charAt(0));
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
}
