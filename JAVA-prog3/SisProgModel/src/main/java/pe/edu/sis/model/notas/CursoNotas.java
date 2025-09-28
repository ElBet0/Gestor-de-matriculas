/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author seinc
 */
public class CursoNotas {
    private int curso_notas_id;
    private Curso curso;
    private double calificacion_final;
    private int activo;

    public CursoNotas(Curso curso, double calificacion_final) {
        this.curso = curso;
        this.calificacion_final = calificacion_final;
    }
    
    /**
     * @return the curso_notas_id
     */
    public int getCurso_notas_id() {
        return curso_notas_id;
    }

    /**
     * @param curso_notas_id the curso_notas_id to set
     */
    public void setCurso_notas_id(int curso_notas_id) {
        this.curso_notas_id = curso_notas_id;
    }

    /**
     * @return the curso
     */
    public Curso getCurso() {
        return curso;
    }

    /**
     * @param curso the curso to set
     */
    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    /**
     * @return the calificacion_final
     */
    public double getCalificacion_final() {
        return calificacion_final;
    }

    /**
     * @param calificacion_final the calificacion_final to set
     */
    public void setCalificacion_final(double calificacion_final) {
        this.calificacion_final = calificacion_final;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    
}
