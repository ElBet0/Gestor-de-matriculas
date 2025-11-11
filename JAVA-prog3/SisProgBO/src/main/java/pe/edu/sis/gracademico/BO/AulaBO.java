/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.gracademico.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.grAcademico.Aula;

/**
 *
 * @author sdelr
 */
public interface AulaBO extends IBaseBO<Aula> {
    public ArrayList<Aula> buscarNombre(String nombre,String nombre_grado);
}
