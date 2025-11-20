/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.alumno.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.matricula.Matricula;

/**
 *
 * @author sdelr
 */
public interface alumnoBO extends IBaseBO<Alumno>{
     ArrayList<Alumno> buscar(int fam_id,String ape_pat,String apemat,String nombre,int dni);
    
     ArrayList<Matricula> consultarMatriculas(int alumno_id);
}
