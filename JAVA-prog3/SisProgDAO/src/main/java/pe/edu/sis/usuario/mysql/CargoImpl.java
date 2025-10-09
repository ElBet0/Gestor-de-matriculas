package pe.edu.sis.usuario.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.model.usuario.Cargo;
import pe.edu.sis.usuario.dao.CargoDAO;

public class CargoImpl implements CargoDAO {
    private ResultSet rs;

    @Override
    public int insertar(Cargo cargo) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, cargo.getNombre());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_CARGO", in, out);
        cargo.setCargo_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del cargo");
        return cargo.getCargo_id();
    }

    @Override
    public int modificar(Cargo cargo) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, cargo.getCargo_id());
        in.put(2, cargo.getNombre());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_CARGO", in, null);
        System.out.println("Se ha realizado la modificacion del cargo");
        return resultado;
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_CARGO", in, null);
        System.out.println("Se ha realizado la eliminacion del cargo");
        return resultado;
    }

    @Override
    public Cargo obtener_por_id(int idObjeto) {
        Cargo cargo = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_CARGO_POR_ID", in);
        try {
            while (rs.next()) {
                cargo = new Cargo();
                cargo.setCargo_id(rs.getInt("ID_CARGO"));
                cargo.setNombre(rs.getString("nombre"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return cargo;
    }

    @Override
    public ArrayList<Cargo> listarTodos() {
        ArrayList<Cargo> cargos = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_CARGOS", null);
        try {
            while (rs.next()) {
                Cargo cargo = new Cargo();
                cargo.setCargo_id(rs.getInt("ID_CARGO"));
                cargo.setNombre(rs.getString("nombre"));
                cargos.add(cargo);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return cargos;
    }
}
