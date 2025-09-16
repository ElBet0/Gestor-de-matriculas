/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.time.LocalDate;
import pe.edu.sis.model.grAcademico.Calificaciones;

/**
 *
 * @author seinc
 */
public class NotaAcademica {
    private int nota_academica_id;
    private String descripcion;
    private double nota_academica;
    private LocalDate fecha_registro;
    private Calificaciones calificacionDato;

    /**
     * @return the nota_academica_id
     */
    public int getNota_academica_id() {
        return nota_academica_id;
    }

    /**
     * @param nota_academica_id the nota_academica_id to set
     */
    public void setNota_academica_id(int nota_academica_id) {
        this.nota_academica_id = nota_academica_id;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the nota_academica
     */
    public double getNota_academica() {
        return nota_academica;
    }

    /**
     * @param nota_academica the nota_academica to set
     */
    public void setNota_academica(double nota_academica) {
        this.nota_academica = nota_academica;
    }

    /**
     * @return the fecha_registro
     */
    public LocalDate getFecha_registro() {
        return fecha_registro;
    }

    /**
     * @param fecha_registro the fecha_registro to set
     */
    public void setFecha_registro(LocalDate fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    /**
     * @return the calificacionDato
     */
    public Calificaciones getCalificacionDato() {
        return calificacionDato;
    }

    /**
     * @param calificacionDato the calificacionDato to set
     */
    public void setCalificacionDato(Calificaciones calificacionDato) {
        this.calificacionDato = calificacionDato;
    }
    
}
