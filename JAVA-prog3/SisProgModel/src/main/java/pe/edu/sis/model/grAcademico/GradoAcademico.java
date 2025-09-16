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
public class GradoAcademico {
    private int grado_academico_id;
    private String nombre;
    private String abreviatura;
    private List<Curso> cursos=new ArrayList<>();
    /**
     * @return the grado_academico_id
     */
    public int getGrado_academico_id() {
        return grado_academico_id;
    }

    /**
     * @param grado_academico_id the grado_academico_id to set
     */
    public void setGrado_academico_id(int grado_academico_id) {
        this.grado_academico_id = grado_academico_id;
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

    /**
     * @return the cursos
     */
    public List<Curso> getCursos() {
        return new ArrayList<>(cursos); //shadowcpy
    }

    /**
     * @param cursos the cursos to set
     */
    public void setCursos(List<Curso> cursos) {
        this.cursos = cursos;
    }
    
}
