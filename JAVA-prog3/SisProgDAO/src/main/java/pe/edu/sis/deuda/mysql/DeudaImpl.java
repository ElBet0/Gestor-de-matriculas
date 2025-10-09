/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.deuda.dao.DeudaDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.TipoDeuda;

/**
 *
 * @author seinc
 */
public class DeudaImpl implements DeudaDAO {
    private ResultSet rs;

    @Override
    public int insertar(Deuda deu) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, deu.getMonto());
        in.put(3, deu.getConcepto_deuda().getId_tipo_deuda());
        in.put(4, new Date(deu.getFecha_emision().getTime()));
        in.put(5, new Date(deu.getFecha_vencimiento().getTime()));
        in.put(6, deu.getDescripcion());
        in.put(7, deu.getDescuento());
        in.put(8, deu.getAlumno().getAlumno_id());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_DEUDA", in, out) < 0)
            return -1;
        deu.setDeuda_id((int) out.get(1));
        System.out.println("Se ha realizado el registro de la deuda");
        return deu.getDeuda_id();
    }

    @Override
    public int modificar(Deuda deu) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, deu.getDeuda_id());
        in.put(2, deu.getMonto());
        in.put(3, deu.getConcepto_deuda().getId_tipo_deuda());
        in.put(4, new Date(deu.getFecha_emision().getTime()));
        in.put(5, new Date(deu.getFecha_vencimiento().getTime()));
        in.put(6, deu.getDescripcion());
        in.put(7, deu.getDescuento());
        in.put(8, deu.getAlumno().getAlumno_id());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_DEUDA", in, null);
        System.out.println("Se ha realizado la modificación de la deuda");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_DEUDA", in, null);
        System.out.println("Se ha realizado la eliminacion del alumno");
        return resultado;
    }

    @Override
    public Deuda obtener_por_id(int pos) {
        Deuda deu = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_DEUDA_POR_ID", in);

        try {
            if (rs.next()) {
                deu = new Deuda();
                deu.setDeuda_id(rs.getInt("deuda_id"));
                deu.setMonto(rs.getDouble("monto"));
                deu.setFecha_emision(rs.getDate("fecha_emision"));
                deu.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                deu.setDescripcion(
                        rs.getString("descripcion"));

                deu.setDescuento(rs.getDouble("descuento"));
                deu.setConcepto_deuda(
                        new TipoDeuda(
                                rs.getString("descripcion"),
                                -1)); // No definido por flojos
                deu.getConcepto_deuda().setId_tipo_deuda(
                        -1); // No definido por flojos

                Familia familia = new Familia(
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("num_telf"),
                        rs.getString("correo_electronico"),
                        rs.getString("direccion"));

                familia.setFamilia_id(rs.getInt("familia_id"));

                Alumno alumno = new Alumno(
                        rs.getString("nombre"),
                        rs.getInt("dni"),
                        rs.getDate("fecha_nacimiento"),
                        rs.getDate("fecha_ingreso"),
                        rs.getString("sexo").charAt(0),
                        rs.getString("religion"),
                        familia,
                        rs.getString("observaciones"),
                        rs.getDouble("pension_base"));

                alumno.setAlumno_id(rs.getInt("alumno_id"));
                deu.setAlumno(alumno);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return deu;
    }

    @Override
    public ArrayList<Deuda> listarTodos() {
        ArrayList<Deuda> deuda = new ArrayList<>();

        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_DEUDAS", null);

        try {
            while (rs.next()) {
                Deuda deu = new Deuda();
                deu.setDeuda_id(rs.getInt("deuda_id"));
                deu.setMonto(rs.getDouble("monto"));
                deu.setFecha_emision(rs.getDate("fecha_emision"));
                deu.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                deu.setDescripcion(
                        rs.getString("descripcion"));

                deu.setDescuento(rs.getDouble("descuento"));
                deu.setConcepto_deuda(
                        new TipoDeuda(
                                rs.getString("descripcion"),
                                rs.getDouble("monto_general")));
                deu.getConcepto_deuda().setId_tipo_deuda(
                        rs.getInt("id_tipo_deuda"));

                Familia familia = new Familia(
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("num_telf"),
                        rs.getString("correo_electronico"),
                        rs.getString("direccion"));

                familia.setFamilia_id(rs.getInt("familia_id"));

                Alumno alumno = new Alumno(
                        rs.getString("nombre"),
                        rs.getInt("dni"),
                        rs.getDate("fecha_nacimiento"),
                        rs.getDate("fecha_ingreso"),
                        rs.getString("sexo").charAt(0),
                        rs.getString("religion"),
                        familia,
                        rs.getString("observaciones"),
                        rs.getDouble("pension_base"));

                alumno.setAlumno_id(rs.getInt("alumno_id"));
                deu.setAlumno(alumno);
                deuda.add(deu);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return deuda;
    }

}
