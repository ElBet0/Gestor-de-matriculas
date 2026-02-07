/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.usuario;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.model.usuario.Personal;
import pe.edu.sis.usuario.BO.PersonalBO;
import pe.edu.sis.usuario.BOImpl.PersonalBOImpl;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "PersonalWS")
public class PersonalWS {
    
    private PersonalBO boPersonal;
    
    public PersonalWS(){
        this.boPersonal=new PersonalBOImpl();
    }
    
    @WebMethod(operationName = "insertarPersonal")
    public int insertarPersonal(@WebParam(name = "personal")Personal personal){
        int resultado = 0;
        try{
            resultado = boPersonal.insertar(personal);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarPersonal")
    public int modificarPersonal(@WebParam(name = "personal")Personal personal){
        int resultado = 0;
        try{
            resultado = boPersonal.modificar(personal);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarPersonalPorId")
    public int eliminarPersonalPorId(@WebParam(name = "idPersonal")int idPersonal){
        int resultado = 0;
        try{
            resultado = boPersonal.eliminar(idPersonal);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerPersonalPorId")
    public Personal obtenerPersonalPorId(@WebParam(name = "idPersonal")int idPersonal){
        Personal personal = null;
        try{
            personal = boPersonal.obtenerPorId(idPersonal);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return personal;
    }
    
    @WebMethod(operationName = "listarPersonalTodos")
    public ArrayList<Personal> listarPersonalTodos() {
        ArrayList<Personal> personal = null;
        try{
            personal = boPersonal.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return personal;
    }
    
    @WebMethod(operationName = "listarPersonalPorDniONombreApellidos")
    public ArrayList<Personal> listarPersonalPorDniONombreApellidos(@WebParam(name = "dni")int dni,@WebParam(name = "nombreApellidos")String nombreApellidos) {
        ArrayList<Personal> personal = null;
        try{
            personal = boPersonal.buscarDniNombre(dni, nombreApellidos);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return personal;
    }
}
