/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import java.time.LocalDate;
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
    private LocalDate fecha_inicio;
    private LocalDate fecha_fin;
    private int vigencia;
    private VacantesGrado vacantes;
    private List<Matricula> matriculados=new ArrayList<>();     
    /**
     * @return the periodo_academico_id
     */
    public int getPeriodo_academico_id() {
        return periodo_academico_id;
    }

    /**
     * @param periodo_academico_id the periodo_academico_id to set
     */
    public void setPeriodo_academico_id(int periodo_academico_id) {
        this.periodo_academico_id = periodo_academico_id;
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
     * @return the vigencia
     */
    public int getVigencia() {
        return vigencia;
    }

    /**
     * @param vigencia the vigencia to set
     */
    public void setVigencia(int vigencia) {
        this.vigencia = vigencia;
    }

    /**
     * @return the vacantes
     */
    public VacantesGrado getVacantes() {
        return vacantes;
    }

    /**
     * @param vacantes the vacantes to set
     */
    public void setVacantes(VacantesGrado vacantes) {
        this.vacantes = vacantes;
    }

    /**
     * @return the matriculados
     */
    public List<Matricula> getMatriculados() {
        return new ArrayList<>(matriculados);
    }

    /**
     * @param matriculados the matriculados to set
     */
    public void setMatriculados(List<Matricula> matriculados) {
        this.matriculados = matriculados;
    }
}
