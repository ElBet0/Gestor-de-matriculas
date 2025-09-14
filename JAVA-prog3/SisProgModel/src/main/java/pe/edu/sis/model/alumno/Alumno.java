/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.alumno;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.deuda.Deuda;
/**
 *
 * @author seinc
 */
public class Alumno {

    /**
     * El código único que identifica al alumno.
     */
    private int alumno_id;
    /**
     * El nombre del alumno.
     */
    private int dni;
    /**
     * El dni del alumno
     */
    private String nombre;
    /**
     * El apellido paterno del alumno.
     */
    private String apellido_paterno;
    /**
     * El apellido materno del alumno.
     */
    private String apellido_materno;
    /**
     * La fecha de nacimiento del alumno.
     */
    private LocalDate fecha_nacimiento;
    /**
     * La fecha de ingreso del alumno a la institución.
     */
    private LocalDate fecha_ingreso;
    /**
     * El sexo del alumno.
     */
    private char sexo;
    /**
     * La religión del alumno.
     */
    private String religion;
    /**
     * La familia a la que pertenece el alumno.
     */
    private Familia padres;
    /**
     * Observaciones del alumno
     */
    private String observaciones; //creo que deberia ser una lista
    
    /**
     * Pension base del alumno
     */
    private double pension_base;
    /**
     * La lista de deudas asociadas al alumno.
     */
    private List<Deuda> deudas = new ArrayList<>();
}
