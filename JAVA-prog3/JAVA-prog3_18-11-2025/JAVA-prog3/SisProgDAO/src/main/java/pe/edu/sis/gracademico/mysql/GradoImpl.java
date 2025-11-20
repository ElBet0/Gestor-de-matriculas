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
import pe.edu.sis.gracademico.dao.GradoDAO;
import pe.edu.sis.model.deuda.MedioPago;
import pe.edu.sis.model.deuda.Pago;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;

/**
 *
 * @author seinc
 */
public class GradoImpl implements GradoDAO {
    private ResultSet rs;

    @Override
    public int insertar(GradoAcademico grado) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, grado.getNombre());
        in.put(3, grado.getAbreviatura());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_GRADO_ACADEMICO", in, out) < 0)
            return -1;
        grado.setGrado_academico_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del Grado Academico");
        return grado.getGrado_academico_id();
    }

    @Override
    public int modificar(GradoAcademico grado) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, grado.getGrado_academico_id());
        in.put(2, grado.getNombre());
        in.put(3, grado.getAbreviatura());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_GRADO_ACADEMICO", in, null);
        System.out.println("Se ha realizado la modificacion del Grado Academico");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_GRADO_ACADEMICO", in, null);
        System.out.println("Se ha realizado la eliminacion del Grado Academico");
        return resultado;
    }

    @Override
    public GradoAcademico obtener_por_id(int pos) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, pos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_GRADO_ACADEMICO_POR_ID", in);
        GradoAcademico grado = new GradoAcademico();
        try {
            while (rs.next()) {
                grado.setAbreviatura(rs.getString("abreviatura"));
                grado.setGrado_academico_id(rs.getInt("grado_academico_id"));
                grado.setNombre(rs.getString("nombre"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error en ejecucion de Procedure ");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return grado;
    }

    @Override
    public ArrayList<GradoAcademico> listarTodos() {
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_GRADOS_ACADEMICOS", null);
        ArrayList<GradoAcademico> lista = new ArrayList<>();
        try {
            while (rs.next()) {
                GradoAcademico grado = new GradoAcademico();
                grado.setAbreviatura(rs.getString("abreviatura"));
                grado.setGrado_academico_id(rs.getInt("grado_academico_id"));
                grado.setNombre(rs.getString("nombre"));
                lista.add(grado);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }
    
    
    @Override
    public GradoAcademico buscarPorNombreOAbreviatura(String abreviatura, String nombre) {
         Map<Integer, Object> in = new HashMap<>();
        in.put(1, abreviatura);
        in.put(2, nombre);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_GRADO_ACADEMICO_POR_NOMBRE_O_ABREVIATURA", in);
        GradoAcademico 
                g = new GradoAcademico();

        try {
            if (rs.next()) {
                g.setGrado_academico_id(rs.getInt("grado_academico_id"));
                g.setNombre(rs.getString("nombre"));
                g.setAbreviatura(rs.getString("abreviatura"));

            }
        } catch (SQLException ex) {
            System.out.println("Error en BUSCAR_GRADO_ACADEMICO...: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvió null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return g;
    }
    
    @Override
     public ArrayList<Aula> listarAulasPorGrado(int idGradoAcademico) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idGradoAcademico);
        ArrayList<Aula> lista = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_AULAS_POR_GRADO_ACADEMICO", in);
        try {
            while (rs.next()) {
                Aula a = new Aula();
                a.setAula_id(rs.getInt("ID_AULA"));
                a.setNombre(rs.getString("NOMBRE"));
                lista.add(a);
            }
        } catch (SQLException ex) {
            System.out.println("Error en LISTAR_AULAS_POR_GRADO_ACADEMICO: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvió null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }

}

    
    
    
    
    
    
    
    

