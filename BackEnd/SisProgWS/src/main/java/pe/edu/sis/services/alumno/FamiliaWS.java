/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.alumno;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.alumno.BO.FamiliaBO;
import pe.edu.sis.alumno.BOImpl.FamiliaBOImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

/**
 *
 * @author jeyso
 */

@WebService(serviceName = "FamiliaWS")
public class FamiliaWS {

    private FamiliaBO boFamilia;
    
    public FamiliaWS(){
        this.boFamilia=new FamiliaBOImpl();
    }
    
    @WebMethod(operationName = "insertarFamilia")
    public int insertarFamilia(@WebParam(name = "familia")Familia familia){
        int resultado = 0;
        try{
            resultado = boFamilia.insertar(familia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarFamilia")
    public int modificarFamilia(@WebParam(name = "familia")Familia familia){
        int resultado = 0;
        try{
            resultado = boFamilia.modificar(familia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarFamiliaPorId")
    public int eliminarFamiliaPorId(@WebParam(name = "idFamilia")int idFamilia){
        int resultado = 0;
        try{
            resultado = boFamilia.eliminar(idFamilia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerFamiliaPorId")
    public Familia obtenerFamiliaPorId(@WebParam(name = "idFamilia") int idFamilia){
        Familia familia = null;
        try{
            familia = boFamilia.obtenerPorId(idFamilia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return familia;
    }
    
    @WebMethod(operationName = "listarFamiliasTodas")
    public ArrayList<Familia> listarFamiliasTodas() {
        ArrayList<Familia> familias = null;
        try{
            familias = boFamilia.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return familias;
    }
    
    @WebMethod(operationName = "ObtenerHijos")
    public ArrayList<Alumno> ObtenerHijos(@WebParam(name = "idFamilia") int idFamilia){
        ArrayList<Alumno> hijos = null;
        try{
            hijos = boFamilia.ObtenerHijos(idFamilia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return hijos;
    }
    
    @WebMethod(operationName = "buscarFamilia")
    public ArrayList<Familia> buscarFamilia(
            @WebParam(name = "apellido_paterno") String apellido_paterno, 
            @WebParam(name = "apellido_materno") String apellido_materno){
        ArrayList<Familia> f = null;
        try {
            f = boFamilia.buscarFamilia(apellido_paterno, apellido_materno);

        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return f;
    }
}