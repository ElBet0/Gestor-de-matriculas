/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.alumno;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class Familia {
    /**
     * El código único que identifica a la familia.
     */
    private int familia_id;
    /**
     * El apellido paterno de la familia.
     */
    private String apellido_paterno;
    /**
     * El apellido materno de la familia.
     */
    private String apellido_materno;
    /**
     * El número de teléfono de contacto de la familia.
     */
    private String numero_telefono;
    /**
     * El correo electrónico de contacto de la familia.
     */
    private String correo_electronico;
    /**
     * La dirección de la familia.
     */
    private String direccion;
    /**
     * La lista de hijos de la familia que son alumnos en la institución.
     */
    private List<Alumno> hijos = new ArrayList<>();
}
