/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gracademico.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;

/**
 *
 * @author seinc
 */
public interface GradoDAO extends IDAO<GradoAcademico>{

   
    public GradoAcademico buscarPorNombreOAbreviatura(String abreviatura, String nombre);
    
    public ArrayList<Aula> listarAulasPorGrado(int idGradoAcademico);
}
