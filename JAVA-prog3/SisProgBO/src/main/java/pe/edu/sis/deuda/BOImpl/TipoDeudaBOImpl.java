/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.deuda.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.deuda.BO.TipoDeudaBO;
import pe.edu.sis.deuda.dao.TipoDeudaDAO;
import pe.edu.sis.deuda.mysql.TipoDeudaImpl;
import pe.edu.sis.model.deuda.TipoDeuda;

/**
 *
 * @author sdelr
 */
public class TipoDeudaBOImpl implements TipoDeudaBO {
    TipoDeudaDAO tipo;

    public TipoDeudaBOImpl() {
        tipo=new TipoDeudaImpl();
    }

    @Override
    public int insertar(TipoDeuda objeto) throws Exception {
        validar(objeto);
        objeto.setId_tipo_deuda(tipo.insertar(objeto));
        return objeto.getId_tipo_deuda();
    }

    @Override
    public int modificar(TipoDeuda objeto) throws Exception {
        validar(objeto);
        return tipo.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return tipo.eliminar(Idobjeto);
    }

    @Override
    public TipoDeuda obtenerPorId(int Idobjeto) throws Exception {
        TipoDeuda t;
        t= tipo.obtener_por_id(Idobjeto);
        return t;
    }

    @Override
    public ArrayList<TipoDeuda> listarTodos() throws Exception {
        ArrayList<TipoDeuda> tipos;
        tipos=tipo.listarTodos();
        return tipos;
    }

    @Override
    public void validar(TipoDeuda objeto) throws Exception {
        if(objeto.getDescripcion().length()>45){
            throw new Exception("la longitud de la descripcion no es valida");
        }
        if(objeto.getMonto_general()<0){
            throw new Exception("el monto general ingresado no es valido");
        }
    }
    
}
