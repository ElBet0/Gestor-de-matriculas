/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;

import jakarta.xml.bind.annotation.XmlType;

/**
 *
 * @author seinc
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Curso {

    private int curso_id;
    private String nombre;
    private String descripcion;
    private int horas_semanales;
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


    public int getCurso_id() {
        return curso_id;
    }

    public void setCurso_id(int curso_id) {
        this.curso_id = curso_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getHoras_semanales() {
        return horas_semanales;
    }

    public void setHoras_semanales(int horas_semanales) {
        this.horas_semanales = horas_semanales;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

    public GradoAcademico getGrado() {
        return grado;
    }

    public void setGrado(GradoAcademico grado) {
        this.grado = grado;
    }
}
