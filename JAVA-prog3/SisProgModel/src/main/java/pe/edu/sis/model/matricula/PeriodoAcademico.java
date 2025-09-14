/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class PeriodoAcademico {
    private int periodo_academico_id;
    private String nombre;
    private String descripcion;
    private LocalDate fecha_inicio;
    private LocalDate fecha_fin;
    private int vigencia;
    private VacantesGrado vacantes;
    private List<Matricula> matriculados=new ArrayList<>();    
}
