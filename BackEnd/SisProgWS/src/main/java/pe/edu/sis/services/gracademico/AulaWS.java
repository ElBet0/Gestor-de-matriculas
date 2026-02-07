/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.gracademico;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.gracademico.BO.AulaBO;
import pe.edu.sis.gracademico.BOImpl.AulaBOImpl;
import pe.edu.sis.model.grAcademico.Aula;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "AulaWS")
public class AulaWS {
    
    private AulaBO boAula;
    
    public AulaWS(){
        this.boAula=new AulaBOImpl();
    }
    
    @WebMethod(operationName = "insertarAula")
    public int insertarAula(@WebParam(name = "aula")Aula aula){
        int resultado = 0;
        try{
            resultado = boAula.insertar(aula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarAula")
    public int modificarAula(@WebParam(name = "aula")Aula aula){
        int resultado = 0;
        try{
            resultado = boAula.modificar(aula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarAulaPorId")
    public int eliminarAulaPorId(@WebParam(name = "idAula")int idAula){
        int resultado = 0;
        try{
            resultado = boAula.eliminar(idAula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerAulaPorId")
    public Aula obtenerAulaPorId(@WebParam(name = "idAula")int idAula){
        Aula aula = null;
        try{
            aula = boAula.obtenerPorId(idAula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return aula;
    }
    
    @WebMethod(operationName = "listarAulasTodas")
    public ArrayList<Aula> listarAulasTodas() {
        ArrayList<Aula> aulas = null;
        try{
            aulas = boAula.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return aulas;
    }
    
    @WebMethod(operationName = "listarAulasPorNombreONombreGrado")
    public ArrayList<Aula> listarAulasPorNombreONombreGrado(@WebParam(name = "nombre")String nombre,@WebParam(name = "nombreGrado")String nombreGrado) {
        ArrayList<Aula> aulas = null;
        try{
            aulas = boAula.buscarNombre(nombre, nombreGrado); //que tal descriptivo ese nombre del método ah
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return aulas;
    }
}
