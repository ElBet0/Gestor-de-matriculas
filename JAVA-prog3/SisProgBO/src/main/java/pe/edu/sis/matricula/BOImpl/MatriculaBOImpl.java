/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.matricula.BO.MatriculaBO;
import pe.edu.sis.matricula.dao.MatriculaDAO;
import pe.edu.sis.matricula.mysql.MatriculaImpl;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author sdelr
 */
public class MatriculaBOImpl implements MatriculaBO{
    MatriculaDAO mat;
    public MatriculaBOImpl() {
        mat = new MatriculaImpl();
        
    }
   
    
    @Override
    public int insertar(Matricula objeto) throws Exception {
        validar(objeto);
        objeto.setMatricula_id(mat.insertar(objeto));
        return objeto.getMatricula_id();
    }

    @Override
    public int modificar(Matricula objeto) throws Exception {
        validar(objeto);
        return mat.modificar(objeto);
        
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return mat.eliminar(Idobjeto);
    }

    @Override
    public Matricula obtenerPorId(int Idobjeto) throws Exception {
        Matricula m;
        m= mat.obtener_por_id(Idobjeto);
        return m;
    }

    @Override
    public ArrayList<Matricula> listarTodos() throws Exception {
        ArrayList<Matricula> m ;
        m=mat.listarTodos();
        return m;
        
    }

    @Override
    public void validar(Matricula objeto) throws Exception {
        if(objeto.getAlumno().getAlumno_id()<0){
            throw new Exception("El alumno asignado a la matricula no es valido");
        }
        if(objeto.getPeriodo_Aula().getPeriodo_aula_id()<0){
            throw new Exception("El Periodo_Aula asignado a la matricula no es valido");
        }
    }
    
    @Override
    public ArrayList<Matricula> buscarAlumnosAnio(int familia_id ,String apellido_paterno,String 
            apellido_materno,String nombre,int dni ,int anho ){
        
        ArrayList<Matricula> matri;
        matri=mat.BuscarAlumnos(familia_id, apellido_paterno, apellido_materno, nombre, dni, anho);
        return matri;
    }

    @Override
    public ArrayList<PeriodoXAula> ListarAulaAsignarMat() {
        
        
        ArrayList<PeriodoXAula> p;
        p=mat.listarAulasParaAsignarMatricula();
        return p;
        
    }
    
    
}
