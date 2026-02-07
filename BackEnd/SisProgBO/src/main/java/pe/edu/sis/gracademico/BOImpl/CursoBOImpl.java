/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gracademico.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.gracademico.BO.CursoBO;
import pe.edu.sis.gracademico.dao.CursoDAO;
import pe.edu.sis.gracademico.mysql.CursoImpl;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author sdelr
 */
public class CursoBOImpl implements CursoBO {
    CursoDAO curso;

    public CursoBOImpl() {
        curso = new CursoImpl();
        
    }
    
    @Override
    public int insertar(Curso objeto) throws Exception {
        validar (objeto);
        objeto.setCurso_id(curso.insertar(objeto));
        return objeto.getCurso_id();
    }

    @Override
    public int modificar(Curso objeto) throws Exception {
        validar(objeto);
        return curso.modificar(objeto);
        
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return curso.eliminar(Idobjeto);
    }

    @Override
    public Curso obtenerPorId(int Idobjeto) throws Exception {
        Curso c;
        c=curso.obtener_por_id(Idobjeto);
        return c;
    }

    @Override
    public ArrayList<Curso> listarTodos() throws Exception {
        ArrayList<Curso> c;
        c=curso.listarTodos();
        return c;
    }

    @Override
    public void validar(Curso objeto) throws Exception {
        if(objeto.getAbreviatura().length()>10){
            throw new Exception("la longitud de la abreviatura no es valida");
        }
        if(!objeto.getDescripcion().isEmpty() &&objeto.getDescripcion().length()>100){
            throw new Exception("la longitud de la descripcion no es valida");
        }
        if(objeto.getNombre().length()>45){
            throw new Exception("la longitud del nombre del curso no es valida");
        }
        if(objeto.getGrado().getGrado_academico_id()<0)
        {
            throw new Exception("el grado asignado para el curso no es valido");
        }
        if(objeto.getHoras_semanales()<0){
            throw new Exception("las horas semanales asignadas al curso no son validas");
        }
    
    }
    @Override
    public ArrayList<Curso> BuscarNombreAbre(String nombre,String abre,String grado){
        ArrayList<Curso> cursos;
        cursos=curso.buscarCurso(nombre, abre, grado);
        return cursos;
    }
    
}
