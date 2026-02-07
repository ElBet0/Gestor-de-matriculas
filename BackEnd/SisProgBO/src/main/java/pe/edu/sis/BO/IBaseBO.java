/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.sis.BO;

import java.util.ArrayList;

/**
 *
 * @author sdelr
 */
public interface IBaseBO<T> {
    int insertar(T objeto) throws Exception;
    int modificar(T objeto) throws Exception;
    int eliminar(int Idobjeto) throws Exception;
    T obtenerPorId(int Idobjeto) throws Exception;
    ArrayList<T> listarTodos()throws Exception;
    void validar(T objeto)throws Exception;
}
