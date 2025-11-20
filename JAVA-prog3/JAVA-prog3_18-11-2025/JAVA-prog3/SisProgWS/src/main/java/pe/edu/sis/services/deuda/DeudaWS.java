/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.deuda;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.deuda.BO.DeudaBO;
import pe.edu.sis.deuda.BOImpl.DeudaBOImpl;
import pe.edu.sis.model.deuda.Deuda;

/**
 *
 * @author jeyso
 */
@WebService(serviceName = "DeudaWS")
public class DeudaWS {
    
    private DeudaBO boDeuda;
    
    public DeudaWS(){
        this.boDeuda=new DeudaBOImpl();
    }
    
    @WebMethod(operationName = "insertarDeuda")
    public int insertarDeuda(@WebParam(name = "deuda")Deuda deuda){
        int resultado = 0;
        try{
            resultado = boDeuda.insertar(deuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarDeuda")
    public int modificarDeuda(@WebParam(name = "deuda")Deuda deuda){
        int resultado = 0;
        try{
            resultado = boDeuda.modificar(deuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarDeudaPorId")
    public int eliminarDeudaPorId(@WebParam(name = "idDeuda")int idDeuda){
        int resultado = 0;
        try{
            resultado = boDeuda.eliminar(idDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerDeudaPorId")
    public Deuda obtenerDeudaPorId(@WebParam(name = "idDeuda") int idDeuda){
        Deuda deuda = null;
        try{
            deuda = boDeuda.obtenerPorId(idDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return deuda;
    }
    
    @WebMethod(operationName = "listarDeudasTodas")
    public ArrayList<Deuda> listarDeudasTodas() {
        ArrayList<Deuda> deudas = null;
        try{
            deudas = boDeuda.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return deudas;
    }
    
    //NO SE POR QUE SE LLAMA BUSCAR DEUDAS ALUMNO SI ES QUE RECIBE DE PARAMETRO ID TIPO DEUDA E ID FAMILIA
    @WebMethod(operationName = "buscarDeudasAlumno")
    public ArrayList<Deuda> buscarDeudasAlumno(@WebParam(name = "idFamilia")int idFamilia,@WebParam(name = "idTipoDeuda")int idTipoDeuda) {
        ArrayList<Deuda> deudas = null;
        try{
            deudas = boDeuda.buscarDeudasAlumno(idFamilia,idTipoDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return deudas;
    }
    
    //NO SE POR QUE HAY consultarDeudaPorId SI YA TENEMOS UN OBTENER POR ID
    @WebMethod(operationName = "consultarDeudaPorId")
    public Deuda consultarDeudaPorId(@WebParam(name = "idDeuda")int idDeuda) {
        Deuda deuda = null;
        try{
            deuda = boDeuda.consultarDeuda(idDeuda);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return deuda;
    }
    
}
