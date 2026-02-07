/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.alumno;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.alumno.BO.alumnoBO;
import pe.edu.sis.alumno.BOImpl.alumnoBOImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.matricula.Matricula;

/**
 *
 * @author jeyso
 */
@WebService(serviceName = "AlumnoWS")
public class AlumnoWS {
    
    private alumnoBO boAlumno;
    
    public AlumnoWS(){
        this.boAlumno=new alumnoBOImpl();
    }
    
    @WebMethod(operationName = "insertarAlumno")
    public int insertarAlumno(@WebParam(name = "alumno")Alumno alumno){
        int resultado = 0;
        try{
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
            resultado = boAlumno.eliminar(idAlumno);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerAlumnoPorId")
    public Alumno obtenerAlumnoPorId(
            @WebParam(name = "idAlumno") int idAlumno
    ){
        Alumno alumno = null;
        try{
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
            alumnos = boAlumno.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return alumnos;
    }
    
    @WebMethod(operationName = "buscarAlumnos")
    public ArrayList<Alumno> buscarAlumnos (
        @WebParam(name = "idFamilia") String _idFamilia,
        @WebParam(name = "apellido_paterno") String _apellido_paterno,
        @WebParam(name = "apellido_materno") String _apellido_materno,
        @WebParam(name = "nombre") String _nombre,
        @WebParam(name = "dni") String _dni
    ) {
        ArrayList<Alumno> alumnos = null;
        int dni = (_dni == null || _dni.trim().isEmpty() ) ? -1 : Integer.parseInt(_dni);
        int idFamilia = (_idFamilia == null  || _idFamilia.trim().isEmpty()) ? -1 : Integer.parseInt(_idFamilia);
        _apellido_materno = _apellido_materno == null ? "" : _apellido_materno;
        _apellido_paterno = _apellido_paterno == null ? "" : _apellido_paterno;
        _nombre = _nombre == null ? "" : _nombre;
        
        try{
            alumnos = boAlumno.buscar(idFamilia, _apellido_paterno, _apellido_materno, _nombre, dni);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return alumnos;
    }
    
    @WebMethod(operationName = "consultarMatriculas")
public ArrayList<Matricula> consultarMatriculas(
            @WebParam(name = "idAlumno") int alumno_id
    ){
        ArrayList<Matricula> mat = null;
        try{
            mat = boAlumno.consultarMatriculas(alumno_id);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return mat;
    }
    
    
    
    
}