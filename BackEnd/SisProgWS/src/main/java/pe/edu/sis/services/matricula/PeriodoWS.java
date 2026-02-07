/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.matricula;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.matricula.BO.PeriodoBO;
import pe.edu.sis.matricula.BOImpl.PeriodoBOImpl;
import pe.edu.sis.model.matricula.PeriodoAcademico;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "PeriodoWS")
public class PeriodoWS {
    
    private PeriodoBO boPeriodo;
    
    public PeriodoWS(){
        this.boPeriodo=new PeriodoBOImpl();
    }
    
    @WebMethod(operationName = "insertarPeriodo")
    public int insertarPeriodo(@WebParam(name = "periodo")PeriodoAcademico periodo){
        int resultado = 0;
        try{
            resultado = boPeriodo.insertar(periodo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarPeriodo")
    public int modificarPeriodo(@WebParam(name = "periodo")PeriodoAcademico periodo){
        int resultado = 0;
        try{
            resultado = boPeriodo.modificar(periodo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPeriodoPorId")
    public int eliminarPeriodoPorId(@WebParam(name = "idPeriodo")int idPeriodo){
        int resultado = 0;
        try{
            resultado = boPeriodo.eliminar(idPeriodo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerPeriodoPorId")
    public PeriodoAcademico obtenerPeriodoPorId(@WebParam(name = "idPeriodo")int idPeriodo){
        PeriodoAcademico matricula = null;
        try{
            matricula = boPeriodo.obtenerPorId(idPeriodo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return matricula;
    }
    
    @WebMethod(operationName = "listarPeriodosTodos")
    public ArrayList<PeriodoAcademico> listarPeriodosTodos() {
        ArrayList<PeriodoAcademico> periodos = null;
        try{
            periodos = boPeriodo.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return periodos;
    }
}
