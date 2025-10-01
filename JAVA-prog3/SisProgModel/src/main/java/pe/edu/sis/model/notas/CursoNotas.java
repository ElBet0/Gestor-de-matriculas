/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author seinc
 */
public class CursoNotas {
    private int curso_notas_id;
    private Curso curso;
    private Bimestre bimestre;
    private double calificacion_final;
    private int activo;

    public CursoNotas(Curso curso, Bimestre bimestre, double calificacion_final) {
        this.curso = curso;
        this.bimestre = bimestre;
        this.calificacion_final = calificacion_final;
    }

    public int getCurso_notas_id() {
        return curso_notas_id;
    }

    public void setCurso_notas_id(int curso_notas_id) {
        this.curso_notas_id = curso_notas_id;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public double getCalificacion_final() {
        return calificacion_final;
    }

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
