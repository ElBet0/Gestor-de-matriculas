/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.deuda;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.deuda.BO.PagoBO;
import pe.edu.sis.deuda.BOImpl.PagoBOImpl;
import pe.edu.sis.model.deuda.Pago;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "PagoWS")
public class PagoWS {
    
    private PagoBO boPago;
    
    public PagoWS(){
        this.boPago=new PagoBOImpl();
    }
    
    @WebMethod(operationName = "insertarPago")
    public int insertarPago(@WebParam(name = "pago")Pago pago){
        int resultado = 0;
        try{
            resultado = boPago.insertar(pago);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarPago")
    public int modificarPago(@WebParam(name = "pago")Pago pago){
        int resultado = 0;
        try{
            resultado = boPago.modificar(pago);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPagoPorId")
    public int eliminarPagoPorId(@WebParam(name = "idPago")int idPago){
        int resultado = 0;
        try{
            resultado = boPago.eliminar(idPago);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerPagoPorId")
    public Pago obtenerPagoPorId(@WebParam(name = "idPago") int idPago){
        Pago pago = null;
        try{
            pago = boPago.obtenerPorId(idPago);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return pago;
    }
    
    @WebMethod(operationName = "listarPagosTodos")
    public ArrayList<Pago> listarPagosTodos() {
        ArrayList<Pago> pagos = null;
        try{
            pagos = boPago.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return pagos;
    }
    
    @WebMethod(operationName = "listarPagosPorDeuda")
    public ArrayList<Pago> listarPagosPorDeuda(@WebParam(name = "deudaId") int deudaId) {
        ArrayList<Pago> pagos = null;
        try {
            pagos = boPago.listarPagosPorDeuda(deudaId);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return pagos;
    }

    
    
}
