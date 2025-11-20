/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.deuda.BO;

import java.util.ArrayList;
import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.deuda.Deuda;

/**
 *
 * @author sdelr
 */
public interface DeudaBO extends IBaseBO<Deuda>{
    ArrayList<Deuda> buscarDeudasAlumno(int idFamilia,int tipoDeuda);
    Deuda consultarDeuda(int id);
}
