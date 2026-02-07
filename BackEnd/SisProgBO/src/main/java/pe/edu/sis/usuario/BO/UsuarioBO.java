/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.usuario.BO;

import pe.edu.sis.BO.IBaseBO;
import pe.edu.sis.model.usuario.Usuario;

/**
 *
 * @author sdelr
 */
public interface UsuarioBO extends IBaseBO<Usuario>{
    int verificarUsuario(String nombre,String clave);
}
