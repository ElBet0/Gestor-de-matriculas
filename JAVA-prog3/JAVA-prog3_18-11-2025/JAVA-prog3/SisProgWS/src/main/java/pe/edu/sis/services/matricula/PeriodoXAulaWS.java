/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.matricula;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.matricula.BO.PeriodoXAulaBO;
import pe.edu.sis.matricula.BOImpl.PeriodoXAulaBOImpl;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "PeriodoXAulaWS")
public class PeriodoXAulaWS {
    
    private PeriodoXAulaBO boPeriodoXAula;
    
    public PeriodoXAulaWS(){
        this.boPeriodoXAula=new PeriodoXAulaBOImpl();
    }
    
    @WebMethod(operationName = "insertarPeriodoXAula")
    public int insertarPeriodoXAula(@WebParam(name = "periodoXAula")PeriodoXAula periodoXAula){
        int resultado = 0;
        try{
            resultado = boPeriodoXAula.insertar(periodoXAula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarPeriodoXAula")
    public int modificarPeriodoXAula(@WebParam(name = "periodoXAula")PeriodoXAula periodoXAula){
        int resultado = 0;
        try{
            resultado = boPeriodoXAula.modificar(periodoXAula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPeriodoXAulaPorId")
    public int eliminarPeriodoXAulaPorId(@WebParam(name = "idPeriodoXAula")int idPeriodoXAula){
        int resultado = 0;
        try{
            resultado = boPeriodoXAula.eliminar(idPeriodoXAula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerPeriodoXAulaPorId")
    public PeriodoXAula obtenerPeriodoXAulaPorId(@WebParam(name = "idPeriodoXAula")int idPeriodoXAula){
        PeriodoXAula periodoXAula = null;
        try{
            periodoXAula = boPeriodoXAula.obtenerPorId(idPeriodoXAula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return periodoXAula;
    }
    
    @WebMethod(operationName = "listarPeriodosXAulasTodos")
    public ArrayList<PeriodoXAula> listarPeriodosXAulasTodos() {
        ArrayList<PeriodoXAula> periodosXAulas = null;
        try{
            periodosXAulas = boPeriodoXAula.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return periodosXAulas;
    }
}
