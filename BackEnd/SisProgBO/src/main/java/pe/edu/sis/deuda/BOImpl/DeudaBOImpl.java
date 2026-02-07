/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.deuda.BO.DeudaBO;
import pe.edu.sis.deuda.dao.DeudaDAO;
import pe.edu.sis.deuda.mysql.DeudaImpl;
import pe.edu.sis.model.deuda.Deuda;

/**
 *
 * @author sdelr
 */
public class DeudaBOImpl implements DeudaBO{
    DeudaDAO deuda;

    public DeudaBOImpl() {
        deuda= new DeudaImpl();
    }

    @Override
    public int insertar(Deuda objeto) throws Exception {
        validar(objeto);
        objeto.setDeuda_id(deuda.insertar(objeto));
        return objeto.getDeuda_id();
    }

    @Override
    public int modificar(Deuda objeto) throws Exception {
        validar(objeto);
        return deuda.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return deuda.eliminar(Idobjeto);
    }

    @Override
    public Deuda obtenerPorId(int Idobjeto) throws Exception {
        Deuda d;
        d = deuda.obtener_por_id(Idobjeto);
        return d;
    }

    @Override
    public ArrayList<Deuda> listarTodos() throws Exception {
        ArrayList<Deuda> deudas;
        deudas=deuda.listarTodos();
        return deudas;
    }

    @Override
    public void validar(Deuda objeto) throws Exception {
        if(objeto.getMonto()<0){
            throw new Exception("El monto de la deuda no es valida");
        }
        if(objeto.getDescripcion().length()>100){
            throw new Exception("La longitud de la descripcion no es valida");
        }
        if(!objeto.getFecha_emision().before(objeto.getFecha_vencimiento())){
            throw new Exception("el orden de las fechas no es el correcto");
        }
        if(objeto.getAlumno().getAlumno_id()<0){
            throw new Exception("la deuda no tiene un alumno valido registrado");
        }
        if(objeto.getConcepto_deuda().getId_tipo_deuda()<0){
            throw new Exception("la deuda no tiene un tipo deuda valido registrado");
        }
    }

    @Override
    public ArrayList<Deuda> buscarDeudasAlumno(int idFamilia, int idTipoDeuda) {
        ArrayList<Deuda> d;
        d=deuda.buscarDeudasAlumno(idFamilia, idTipoDeuda);
        return d;
    }
    
    @Override
    public Deuda consultarDeuda(int id){
        Deuda d;
        d=deuda.consultarDeuda(id);
        return d;
    }
}
