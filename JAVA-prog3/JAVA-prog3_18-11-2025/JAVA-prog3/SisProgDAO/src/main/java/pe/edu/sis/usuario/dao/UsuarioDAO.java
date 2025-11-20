/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.usuario.dao;

import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.usuario.Usuario;

/**
 *
 * @author seinc
 */
public interface UsuarioDAO extends IDAO<Usuario>{
    Usuario obtenerDatos(String nombre);
    int verificarUsuario(String nombre,String clave);
}
