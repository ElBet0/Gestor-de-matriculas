package pe.edu.sis.notas.mysql;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gracademico.dao.GradoDAO;
import pe.edu.sis.gracademico.mysql.GradoImpl;
import pe.edu.sis.matricula.mysql.MatriculaImpl;
import pe.edu.sis.model.notas.Bimestre;
import pe.edu.sis.notas.dao.BimestreDAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class BimestreImpl implements BimestreDAO {
    ResultSet rs;

    @Override
    public int insertar(Bimestre bimestre) {
//        Map<Integer, Object> in = new HashMap<>();
//        Map<Integer, Object> out = new HashMap<>();

//        Quiero asumir que el INSERTAR_BIMESTRE pide a todos los id que tiene enlazado

//        out.put(1, Types.INTEGER);
//        in.put(2, bimestre.getFecha_inicio());
//        in.put(3, bimestre.getFecha_fin());
//        in.put(4, bimestre.getDescripcion());
//        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_BIMESTRE", in, out);
//        bimestre.setBimestre_id((int) out.get(1));
//        System.out.println("Se ha realizado el registro del Bimestre: " + bimestre.getBimestre_id());
//        return bimestre.getBimestre_id();
        return -1;
    }

    @Override
    public int modificar(Bimestre bimestre) {
//        Map<Integer, Object> in = new HashMap<>();
//        in.put(1, bimestre.getBimestre_id());
//        in.put(2, bimestre.getFecha_inicio());
//        in.put(3, bimestre.getFecha_fin());
//        in.put(4, bimestre.getFecha_fin());
//        in.put(5, bimestre.getActivo());
//        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_BIMESTRE", in, null);
//        System.out.println("Se ha modificado el registro del Bimestre: " + bimestre.getBimestre_id());
//        return resultado;
        return -1;
    }

    @Override
    public int eliminar(int idObjeto) {
//        Map<Integer, Object> in = new HashMap<>();
//        in.put(1, idObjeto);
//        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_MATRICULA", in, null);
//        System.out.println("Se ha eliminado el registro del Bimestre: " + idObjeto);
//        return resultado;
        return -1;
    }

    @Override
    public Bimestre obtener_por_id(int idObjeto) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_BIMESTRE_POR_ID", in);
        Bimestre bimestre = null;
        try {
            if (rs.next()) {
                //TO DO: cambiar esta wbd, paz no deja

            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return bimestre;
    }

    @Override
    public ArrayList<Bimestre> listarTodos() {
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_BIMESTRES", null);
        ArrayList<Bimestre> lista=new ArrayList<>();
        try {
            if (rs.next()) {

            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }
}
