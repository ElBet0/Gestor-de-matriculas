/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.deuda.Pago;

/**
 *
 * @author seinc
 */
public interface PagoDAO extends IDAO<Pago> {
    
    
   
    public ArrayList<Pago> listarPagosPorDeuda(int deudaId) ;
    
    
    
}
