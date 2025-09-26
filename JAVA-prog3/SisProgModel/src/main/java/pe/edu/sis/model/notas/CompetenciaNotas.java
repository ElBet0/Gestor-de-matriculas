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
    private int activo;
    private List<CalificacionNota> nota_academica= new ArrayList<>();

    public CompetenciaNotas(double calificacion_final, Competencia competencia) {
        this.calificacion_final = calificacion_final;
        this.competencia = competencia;
    }
    
    /**
     * @return the competencia_notas_id
     */
    public int getCompetencia_notas_id() {
        return competencia_notas_id;
    }

    /**
     * @param competencia_notas_id the competencia_notas_id to set
     */
    public void setCompetencia_notas_id(int competencia_notas_id) {
        this.competencia_notas_id = competencia_notas_id;
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

    /**
     * @return the competencia
     */
    public Competencia getCompetencia() {
        return competencia;
    }

    /**
     * @param competencia the competencia to set
     */
    public void setCompetencia(Competencia competencia) {
        this.competencia = competencia;
    }

    /**
     * @return the nota_academica
     */
    public List<CalificacionNota> getNota_academica() {
        return new ArrayList<>(nota_academica);
    }

    /**
     * @param nota_academica the nota_academica to set
     */
    public void setNota_academica(List<CalificacionNota> nota_academica) {
        this.nota_academica = nota_academica;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    
}
