/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.matricula.dao.PeriodoDAO;
import pe.edu.sis.model.matricula.PeriodoAcademico;

/**
 *
 * @author seinc
 */
public class PeriodoImpl implements PeriodoDAO {
    private ResultSet rs;

    @Override
    public int insertar(PeriodoAcademico per) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, per.getNombre());
        in.put(3, per.getDescripcion());
        if(per.getFecha_inicio() == null){
            in.put(4, new java.sql.Date(per.getFecha_inicio().getTime()));           
        }else{
            in.put(4, new java.sql.Date(per.getFecha_inicio().getTime()));            
        }
        in.put(5, new java.sql.Date(per.getFecha_fin().getTime()));
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_PERIODO_ACADEMICO", in, out);
        per.setPeriodo_academico_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del Periodo Academico ");
        return per.getPeriodo_academico_id();
    }

    @Override
    public int modificar(PeriodoAcademico per) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, per.getPeriodo_academico_id());
        in.put(2, per.getNombre());
        in.put(3, per.getDescripcion());
        in.put(4, new Date(per.getFecha_inicio().getTime()));
        in.put(5, new Date(per.getFecha_fin().getTime()));
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_PERIODO_ACADEMICO", in, null);
        System.out.println("Se ha realizado la modificacion del Periodo Academico ");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_PERIODO_ACADEMICO", in, null);
        System.out.println("Se ha realizado la modificacion del Periodo Academico ");
        return resultado;
    }

    @Override
    public PeriodoAcademico obtener_por_id(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_PERIODO_ACADEMICO_POR_ID", in);
        PeriodoAcademico per = null;
        try {
            while (rs.next()) {
                per = new PeriodoAcademico();
                per.setPeriodo_academico_id(rs.getInt("periodo_academico_id"));
                per.setNombre(rs.getString("nombre"));
                per.setDescripcion(rs.getString("descripcion"));
                per.setFecha_inicio(rs.getDate("fecha_inicio"));
                per.setFecha_fin(rs.getDate("fecha_fin"));
                per.setActivo(rs.getInt("activo"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error en ejecucion de Procedure ");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return per;
    }

    @Override
    public ArrayList<PeriodoAcademico> listarTodos() {
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_PERIODOS_ACADEMICOS", null);
        ArrayList<PeriodoAcademico> lista = new ArrayList<>();
        try {
            while (rs.next()) {
                PeriodoAcademico per = new PeriodoAcademico();
                per.setPeriodo_academico_id(rs.getInt("periodo_academico_id"));
                per.setNombre(rs.getString("nombre"));
                per.setDescripcion(rs.getString("descripcion"));
                per.setFecha_inicio(rs.getDate("fecha_inicio"));
                per.setFecha_fin(rs.getDate("fecha_fin"));
                per.setActivo(rs.getInt("activo"));
                lista.add(per);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }
}
