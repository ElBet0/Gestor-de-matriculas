/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.alumno.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

/**
 *
 * @author sdelr
 */
public interface FamiliaBO extends IBaseBO<Familia>{
     ArrayList<Familia> buscarFamilia(String ape_pat,String ape_mat);
    
     ArrayList<Alumno>ObtenerHijos(int fam_id);
}
