/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.usuario;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.model.usuario.Rol;
import pe.edu.sis.model.usuario.Usuario;
import pe.edu.sis.usuario.BO.UsuarioBO;
import pe.edu.sis.usuario.BOImpl.UsuarioBOImpl;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "UsuarioWS")
public class UsuarioWS {
    
    private UsuarioBO boUsuario;
    
    public UsuarioWS(){
        this.boUsuario=new UsuarioBOImpl();
    }
    
    @WebMethod(operationName = "insertarUsuario")
    public int insertarUsuario(@WebParam(name = "nombre")String nombre,
            @WebParam(name = "clave")String clave,
            @WebParam(name="rol")Rol rol){
        int resultado = 0;
        try{
            Usuario usuario = new Usuario(nombre,clave,rol);
            resultado = boUsuario.insertar(usuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarUsuario")
    public int modificarUsuario(@WebParam(name = "id") int id,
            @WebParam(name = "nombre")String nombre,
            @WebParam(name = "clave")String clave,
            @WebParam(name="rol")Rol rol){
        int resultado = 0;
        try{
            Usuario us2 = new Usuario(nombre,clave,rol);
            us2.setUsuario_id(id);
            resultado = boUsuario.modificar(us2);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarUsuarioPorId")
    public int eliminarUsuarioPorId(@WebParam(name = "idUsuario")int idUsuario){
        int resultado = 0;
        try{
            resultado = boUsuario.eliminar(idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerUsuarioPorId")
    public Usuario obtenerUsuarioPorId(@WebParam(name = "idUsuario")int idUsuario){
        Usuario usuario = null;
        try{
            usuario = boUsuario.obtenerPorId(idUsuario);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return usuario;
    }
    
    @WebMethod(operationName = "listarUsuariosTodos")
    public ArrayList<Usuario> listarUsuariosTodos() {
        ArrayList<Usuario> usuario = null;
        try{
            usuario = boUsuario.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return usuario;
    }
    
    @WebMethod(operationName = "verificarUsuario")
    public int verificarUsuario(
            @WebParam(name = "nombre") String nombre,
            @WebParam(name = "clave") String clave) {
        
        int resultado = 0;
        try{
            resultado = boUsuario.verificarUsuario(nombre, clave);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
}