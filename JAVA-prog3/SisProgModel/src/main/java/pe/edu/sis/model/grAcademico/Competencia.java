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

    public Competencia(String nombre, double peso_competencia) {
        this.nombre = nombre;
        this.peso_competencia = peso_competencia;
    }
    
    /**
     * @return the competencia_id
     */
    public int getCompetencia_id() {
        return competencia_id;
    }

    /**
     * @param competencia_id the competencia_id to set
     */
    public void setCompetencia_id(int competencia_id) {
        this.competencia_id = competencia_id;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the peso_competencia
     */
    public double getPeso_competencia() {
        return peso_competencia;
    }

    /**
     * @param peso_competencia the peso_competencia to set
     */
    public void setPeso_competencia(double peso_competencia) {
        this.peso_competencia = peso_competencia;
    }

    /**
     * @return the activo
     */
    public int getActivo() {
        return activo;
    }

    /**
     * @param activo the activo to set
     */
    public void setActivo(int activo) {
        this.activo = activo;
    }
}
