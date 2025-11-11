/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.matricula.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author sdelr
 */
public interface MatriculaBO extends IBaseBO<Matricula>{
    
    ArrayList<Matricula> buscarAlumnosAnio(int familia_id ,String apellido_paterno,String 
            apellido_materno,String nombre,int _dni ,int _ano );
    
    ArrayList<PeriodoXAula>ListarAulaAsignarMat();
}
