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
import pe.edu.sis.gracademico.mysql.GradoImpl;
import pe.edu.sis.matricula.dao.PeriodoXAulaDAO;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.matricula.PeriodoAcademico;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author seinc
 */
public class PeriodoXAulaImpl implements PeriodoXAulaDAO {
    private ResultSet rs;

    @Override
    public int insertar(PeriodoXAula pa) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, pa.getPeriodo().getPeriodo_academico_id());
        in.put(3, pa.getAula().getAula_id());
        in.put(4, pa.getVacantes_disponibles());
        in.put(5, pa.getVacantes_ocupadas());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_PERIODOxAULA", in, out) < 0)
            return -1;
        pa.setPeriodo_aula_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del Periodo por Aula ");
        return pa.getPeriodo_aula_id();
    }

    @Override
    public int modificar(PeriodoXAula pa) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pa.getPeriodo_aula_id());
        in.put(2, pa.getVacantes_disponibles());
        in.put(3, pa.getVacantes_ocupadas());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_PERIODOxAULA", in, null);
        System.out.println("Se ha realizado la modificacion del Periodo por Aula");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_PERIODO_ACADEMICO", in, null);
        System.out.println("Se ha realizado la eliminación del Periodo por Aula");
        return resultado;
    }

    @Override
    public PeriodoXAula obtener_por_id(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_PERIODOxAULA_POR_ID", in);
        PeriodoXAula pa = new PeriodoXAula();
        int grado_academico_id = -1;
        try {
            while (rs.next()) {
                pa.setPeriodo_aula_id(rs.getInt("PERIODO_AULA_ID"));
                pa.setVacantes_disponibles(rs.getInt("VACANTES_DISPONIBLES"));
                pa.setVacantes_ocupadas(rs.getInt("VACANTES_OCUPADAS"));

                PeriodoAcademico periodo = new PeriodoAcademico();
                periodo.setPeriodo_academico_id(rs.getInt("PERIODO_ACADEMICO_ID"));
                periodo.setNombre(rs.getString("NOMBRE_PERIODO"));
                periodo.setFecha_inicio(rs.getDate("FECHA_INICIO"));
                periodo.setFecha_fin(rs.getDate("FECHA_FIN"));

                Aula aula = new Aula(
                        rs.getString("NOMBRE_AULA"),
                        null,1 // Se omite el Grado para simplificar
                );

                aula.setAula_id(rs.getInt("ID_AULA"));

                grado_academico_id = rs.getInt("GRADO_ACADEMICO_ID");

                pa.setAula(aula);
                pa.setPeriodo(periodo);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        if (grado_academico_id != -1)
            pa.getAula().setGrado(new GradoImpl().obtener_por_id(grado_academico_id));

        return pa;
    }

    @Override
    public ArrayList<PeriodoXAula> listarTodos() {
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_PERIODOxAULA", null);
        ArrayList<PeriodoXAula> lista = new ArrayList<>();
        ArrayList<Integer> idsGrados = new ArrayList<>();
        try {
            while (rs.next()) {
                PeriodoXAula pa = new PeriodoXAula();
                pa.setPeriodo_aula_id(rs.getInt("PERIODO_AULA_ID"));
                pa.setVacantes_disponibles(rs.getInt("VACANTES_DISPONIBLES"));
                pa.setVacantes_ocupadas(rs.getInt("VACANTES_OCUPADAS"));

                PeriodoAcademico periodo = new PeriodoAcademico();
                periodo.setPeriodo_academico_id(rs.getInt("PERIODO_ACADEMICO_ID"));
                periodo.setNombre(rs.getString("NOMBRE_PERIODO"));
                periodo.setFecha_inicio(rs.getDate("FECHA_INICIO"));
                periodo.setFecha_fin(rs.getDate("FECHA_FIN"));

                Aula aula = new Aula(
                        rs.getString("NOMBRE_AULA"),
                        null,1 // Se omite el Grado para simplificar
                );

                aula.setAula_id(rs.getInt("ID_AULA"));

                pa.setAula(aula);
                pa.setPeriodo(periodo);

                idsGrados.add(rs.getInt("GRADO_ACADEMICO_ID"));
                lista.add(pa);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return lista;
    }

}
