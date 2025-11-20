/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.matricula;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.matricula.BO.MatriculaBO;
import pe.edu.sis.matricula.BOImpl.MatriculaBOImpl;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "MatriculaWS")
public class MatriculaWS {
    
    private MatriculaBO boMatricula;
    
    public MatriculaWS(){
        this.boMatricula=new MatriculaBOImpl();
    }
    
    @WebMethod(operationName = "insertarMatricula")
    public int insertarMatricula(@WebParam(name = "curso")Matricula matricula){
        int resultado = 0;
        try{
            resultado = boMatricula.insertar(matricula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarMatricula")
    public int modificarMatricula(@WebParam(name = "curso")Matricula matricula){
        int resultado = 0;
        try{
            resultado = boMatricula.modificar(matricula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarMatriculaPorId")
    public int eliminarMatriculaPorId(@WebParam(name = "idMatricula")int idMatricula){
        int resultado = 0;
        try{
            resultado = boMatricula.eliminar(idMatricula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerMatriculaPorId")
    public Matricula obtenerMatriculaPorId(@WebParam(name = "idMatricula")int idMatricula){
        Matricula matricula = null;
        try{
            matricula = boMatricula.obtenerPorId(idMatricula);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return matricula;
    }
    
    @WebMethod(operationName = "listarMatriculasTodas")
    public ArrayList<Matricula> listarMatriculasTodas() {
        ArrayList<Matricula> matriculas = null;
        try{
            matriculas = boMatricula.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return matriculas;
    }
    
    public ArrayList<Matricula> listarMatriculasPorFamiliaIdPaternoMaternoNombre(@WebParam(name = "idFamilia")int idFamilia,@WebParam(name = "paterno")String paterno,
            @WebParam(name = "materno")String materno,@WebParam(name = "nombre")String nombre,@WebParam(name = "dni")int dni,@WebParam(name = "anho")int anho){
        ArrayList<Matricula> matriculas = null;
        try{
            matriculas = boMatricula.buscarAlumnosAnio(idFamilia, paterno, materno, nombre, dni, anho);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return matriculas;
    }
    
    @WebMethod(operationName = "listarPeriodoXAulasParaAsignarMatriculas")
    public ArrayList<PeriodoXAula> listarPeriodoXAulasParaAsignarMatriculas() {
        ArrayList<PeriodoXAula> periodosXaulas = null;
        try{
            periodosXaulas = boMatricula.ListarAulaAsignarMat();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return periodosXaulas;
    }
}
