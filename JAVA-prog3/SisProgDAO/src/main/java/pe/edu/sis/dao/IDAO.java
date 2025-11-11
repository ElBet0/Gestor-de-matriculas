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
public interface IDAO<T> {
    /**
     * Inserta un nuevo registro en la base de datos correspondiente a la entidad
     * proporcionada.
     * También actualiza el ID de la entidad con el valor generado por la base de
     * datos.
     * 
     * @param objeto Entidad a persistir en la base de datos
     * @return ID generado para el registro insertado o código de resultado:
     *         - Valor positivo: ID autogenerado de la entidad insertada
     *         - Valor negativo: -1 error
     */
    int insertar(T objeto);

    /**
     * Actualiza un registro existente en la base de datos con los datos de la
     * entidad proporcionada.
     * 
     * @param objeto Entidad con los datos actualizados (debe incluir su
     *               identificador)
     * @return Número de registros afectados o código de resultado:
     *         - Valor positivo: Cantidad de registros modificados
     *         - Cero: Si no se encontró el registro a modificar
     *         - Valor negativo: Código de error en caso de fallo
     */
    int modificar(T objeto);

    /**
     * Elimina un registro de la base de datos según su identificador único.
     * 
     * @param idObjeto Identificador único del registro a eliminar
     * @return Número de registros afectados o código de resultado:
     *         - Valor positivo: Cantidad de registros eliminados
     *         - Cero: Si no se encontró el registro con el ID proporcionado
     *         - Menos uno: Si es un error inesperado
     *         - Valor negativo: Código de error en caso de fallo
     */
    int eliminar(int idObjeto);

    /**
     * Recupera una entidad de la base de datos según su identificador único.
     * 
     * @param idObjeto Identificador único de la entidad a recuperar
     * @return Instancia completa de la entidad correspondiente al ID especificado,
     *         o {@code null} si no se encuentra el registro
     */
    T obtener_por_id(int idObjeto);

    /**
     * Recupera todos los registros existentes de la entidad en la base de datos.
     * 
     * @return Lista mutable ({@link ArrayList}) con todas las entidades
     *         encontradas.
     *         Retorna una lista vacía si no existen registros, nunca {@code null}
     */
    ArrayList<T> listarTodos();

}
