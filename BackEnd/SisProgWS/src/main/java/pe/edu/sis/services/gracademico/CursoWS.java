/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.gracademico;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.gracademico.BO.CursoBO;
import pe.edu.sis.gracademico.BOImpl.CursoBOImpl;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "CursoWS")
public class CursoWS {
    
    private CursoBO boCurso;
    
    public CursoWS(){
        this.boCurso=new CursoBOImpl();
    }
    
    @WebMethod(operationName = "insertarCurso")
    public int insertarCurso(@WebParam(name = "curso")Curso curso){
        int resultado = 0;
        try{
            resultado = boCurso.insertar(curso);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarCurso")
    public int modificarCurso(@WebParam(name = "curso")Curso curso){
        int resultado = 0;
        try{
            resultado = boCurso.modificar(curso);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarCursoPorId")
    public int eliminarCursoPorId(@WebParam(name = "idCurso")int idCurso){
        int resultado = 0;
        try{
            resultado = boCurso.eliminar(idCurso);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerCursoPorId")
    public Curso obtenerCursoPorId(@WebParam(name = "idCurso")int idCurso){
        Curso curso = null;
        try{
            curso = boCurso.obtenerPorId(idCurso);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return curso;
    }
    
    @WebMethod(operationName = "listarCursosTodos")
    public ArrayList<Curso> listarCursosTodos() {
        ArrayList<Curso> cursos = null;
        try{
            cursos = boCurso.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return cursos;
    }
    
    @WebMethod(operationName = "listarCursosPorNombreAbreviaturaOGradoAcademico")
    public ArrayList<Curso> listarCursosPorNombreAbreviaturaOGradoAcademico(@WebParam(name = "nombre")String nombre,@WebParam(name = "abreviatura")String abreviatura,
            @WebParam(name = "nombreGrado")String nombreGrado) {
        ArrayList<Curso> cursos = null;
        try{
            cursos = boCurso.BuscarNombreAbre(nombre,abreviatura,nombreGrado); //que tal descriptivo ese nombre del método ah
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return cursos;
    }
    
}
