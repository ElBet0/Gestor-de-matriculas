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
    private GradoAcademico grado;

    public Curso(String nombre, String descripcion, int horas_semanales, String abreviatura, GradoAcademico grado) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.horas_semanales = horas_semanales;
        this.abreviatura = abreviatura;
        this.grado = grado;
    }
    public Curso(){}
    /**
     * @return the grado
     */
    public GradoAcademico getGrado() {
        return grado;
    }

    /**
     * @param grado the grado to set
     */
    public void setGrado(GradoAcademico grado) {
        this.grado = grado;
    }
    /**
     * @return the curso_id
     */
    public int getCurso_id() {
        return curso_id;
    }

    /**
     * @param curso_id the curso_id to set
     */
    public void setCurso_id(int curso_id) {
        this.curso_id = curso_id;
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
     * @return the horas_semanales
     */
    public int getHoras_semanales() {
        return horas_semanales;
    }

    /**
     * @param horas_semanales the horas_semanales to set
     */
    public void setHoras_semanales(int horas_semanales) {
        this.horas_semanales = horas_semanales;
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

    /**
     * @return the abreviatura
     */
    public String getAbreviatura() {
        return abreviatura;
    }

    /**
     * @param abreviatura the abreviatura to set
     */
    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

}
