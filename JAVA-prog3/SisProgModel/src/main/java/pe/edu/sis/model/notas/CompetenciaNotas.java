/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.grAcademico.Competencia;

/**
 *
 * @author seinc
 */
public class CompetenciaNotas {
    private int competencia_notas_id;
    private double calificacion_final;
    private Competencia competencia;
    private CursoNotas cursoNotas;
    private int activo;

    public CompetenciaNotas(double calificacion_final, Competencia competencia, CursoNotas cursoNotas) {
        this.calificacion_final = calificacion_final;
        this.competencia = competencia;
        this.cursoNotas = new CursoNotas(cursoNotas);
        this.competencia = new Competencia(competencia);
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public CompetenciaNotas(CompetenciaNotas other) {
        this.competencia_notas_id = other.competencia_notas_id;
        this.calificacion_final = other.calificacion_final;
        this.cursoNotas = new CursoNotas(other.cursoNotas);
        this.competencia = new Competencia(other.competencia);
        this.activo = other.activo;
    }

    public int getCompetencia_notas_id() {
        return competencia_notas_id;
    }

    public void setCompetencia_notas_id(int competencia_notas_id) {
        this.competencia_notas_id = competencia_notas_id;
    }

    public double getCalificacion_final() {
        return calificacion_final;
    }

    public void setCalificacion_final(double calificacion_final) {
        this.calificacion_final = calificacion_final;
    }

    public Competencia getCompetencia() {
        return competencia;
    }

    public void setCompetencia(Competencia competencia) {
        this.competencia = competencia;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    
}
