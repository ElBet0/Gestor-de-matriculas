package pe.edu.sis.gracademico.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gracademico.dao.AulaDAO;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;

public class AulaImpl implements AulaDAO {

    private ResultSet rs;

    @Override
    public int insertar(Aula aula) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, aula.getNombre());
        in.put(3, aula.getGrado().getGrado_academico_id());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_AULA", in, out) < 0)
            return -1;
        aula.setAula_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del Aula");
        return aula.getAula_id();
    }

    @Override
    public int modificar(Aula aula) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, aula.getAula_id());
        in.put(2, aula.getNombre());
        in.put(3, aula.getGrado().getGrado_academico_id());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_AULA", in, null);
        System.out.println("Se ha realizado la modificacion del Aula");
        return resultado;
    }

    @Override
    public int eliminar(int id) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, id);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_AULA", in, null);
        System.out.println("Se ha realizado la eliminacion del Aula");
        return resultado;
    }

    @Override
    public Aula obtener_por_id(int id) {
        Aula aula = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, id);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_AULA_POR_ID", in);
        try {
            if (rs.next()) {
                aula = new Aula();
                aula.setAula_id(rs.getInt("aula_id"));
                aula.setNombre(rs.getString("NOMBRE_AULA"));

                GradoAcademico grado = new GradoAcademico();
                grado.setGrado_academico_id(rs.getInt("GRADO_ACADEMICO_ID"));
                grado.setNombre(rs.getString("NOMBRE_GRADO"));
                grado.setAbreviatura(rs.getString("ABREVIATURA_GRADO"));
                aula.setGrado(grado);
                aula.setActivo(rs.getInt("ACTIVO"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return aula;
    }

    @Override
    public ArrayList<Aula> listarTodos() {
        ArrayList<Aula> lista = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_AULAS", null);
        try {
            while (rs.next()) {
                Aula aula = new Aula();
                aula.setAula_id(rs.getInt("aula_id"));
                aula.setNombre(rs.getString("NOMBRE_AULA"));

                GradoAcademico grado = new GradoAcademico();
                grado.setGrado_academico_id(rs.getInt("GRADO_ACADEMICO_ID"));
                grado.setNombre(rs.getString("NOMBRE_GRADO"));
                grado.setAbreviatura(rs.getString("ABREVIATURA_GRADO"));
                aula.setGrado(grado);

                lista.add(aula);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return lista;
    }
    @Override
     public ArrayList<Aula> buscarAulaPorNombreONombreGrado(String nombreAula, String nombreGrado) {
         Map<Integer, Object> in = new HashMap<>();
        in.put(1, nombreAula);
        
        in.put(2, nombreGrado);
        
     
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_AULA_POR_NOMBRE_O_NOMBRE_GRADO", in);
        ArrayList<Aula> lista = new ArrayList<>();

        try {
            while (rs.next()) {
                Aula a = new Aula();
                a.setAula_id(rs.getInt("ID_AULA"));
                a.setNombre(rs.getString("NOMBRE"));

                GradoAcademico g = new GradoAcademico();
                g.setNombre(rs.getString("NOMBRE_GRADO"));
                a.setGrado(g);

                lista.add(a);
            }
        } catch (SQLException ex) {
            System.out.println("Error en BUSCAR_AULA_POR_NOMBRE_O_NOMBRE_GRADO: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvió null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;

     }
}
