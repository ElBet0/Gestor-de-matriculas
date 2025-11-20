/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.Pago;

/**
 *
 * @author seinc
 */
public interface DeudaDAO extends IDAO<Deuda>{
    public ArrayList<Deuda> buscarDeudasAlumno(int familiaId, int idTipoDeuda);
    
    public Deuda consultarDeuda(int idDeuda) ;
    
    public Pago obtenerPagoPorId(int pagoId);
}
