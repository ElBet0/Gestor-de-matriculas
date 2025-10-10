/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.usuario.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.model.usuario.Cargo;
import pe.edu.sis.usuario.BO.CargoBO;
import pe.edu.sis.usuario.dao.CargoDAO;
import pe.edu.sis.usuario.mysql.CargoImpl;

/**
 *
 * @author sdelr
 */
public class CargoBOImpl implements CargoBO{
    CargoDAO cargo;
    public CargoBOImpl(){
        cargo=new CargoImpl();
    }

    @Override
    public int insertar(Cargo objeto) throws Exception {
        validar(objeto);
        objeto.setCargo_id(cargo.insertar(objeto));
        return objeto.getCargo_id();    
    }

    @Override
    public int modificar(Cargo objeto) throws Exception {
        validar(objeto);
        return cargo.modificar(objeto);   
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return cargo.eliminar(Idobjeto);
    }

    @Override
    public Cargo obtenerPorId(int Idobjeto) throws Exception {
        Cargo c;
        c= cargo.obtener_por_id(Idobjeto);
        return c;
    }

    @Override
    public ArrayList<Cargo> listarTodos() throws Exception {
        ArrayList<Cargo> c;
        c=cargo.listarTodos();
        return c;
    }

    @Override
    public void validar(Cargo objeto) throws Exception {
        if(objeto.getNombre().length()>69){
            throw new Exception("la longitud del nombre no es valida");
        }
    }
}
