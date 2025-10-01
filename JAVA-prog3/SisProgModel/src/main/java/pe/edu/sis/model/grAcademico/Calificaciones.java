/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;

/**
 *
 * @author seinc
 */
public class Calificaciones {

    private int calificaciones_id;
    private String descripcion;
    private double peso_calificacion;
    private Competencia competencia;
    private int activo;

    public Calificaciones(String descripcion, double peso_calificacion, Competencia competencia) {
        this.descripcion = descripcion;
        this.peso_calificacion = peso_calificacion;
        this.competencia = competencia;
    }

    public int getCalificaciones_id() {
        return calificaciones_id;
    }

    public void setCalificaciones_id(int calificaciones_id) {
        this.calificaciones_id = calificaciones_id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPeso_calificacion() {
        return peso_calificacion;
    }

    public void setPeso_calificacion(double peso_calificacion) {
        this.peso_calificacion = peso_calificacion;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public Competencia getCompetencia() {
        return competencia;
    }

    public void setCompetencia(Competencia competencia) {
        this.competencia = competencia;
    }
}
