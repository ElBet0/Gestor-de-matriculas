/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.gracademico.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;

/**
 *
 * @author sdelr
 */
public interface GradoAcademicoBO extends IBaseBO<GradoAcademico>{
    GradoAcademico buscarGrado(String abre,String nombre);
    
    ArrayList<Aula> obtenerAulas(int id);
}
