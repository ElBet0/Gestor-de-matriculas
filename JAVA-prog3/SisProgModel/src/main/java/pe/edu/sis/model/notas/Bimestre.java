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
    public Bimestre(Matricula matricula, String descripcion, Date fecha_inicio, Date fecha_fin) {
        this.matricula = new Matricula(matricula);
        this.descripcion = descripcion;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public Bimestre(Bimestre bimestre){
        this.bimestre_id = bimestre.bimestre_id;
        this.descripcion = bimestre.descripcion;
        this.fecha_inicio = bimestre.fecha_inicio;
        this.fecha_fin = bimestre.fecha_fin;
        this.matricula = new Matricula(bimestre.matricula);
        this.activo = bimestre.activo;
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
    
    public int getBimestre_id() {
        return bimestre_id;
    }

    public void setBimestre_id(int bimestre_id) {
        this.bimestre_id = bimestre_id;
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

    public Matricula getMatricula() {
        return new Matricula(matricula);
    }

    public void setMatricula(Matricula matricula) {
        this.matricula = new Matricula(matricula);
    }
}
