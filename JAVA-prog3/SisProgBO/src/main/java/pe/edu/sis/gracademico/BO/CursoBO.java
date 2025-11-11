/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.gracademico.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author sdelr
 */
public interface CursoBO extends IBaseBO<Curso>{
    ArrayList<Curso> BuscarNombreAbre(String nombre,String abre,String grado);
}
