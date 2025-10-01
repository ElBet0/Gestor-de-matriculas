/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import pe.edu.sis.model.grAcademico.Calificaciones;

import java.util.Date;

/**
 *
 * @author seinc
 */
public class CalificacionNota {
    private int nota_academica_id;
    private String descripcion;
    private double nota_academica;
    private Date fecha_registro;
    private Calificaciones calificacionDato;
    private CompetenciaNotas competenciaNotas;
    private int activo;

    public CalificacionNota(Calificaciones calificacionDato, CompetenciaNotas competenciaNotas, String descripcion,
                            double nota_academica, Date fecha_registro) {
        this.descripcion = descripcion;
        this.nota_academica = nota_academica;
        this.fecha_registro = fecha_registro;
        this.competenciaNotas = competenciaNotas;
        this.calificacionDato = calificacionDato;
    }

    public int getNota_academica_id() {
        return nota_academica_id;
    }

    public void setNota_academica_id(int nota_academica_id) {
        this.nota_academica_id = nota_academica_id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getNota_academica() {
        return nota_academica;
    }

    public void setNota_academica(double nota_academica) {
        this.nota_academica = nota_academica;
    }

    public Date getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(Date fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    public Calificaciones getCalificacionDato() {
        return calificacionDato;
    }

    public void setCalificacionDato(Calificaciones calificacionDato) {
        this.calificacionDato = calificacionDato;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    
}
