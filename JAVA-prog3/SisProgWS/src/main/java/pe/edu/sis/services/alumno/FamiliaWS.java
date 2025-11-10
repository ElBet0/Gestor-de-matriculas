/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.alumno;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.alumno.BOImpl.FamiliaBOImpl;
import pe.edu.sis.model.alumno.Familia;

/**
 *
 * @author jeyso
 */

@WebService(serviceName = "FamiliaWS")
public class FamiliaWS {

    private FamiliaBOImpl boFamilia;
    
    @WebMethod(operationName = "insertarFamilia")
    public int insertarFamilia(@WebParam(name = "familia")Familia familia){
        int resultado = 0;
        try{
            boFamilia = new FamiliaBOImpl();
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
            boFamilia = new FamiliaBOImpl();
            resultado = boFamilia.modificar(familia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarFamiliaPorId")
    public int eliminarFamiliaPorId(@WebParam(name = "familia")Familia familia){
        int resultado = 0;
        try{
            boFamilia = new FamiliaBOImpl();
            resultado = boFamilia.insertar(familia);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerFamiliaPorId")
    public Familia obtenerFamiliaPorId(@WebParam(name = "idFamilia") int idFamilia){
        Familia familia = null;
        try{
            boFamilia = new FamiliaBOImpl();
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
            boFamilia = new FamiliaBOImpl();
            familias = boFamilia.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return familias;
    }
}
