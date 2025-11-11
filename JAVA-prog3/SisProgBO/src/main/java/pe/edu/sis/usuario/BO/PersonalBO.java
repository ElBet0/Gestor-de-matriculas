/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.usuario.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.usuario.Personal;

/**
 *
 * @author sdelr
 */
public interface PersonalBO extends IBaseBO<Personal>{
    ArrayList<Personal> buscarDniNombre(int dni,String nombre);
}
