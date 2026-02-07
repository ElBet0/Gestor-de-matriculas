/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.gracademico;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.gracademico.BO.GradoAcademicoBO;
import pe.edu.sis.gracademico.BOImpl.GradoAcademicoBOImpl;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "GradoAcademicoWS")
public class GradoAcademicoWS {
    
    private GradoAcademicoBO boGradoAcademico;
    
    public GradoAcademicoWS(){
        this.boGradoAcademico=new GradoAcademicoBOImpl();
    }
    
    @WebMethod(operationName = "insertarGradoAcademico")
    public int insertarGradoAcademico(@WebParam(name = "tipoDeuda")GradoAcademico gradoAcademico){
        int resultado = 0;
        try{
            resultado = boGradoAcademico.insertar(gradoAcademico);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarGradoAcademico")
    public int modificarGradoAcademico(@WebParam(name = "gradoAcademico")GradoAcademico gradoAcademico){
        int resultado = 0;
        try{
            resultado = boGradoAcademico.modificar(gradoAcademico);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarGradoAcademicoPorId")
    public int eliminarGradoAcademicoPorId(@WebParam(name = "idGradoAcademico")int idGradoAcademico){
        int resultado = 0;
        try{
            resultado = boGradoAcademico.eliminar(idGradoAcademico);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerGradoAcademicoPorId")
    public GradoAcademico obtenerGradoAcademicoPorId(@WebParam(name = "idGradoAcademico") int idGradoAcademico){
        GradoAcademico gradoAcademico = null;
        try{
            gradoAcademico = boGradoAcademico.obtenerPorId(idGradoAcademico);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return gradoAcademico;
    }
    
    @WebMethod(operationName = "listarGradosAcademicosTodos")
    public ArrayList<GradoAcademico> listarGradosAcademicosTodos() {
        ArrayList<GradoAcademico> gradoAcademico = null;
        try{
            gradoAcademico = boGradoAcademico.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return gradoAcademico;
    }
    
    @WebMethod(operationName = "obtenerGradoAcademicoPorAbreviaturaONombre")
    public GradoAcademico obtenerGradoAcademicoPorAbreviaturaONombre(@WebParam(name = "abreviatura") String abreviatura,@WebParam(name = "nombre") String nombre){
        GradoAcademico gradoAcademico = null;
        try{
            gradoAcademico = boGradoAcademico.buscarGrado(abreviatura,nombre); //muy descriptivo, demasiado
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return gradoAcademico;
    }
    
    
    @WebMethod(operationName = "listarAulasPorGradoAcademico")
    public ArrayList<Aula> listarAulasPorGradoAcademico(@WebParam(name = "idGradoAcademico")int idGradoAcademico) {
        ArrayList<Aula> aulas = null;
        try{
            aulas = boGradoAcademico.obtenerAulas(idGradoAcademico); //esto no se hace de por sí en obtener por id? obtener por id no llena las aulas del grado en el objeto grado?
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return aulas;
    }
}
