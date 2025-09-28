/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;

/**
 *
 * @author seinc
 */
public class GradoAcademico {

    private int grado_academico_id;
    private String nombre;
    private String abreviatura;
    private int estado;

    public GradoAcademico(GradoAcademico other) {
        this.grado_academico_id = other.grado_academico_id;
        this.nombre = other.nombre;
        this.abreviatura = other.abreviatura;
        this.estado = other.estado;
    }

    public GradoAcademico(String nombre, String abreviatura) {
        this.nombre = nombre;
        this.abreviatura = abreviatura;
    }
    public GradoAcademico(){}

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
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
