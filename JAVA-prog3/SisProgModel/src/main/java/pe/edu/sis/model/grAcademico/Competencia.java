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
public class Competencia {
    private int competencia_id;
    private String nombre;
    private double peso_competencia;
    private int activo;
    private List<Calificaciones> calificaciones= new ArrayList<>();
}
