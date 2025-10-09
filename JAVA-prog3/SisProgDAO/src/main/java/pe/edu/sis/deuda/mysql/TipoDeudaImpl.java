package pe.edu.sis.deuda.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.deuda.dao.TipoDeudaDAO;
import pe.edu.sis.model.deuda.TipoDeuda;

public class TipoDeudaImpl implements TipoDeudaDAO {
    private ResultSet rs;

    @Override
    public int insertar(TipoDeuda tipo) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, tipo.getDescripcion());
        in.put(3, tipo.getMonto_general());
        if (DbManager.getInstance().ejecutarProcedimiento("INSERTAR_TIPO_DEUDA", in, out) < 0)
            return -1;

        tipo.setId_tipo_deuda((int) out.get(1));
        System.out.println("Se ha realizado el registro del tipo de deuda");
        return tipo.getId_tipo_deuda();
    }

    @Override
    public int modificar(TipoDeuda tipo) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, tipo.getId_tipo_deuda());
        in.put(2, tipo.getDescripcion());
        in.put(3, tipo.getMonto_general());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_TIPO_DEUDA", in, null);

        System.out.println("Se ha realizado la modificacion del tipo de deuda");
        return resultado;
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_TIPO_DEUDA", in, null);
        System.out.println("Se ha realizado la eliminacion del tipo de deuda");
        return resultado;
    }

    @Override
    public TipoDeuda obtener_por_id(int idObjeto) {
        TipoDeuda td = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_TIPO_DEUDA_POR_ID", in);
        try {
            if (rs.next()) {
                td = new TipoDeuda(
                        rs.getString("descripcion"),
                        rs.getDouble("monto_general"));

                td.setId_tipo_deuda(rs.getInt("id_tipo_deuda"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error en ejecucion de Procedure ");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return td;
    }

    @Override
    public ArrayList<TipoDeuda> listarTodos() {
        ArrayList<TipoDeuda> lista = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_TIPOS_DEUDA", null);
        try {
            while (rs.next()) {
                TipoDeuda td = new TipoDeuda(
                        rs.getString("descripcion"),
                        rs.getDouble("monto_general"));

                td.setId_tipo_deuda(rs.getInt("id_tipo_deuda"));
                lista.add(td);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error en ejecucion de Procedure ");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }

}
