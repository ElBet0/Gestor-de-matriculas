/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.dao;

import java.util.ArrayList;

/**
 *
 * @author seinc
 */
public interface IDAO <T> {
    int insertar (T objeto);
    int modificar (T objeto);
    int eliminar (int idObjeto);
    T obtener_por_id (int idObjeto);
    ArrayList<T> listarTodos();
}
