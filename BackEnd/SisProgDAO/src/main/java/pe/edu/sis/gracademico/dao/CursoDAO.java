/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gracademico.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author seinc
 */
public interface CursoDAO extends IDAO<Curso>{
    
    public ArrayList<Curso> buscarCurso(String nombre, String abreviatura, String nombreGrado) ;
    
}
