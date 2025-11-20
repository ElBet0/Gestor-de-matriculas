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
public class GradoAcademico {

    private int grado_academico_id;
    private String nombre;
    private String abreviatura;
    private int activo;

    public GradoAcademico(String nombre, String abreviatura) {
        this.nombre = nombre;
        this.abreviatura = abreviatura;
    }

    public GradoAcademico() {
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getGrado_academico_id() {
        return grado_academico_id;
    }

    public void setGrado_academico_id(int grado_academico_id) {
        this.grado_academico_id = grado_academico_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

}
