/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.matricula.Matricula;

/**
 *
 * @author seinc
 */
public interface AlumnoDAO extends IDAO<Alumno> {
    
    public ArrayList<Alumno> BuscarAlumno(int familia_id,String ape_pat,String ape_mat,String nombre,int dni);
    
    public ArrayList<Matricula> ConsultarMatriculas(int alumno_id);
    
}
