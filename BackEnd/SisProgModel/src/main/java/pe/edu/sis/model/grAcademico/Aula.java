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
public class Aula {
    private int aula_id;
    private String nombre;
    private GradoAcademico grado;
    private int activo;
    
    
    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    

    public Aula() {
    }

    public Aula(String nombre, GradoAcademico grado, int activo) {
        this.nombre = nombre;
        this.grado = grado;
        this.activo= activo;
    }

    public int getAula_id() {
        return aula_id;
    }

    public void setAula_id(int aula_id) {
        this.aula_id = aula_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public GradoAcademico getGrado() {
        return grado;
    }

    public void setGrado(GradoAcademico grado) {
        this.grado = grado;
    }

    @Override
    public String toString() {
        return "Aula{" + "aula_id=" + getAula_id() + ", nombre=" + getNombre();
    }

}
