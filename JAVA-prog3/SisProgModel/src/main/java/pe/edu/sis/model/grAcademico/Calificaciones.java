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
    private int activo;

    public Calificaciones(String descripcion, double peso_calificacion) {
        this.descripcion = descripcion;
        this.peso_calificacion = peso_calificacion;
    }
    
    /**
     * @return the calificaciones_id
     */
    public int getCalificaciones_id() {
        return calificaciones_id;
    }

    /**
     * @param calificaciones_id the calificaciones_id to set
     */
    public void setCalificaciones_id(int calificaciones_id) {
        this.calificaciones_id = calificaciones_id;
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
     * @return the peso_calificacion
     */
    public double getPeso_calificacion() {
        return peso_calificacion;
    }

    /**
     * @param peso_calificacion the peso_calificacion to set
     */
    public void setPeso_calificacion(double peso_calificacion) {
        this.peso_calificacion = peso_calificacion;
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
