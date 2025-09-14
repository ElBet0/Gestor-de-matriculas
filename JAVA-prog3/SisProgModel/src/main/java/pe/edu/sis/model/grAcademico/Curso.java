/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class Curso {
    private int curso_id;
    private String nombre;
    private String descripcion;
    private int horas_semanales;
    private int activo;
    private String abreviatura;
    private List<Competencia> competencias=new ArrayList<>();
}
