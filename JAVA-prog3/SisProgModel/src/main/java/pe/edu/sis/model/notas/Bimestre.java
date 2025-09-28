/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import pe.edu.sis.model.grAcademico.GradoAcademico;
import pe.edu.sis.model.matricula.Matricula;
import pe.edu.sis.model.matricula.PeriodoAcademico;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class Bimestre {
    private int bimestre_id;
    private String descripcion;
    private Date fecha_inicio;
    private Date fecha_fin;
    private Matricula matricula;

    private int activo;
    public Bimestre(String descripcion, Date fecha_inicio, Date fecha_fin) {
        this.descripcion = descripcion;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
    }

    public Bimestre(int bimestre_id, String descripcion, Date fecha_inicio, Date fecha_fin, Matricula matricula, int activo) {
        this.bimestre_id = bimestre_id;
        this.descripcion = descripcion;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
        this.matricula = matricula;
        this.activo = activo;
    }

    public Bimestre(int bimestre_id) {
        this.bimestre_id = bimestre_id;
        this.descripcion = "No asignado";
        this.fecha_inicio = new Date();
        this.fecha_fin = new Date();
        this.matricula = new Matricula(-1);
        this.activo = 0;
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
    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    /**
     * @param fecha_inicio the fecha_inicio to set
     */
    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    /**
     * @return the fecha_fin
     */
    public Date getFecha_fin() {
        return fecha_fin;
    }

    /**
     * @param fecha_fin the fecha_fin to set
     */
    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Matricula getMatricula() {
        return matricula;
    }

    public void setMatricula(Matricula matricula) {
        this.matricula = matricula;
    }
}
