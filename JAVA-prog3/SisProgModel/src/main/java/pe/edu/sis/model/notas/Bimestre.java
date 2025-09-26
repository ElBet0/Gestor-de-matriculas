/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class Bimestre {
    private int bimestre_id;
    private String descripcion;
    private LocalDate fecha_inicio;
    private LocalDate fecha_fin;
    private List<CursoNotas> nota = new ArrayList<>();
    private int activo;
    public Bimestre(String descripcion, LocalDate fecha_inicio, LocalDate fecha_fin) {
        this.descripcion = descripcion;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    
    /**
     * @return the bimestre_id
     */
    public int getBimestre_id() {
        return bimestre_id;
    }

    /**
     * @param bimestre_id the bimestre_id to set
     */
    public void setBimestre_id(int bimestre_id) {
        this.bimestre_id = bimestre_id;
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
     * @return the fecha_inicio
     */
    public LocalDate getFecha_inicio() {
        return fecha_inicio;
    }

    /**
     * @param fecha_inicio the fecha_inicio to set
     */
    public void setFecha_inicio(LocalDate fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    /**
     * @return the fecha_fin
     */
    public LocalDate getFecha_fin() {
        return fecha_fin;
    }

    /**
     * @param fecha_fin the fecha_fin to set
     */
    public void setFecha_fin(LocalDate fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    /**
     * @return the nota
     */
    public List<CursoNotas> getNota() {
        return new ArrayList<>(nota);
    }

    /**
     * @param nota the nota to set
     */
    public void setNota(List<CursoNotas> nota) {
        this.nota = nota;
    }
    
}
