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
import pe.edu.sis.deuda.dao.PagoDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.MedioPago;
import pe.edu.sis.model.deuda.Pago;
import pe.edu.sis.model.deuda.TipoDeuda;

/**
 *
 * @author seinc
 */
public class PagoImpl implements PagoDAO {
    private ResultSet rs;

    @Override
    public int insertar(Pago pago) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, pago.getMonto());
        in.put(3, new Date(pago.getFecha().getTime()));
        in.put(4, pago.getMedio().toString());
        in.put(5, pago.getObservaciones());
        in.put(6, pago.getDeuda().getDeuda_id());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_PAGO", in, out) < 0)
            return -1;
        pago.setPago_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del pago");
        return pago.getPago_id();
    }

    @Override
    public int modificar(Pago pago) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pago.getPago_id());
        in.put(2, pago.getMonto());
        in.put(3, new Date(pago.getFecha().getTime()));
        in.put(4, pago.getMedio().toString());
        in.put(5, pago.getObservaciones());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_PAGO", in, null);
        System.out.println("Se ha realizado la modificacion del pago");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_PAGO", in, null);
        System.out.println("Se ha realizado la eliminacion del pago");
        return resultado;
    }

    @Override
    public Pago obtener_por_id(int pos) {
        Pago pago = null;

        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_PAGO_POR_ID", in);

        int deuda_id = -1;
        try {
            if (rs.next()) {
                pago = new Pago(
                        rs.getDouble("monto"),
                        rs.getDate("fecha"),
                        MedioPago.valueOf(rs.getString("medio")),
                        rs.getString("observaciones"),
                        null);

                pago.setPago_id(rs.getInt("pago_id"));
                deuda_id = rs.getInt("deuda_id");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        if (deuda_id != -1)
            pago.setDeuda(new DeudaImpl().obtener_por_id(deuda_id));

        return pago;
    }

    @Override
    public ArrayList<Pago> listarTodos() {
        ArrayList<Pago> pago_lista = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_PAGOS", null);
        try {
            while (rs.next()) {
                Deuda deu = new Deuda();
                deu.setDeuda_id(rs.getInt("deuda_id"));
                deu.setMonto(rs.getDouble("deuda_monto"));
                deu.setFecha_emision(rs.getDate("fecha_emision"));
                deu.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                deu.setDescripcion(
                        rs.getString("deuda_descripcion"));

                deu.setDescuento(rs.getDouble("descuento"));
                deu.setConcepto_deuda(
                        new TipoDeuda(
                                rs.getString("tipodeuda_descripcion"),
                                -1.0)); // No definido por flojos
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
                        rs.getString("alumno_observacion"),
                        rs.getDouble("pension_base"));

                alumno.setAlumno_id(rs.getInt("alumno_id"));
                deu.setAlumno(alumno);

                Pago pago = new Pago(
                        rs.getDouble("pago_monto"),
                        rs.getDate("fecha"),
                        MedioPago.valueOf(rs.getString("medio")),
                        rs.getString("pago_observacion"),
                        deu);

                pago.setPago_id(rs.getInt("pago_id"));
                pago_lista.add(pago);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecucion de Procedure " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return pago_lista;
    }
    
   
    @Override
    public ArrayList<Pago> listarPagosPorDeuda(int deudaId) {
        ArrayList<Pago> pagoLista = new ArrayList<>();
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, deudaId);

        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_PAGOS_POR_DEUDA", in);

        try {
            while (rs.next()) {

                // ====== Construcción de la DEUDA ======
                Deuda deu = new Deuda();
                deu.setDeuda_id(rs.getInt("deuda_id"));
                deu.setMonto(rs.getDouble("deuda_monto"));
                deu.setFecha_emision(rs.getDate("fecha_emision"));
                deu.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                deu.setDescripcion(rs.getString("deuda_descripcion"));
                deu.setDescuento(rs.getDouble("descuento"));

                TipoDeuda tipo = new TipoDeuda(
                        rs.getString("tipodeuda_descripcion"),
                        -1.0
                );
                tipo.setId_tipo_deuda(rs.getInt("id_tipo_deuda"));
                deu.setConcepto_deuda(tipo);

                // ====== Construcción de la FAMILIA ======
                Familia familia = new Familia(
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("num_telf"),
                        rs.getString("correo_electronico"),
                        rs.getString("direccion")
                );
                familia.setFamilia_id(rs.getInt("familia_id"));

                // ====== Construcción del ALUMNO ======
                Alumno alumno = new Alumno(
                        rs.getString("nombre"),
                        rs.getInt("dni"),
                        rs.getDate("fecha_nacimiento"),
                        rs.getDate("fecha_ingreso"),
                        rs.getString("sexo").charAt(0),
                        rs.getString("religion"),
                        familia,
                        rs.getString("alumno_observacion"),
                        rs.getDouble("pension_base")
                );
                alumno.setAlumno_id(rs.getInt("alumno_id"));

                deu.setAlumno(alumno);

                // ====== Construcción del PAGO ======
                Pago pago = new Pago(
                        rs.getDouble("pago_monto"),
                        rs.getDate("pago_fecha"),
                        MedioPago.valueOf(rs.getString("medio")),
                        rs.getString("pago_observacion"),
                        deu
                );

                pago.setPago_id(rs.getInt("pago_id"));

                pagoLista.add(pago);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception e) {
            System.out.println("Error en ejecución de LISTAR_PAGOS_POR_DEUDA: " + e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return pagoLista;
    }


    

}
