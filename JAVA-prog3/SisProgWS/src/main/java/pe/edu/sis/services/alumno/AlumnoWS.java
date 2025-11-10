/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.alumno;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.alumno.BOImpl.alumnoBOImpl;
import pe.edu.sis.model.alumno.Alumno;

/**
 *
 * @author jeyso
 */
@WebService(serviceName = "AlumnoWS")
public class AlumnoWS {
    
    private alumnoBOImpl boAlumno;
    
    @WebMethod(operationName = "insertarAlumno")
    public int insertarAlumno(@WebParam(name = "alumno")Alumno alumno){
        int resultado = 0;
        try{
            boAlumno = new alumnoBOImpl();
            resultado = boAlumno.insertar(alumno);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarAlumno")
    public int modificarAlumno(@WebParam(name = "alumno")Alumno alumno){
        int resultado = 0;
        try{
            boAlumno = new alumnoBOImpl();
            resultado = boAlumno.modificar(alumno);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarAlumnoPorId")
    public int eliminarAlumnoPorId(@WebParam(name = "idAlumno")int idAlumno){
        int resultado = 0;
        try{
            boAlumno = new alumnoBOImpl();
            resultado = boAlumno.eliminar(idAlumno);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerAlumnoPorId")
    public Alumno obtenerAlumnoPorId(@WebParam(name = "idAlumno") int idAlumno){
        Alumno alumno = null;
        try{
            boAlumno = new alumnoBOImpl();
            alumno = boAlumno.obtenerPorId(idAlumno);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return alumno;
    }
    
    @WebMethod(operationName = "listarAlumnosTodos")
    public ArrayList<Alumno> listarAlumnosTodos() {
        ArrayList<Alumno> alumnos = null;
        try{
            boAlumno = new alumnoBOImpl();
            alumnos = boAlumno.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return alumnos;
    }
}
