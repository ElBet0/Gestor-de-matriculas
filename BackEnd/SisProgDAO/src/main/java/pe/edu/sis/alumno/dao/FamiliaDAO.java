/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

/**
 *
 * @author seinc
 */
public interface FamiliaDAO extends IDAO<Familia> {
    
    ArrayList<Familia> BuscarFamilia(String ape_pat,String ape_mat);
    
    ArrayList<Alumno> ObtenerHijos(int familia_id);
    
}
