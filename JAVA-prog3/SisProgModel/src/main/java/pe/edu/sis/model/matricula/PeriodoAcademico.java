/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class PeriodoAcademico {
    private int periodo_academico_id;
    private String nombre;
    private String descripcion;
    private Date fecha_inicio;
    private Date fecha_fin;
    private int vigencia;

    public PeriodoAcademico(String nombre, String descripcion, Date fecha_inicio, Date fecha_fin) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public PeriodoAcademico(PeriodoAcademico other) {
        this.periodo_academico_id = other.periodo_academico_id;
        this.nombre = other.nombre;
        this.descripcion = other.descripcion;
        this.fecha_inicio = other.fecha_inicio;
        this.fecha_fin = other.fecha_fin;
        this.vigencia = other.vigencia;
    }

    public PeriodoAcademico(){}

    public int getPeriodo_academico_id() {
        return periodo_academico_id;
    }

    public void setPeriodo_academico_id(int periodo_academico_id) {
        this.periodo_academico_id = periodo_academico_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public int getVigencia() {
        return vigencia;
    }

    public void setVigencia(int vigencia) {
        this.vigencia = vigencia;
    }

}
