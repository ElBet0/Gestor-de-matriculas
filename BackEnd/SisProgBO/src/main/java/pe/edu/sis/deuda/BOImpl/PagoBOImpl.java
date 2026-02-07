/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.deuda.BO.PagoBO;
import pe.edu.sis.deuda.dao.PagoDAO;
import pe.edu.sis.deuda.mysql.PagoImpl;
import pe.edu.sis.model.deuda.Pago;

/**
 *
 * @author sdelr
 */
public class PagoBOImpl implements PagoBO{
    PagoDAO pago;

    public PagoBOImpl() {
        pago=new PagoImpl();
    }
    
    @Override
    public int insertar(Pago objeto) throws Exception {
        validar(objeto);
        objeto.setPago_id(pago.insertar(objeto));
        return objeto.getPago_id();
    }

    @Override
    public int modificar(Pago objeto) throws Exception {
        validar(objeto);
        return pago.modificar(objeto);
        
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return pago.eliminar(Idobjeto);
    }

    @Override
    public Pago obtenerPorId(int Idobjeto) throws Exception {
        Pago p;
        p = pago.obtener_por_id(Idobjeto);
        return p;
    }

    @Override
    public ArrayList<Pago> listarTodos() throws Exception {
        ArrayList<Pago> pagos;
        pagos=pago.listarTodos();
        return pagos;
    }
    
    @Override
    public ArrayList<Pago> listarPagosPorDeuda(int deudaId) {
        return pago.listarPagosPorDeuda(deudaId);
    }

   

    @Override
    public void validar(Pago objeto) throws Exception {
        if(objeto.getMonto()<=0){
            throw new Exception("El monto asignado al pago no es valido");
        }
        if(objeto.getDeuda().getDeuda_id()<=0){
            throw new Exception("El pago no tiene una deuda valida asignada");
        }
        if(objeto.getObservaciones().length()>100){
            throw new Exception("La longitud de la observacion no es valida");
        }
    }
    
}
