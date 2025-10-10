/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.usuario.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.model.usuario.Usuario;
import pe.edu.sis.usuario.BO.UsuarioBO;
import pe.edu.sis.usuario.dao.UsuarioDAO;
import pe.edu.sis.usuario.mysql.UsuarioImpl;

/**
 *
 * @author sdelr
 */
public class UsuarioBOImpl implements UsuarioBO{
    UsuarioDAO usuario;
    public UsuarioBOImpl(){
        usuario=new UsuarioImpl();
    }

    @Override
    public int insertar(Usuario objeto) throws Exception {
        validar(objeto);
        objeto.setUsuario_id(usuario.insertar(objeto));
        return objeto.getUsuario_id();
    }

    @Override
    public int modificar(Usuario objeto) throws Exception {
        validar(objeto);
        return usuario.modificar(objeto);   
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return usuario.eliminar(Idobjeto);
    }

    @Override
    public Usuario obtenerPorId(int Idobjeto) throws Exception {
        Usuario u;
        u=usuario.obtener_por_id(Idobjeto);
        return u;
    }

    @Override
    public ArrayList<Usuario> listarTodos() throws Exception {
        ArrayList<Usuario> u;
        u=usuario.listarTodos();
        return u;
    }

    @Override
    public void validar(Usuario objeto) throws Exception {
        if(objeto.getNombre().length()>50){
            throw new Exception("la longitud del nombre no es valida");
        }
        if(objeto.getHashClave().length()>256){
            throw new Exception("la longitud de la clave hash no es valida");
        }
        if(objeto.getSalt().length()>45){
            throw new Exception("la longitud del SALT no es valida");
        }
        if(objeto.getIteracion()>45){
            throw new Exception("la iteracion no es valida");
        }
    }
}
