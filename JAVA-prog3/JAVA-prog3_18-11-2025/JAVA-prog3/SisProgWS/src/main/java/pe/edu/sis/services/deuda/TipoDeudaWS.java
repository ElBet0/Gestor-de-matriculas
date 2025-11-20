/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.deuda;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.deuda.BO.TipoDeudaBO;
import pe.edu.sis.deuda.BOImpl.TipoDeudaBOImpl;
import pe.edu.sis.model.deuda.TipoDeuda;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "TipoDeudaWS")
public class TipoDeudaWS {
    
    private TipoDeudaBO boTipoDeuda;
    
    public TipoDeudaWS(){
        this.boTipoDeuda=new TipoDeudaBOImpl();
    }
    
    @WebMethod(operationName = "insertarTipoDeuda")
    public int insertarTipoDeuda(@WebParam(name = "tipoDeuda")TipoDeuda tipoDeuda){
        int resultado = 0;
        try{
            resultado = boTipoDeuda.insertar(tipoDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarTipoDeuda")
    public int modificarTipoDeuda(@WebParam(name = "tipoDeuda")TipoDeuda tipoDeuda){
        int resultado = 0;
        try{
            resultado = boTipoDeuda.modificar(tipoDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarTipoDeudaPorId")
    public int eliminarTipoDeudaPorId(@WebParam(name = "idTipoDeuda")int idTipoDeuda){
        int resultado = 0;
        try{
            resultado = boTipoDeuda.eliminar(idTipoDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerTipoDeudaPorId")
    public TipoDeuda obtenerTipoDeudaPorId(@WebParam(name = "idTipoDeuda") int idTipoDeuda){
        TipoDeuda tipoDeuda = null;
        try{
            tipoDeuda = boTipoDeuda.obtenerPorId(idTipoDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return tipoDeuda;
    }
    
    @WebMethod(operationName = "listarTiposDeudaTodos")
    public ArrayList<TipoDeuda> listarTiposDeudaTodos() {
        ArrayList<TipoDeuda> tiposDeuda = null;
        try{
            tiposDeuda = boTipoDeuda.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return tiposDeuda;
    }
}
