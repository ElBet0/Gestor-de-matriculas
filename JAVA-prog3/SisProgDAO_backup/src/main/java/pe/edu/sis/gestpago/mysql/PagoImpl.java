/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gestpago.mysql;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gestdeuda.dao.DeudaDAO;
import pe.edu.sis.gestdeuda.mysql.DeudaImpl;
import pe.edu.sis.gestpago.dao.PagoDAO;
import pe.edu.sis.model.deuda.Medio;
import pe.edu.sis.model.deuda.Pago;
import pe.edu.sis.model.deuda.TipoDeuda;

/**
 *
 * @author seinc
 */
public class PagoImpl implements PagoDAO{
    private ResultSet rs;
    @Override
    public int insertar(Pago pago) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,pago.getMonto());
        in.put(3,new Date(pago.getFecha().getTime()));
        in.put(4,pago.getMedioPago().toString());
        in.put(5,pago.getObservaciones());
        in.put(6,pago.getDeuda().getDeuda_id());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_PAGO",in,out);
        pago.setPago_id((int)out.get(1));
        System.out.println("Se ha realizado el registro del pago");
        return pago.getPago_id();
    }

    @Override
    public int modificar(Pago pago) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pago.getPago_id());
        in.put(2,pago.getMonto());
        in.put(3,new Date(pago.getFecha().getTime()));
        in.put(4,pago.getMedioPago().toString());
        in.put(5,pago.getObservaciones());
        in.put(6,pago.getDeuda().getDeuda_id());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_PAGO",in,null);
        System.out.println("Se ha realizado la modificacion del pago");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_PAGO", in, null);
        System.out.println("Se ha realizado la eliminacion del pago");
        return resultado;
    }

    @Override
    public Pago obtener_por_id(int pos) {
        Pago pago=null;
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        DeudaDAO deu=new DeudaImpl();
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_PAGO_POR_ID", in);
        int id=0;
        try{
            while(rs.next()){
                if(pago == null) pago = new Pago();
                pago.setPago_id(rs.getInt("pago_id"));
                pago.setMonto(rs.getDouble("monto"));
                pago.setFecha(rs.getDate("fecha"));
                pago.setMedioPago(Medio.valueOf(rs.getString("medio")));
                pago.setObservaciones("observaciones");
                id=rs.getInt("deuda_id");
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        pago.setDeuda(deu.obtener_por_id(id));
        return pago;
    }

    @Override
    public ArrayList<Pago> listarTodos() {
        ArrayList<Pago> pago_lista=null;
        DeudaDAO deu=new DeudaImpl();
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_PAGOS", null);
        ArrayList<Integer>id=new ArrayList<>();
        try{
            while(rs.next()){
                if(pago_lista == null) pago_lista = new ArrayList<>();
                Pago pago=new Pago();
                pago.setPago_id(rs.getInt("pago_id"));
                pago.setMonto(rs.getDouble("monto"));
                pago.setFecha(rs.getDate("fecha"));
                pago.setMedioPago(Medio.valueOf(rs.getString("medio")));
                pago.setObservaciones("observaciones");
                id.add(rs.getInt("deuda_id"));
                pago_lista.add(pago);
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        for(int i=0;i<id.size();i++){
            pago_lista.get(i).setDeuda(deu.obtener_por_id((int)id.get(i)));
        }
        return pago_lista;
    }
    
}
