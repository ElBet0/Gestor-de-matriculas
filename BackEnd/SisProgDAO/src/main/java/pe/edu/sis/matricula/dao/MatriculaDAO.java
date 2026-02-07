/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author seinc
 */
public interface MatriculaDAO extends IDAO<Matricula> {
   
     ArrayList<Matricula> BuscarAlumnos(int familia_id,String ape_pat,String ape_mat,
            String nombre,int dni,int anho);
    
     ArrayList<PeriodoXAula>listarAulasParaAsignarMatricula();
     
     int registrarMatriculaConVacantes(int alumnoId, int aulaId,
            double costo_matricula, double costo_pension);

    
}
