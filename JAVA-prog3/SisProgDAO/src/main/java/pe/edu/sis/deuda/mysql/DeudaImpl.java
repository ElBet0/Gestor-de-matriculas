/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.mysql;

import pe.edu.sis.alumno.dao.AlumnoDAO;
import pe.edu.sis.alumno.mysql.AlumnoImpl;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.deuda.dao.DeudaDAO;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.TipoDeuda;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author seinc
 */
public class DeudaImpl implements DeudaDAO{
    private ResultSet rs;
    @Override
    public int insertar(Deuda deu) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,deu.getMonto());
        in.put(3,deu.getConcepto_deuda().toString());
        in.put(4,new Date(deu.getFecha_emision().getTime()));
        in.put(5,new Date(deu.getFecha_vencimiento().getTime()));
        in.put(6,deu.getDescripcion());
        in.put(7,deu.getDescuento());
        in.put(8,deu.getAlumno().getAlumno_id());
        if(DbManager.getInstance().ejecutarProcedimiento("INSERTAR_DEUDA",in,out) < 0) return -1;
        deu.setDeuda_id((int)out.get(1));
        System.out.println("Se ha realizado el registro de la deuda");
        return deu.getDeuda_id();
    }

    @Override
    public int modificar(Deuda deu) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,deu.getDeuda_id());
        in.put(2,deu.getMonto());
        in.put(3,deu.getConcepto_deuda().toString());
        in.put(4,new Date(deu.getFecha_emision().getTime()));
        in.put(5,new Date(deu.getFecha_vencimiento().getTime()));
        in.put(6,deu.getDescripcion());
        in.put(7,deu.getDescuento());
        in.put(8,deu.getAlumno().getAlumno_id());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_DEUDA",in,null);
        System.out.println("Se ha realizado la modificación de la deuda");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_DEUDA", in, null);
        System.out.println("Se ha realizado la eliminacion del alumno");
        return resultado;
    }

    @Override
    public Deuda obtener_por_id(int pos) {
        Deuda deu=null;
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        AlumnoDAO al=new AlumnoImpl();
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_DEUDA_POR_ID", in);
        int al_id=0;
        try{
            if(rs.next()){
                deu = new Deuda();
                deu.setDeuda_id(rs.getInt("deuda_id"));
//                deu.setMonto(rs.getDouble("monto"));
//                deu.setConcepto_deuda(TipoDeuda.valueOf(rs.getString("tipo_deuda")));
                deu.setFecha_emision(rs.getDate("fecha_emision"));
                deu.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                deu.setDescripcion(rs.getString("descripcion"));
                deu.setDescuento(rs.getDouble("descuento"));
                al_id=rs.getInt("alumno_id");
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }catch( NullPointerException nul){
            System.out.println("Error en ejecucion de Procedure ");
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        if(deu == null) return null;

        deu.setAlumno(al.obtener_por_id(al_id));

        return deu;
    }

    @Override
    public ArrayList<Deuda> listarTodos() {
        ArrayList<Deuda> deuda = new ArrayList<>();
        AlumnoDAO al=new AlumnoImpl();
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_DEUDAS", null);
        ArrayList<Integer> al_id=new ArrayList<>();
        try{
            while(rs.next()){
                Deuda deu=new Deuda();
                deu.setDeuda_id(rs.getInt("deuda_id"));
                deu.setMonto(rs.getDouble("monto"));
//                deu.setConcepto_deuda(TipoDeuda.valueOf(rs.getString("tipo_deuda")));
                deu.setFecha_emision(rs.getDate("fecha_emision"));
                deu.setFecha_vencimiento(rs.getDate("fecha_vencimiento"));
                deu.setDescripcion(rs.getString("descripcion"));
                deu.setDescuento(rs.getDouble("descuento"));
                al_id.add(rs.getInt("alumno_id"));
                deuda.add(deu);
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }catch( NullPointerException nul){
            System.out.println("Error en ejecucion de Procedure ");
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        for(int i=0;i<al_id.size();i++)
            deuda.get(i).setAlumno(al.obtener_por_id((int) al_id.get(i)));
        return deuda;
    }
    
}
