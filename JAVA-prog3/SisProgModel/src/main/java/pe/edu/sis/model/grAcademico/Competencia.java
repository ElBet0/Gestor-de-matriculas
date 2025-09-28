/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;

/**
 *
 * @author seinc
 */
public class Competencia {
    private int competencia_id;
    private String nombre;
    private double peso_competencia;
    private int activo;
    private Curso curso;

    public Competencia(String nombre, double peso_competencia, Curso curso) {
        this.nombre = nombre;
        this.peso_competencia = peso_competencia;
        this.curso = new Curso(curso);
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public Competencia(Competencia other) {
        this.competencia_id = other.competencia_id;
        this.nombre = other.nombre;
        this.peso_competencia = other.peso_competencia;
        this.activo = other.activo;
        this.curso = new Curso(other.curso);
    }

    public int getCompetencia_id() {
        return competencia_id;
    }

    public void setCompetencia_id(int competencia_id) {
        this.competencia_id = competencia_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getPeso_competencia() {
        return peso_competencia;
    }

    public void setPeso_competencia(double peso_competencia) {
        this.peso_competencia = peso_competencia;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public Curso getCurso() {
        return new Curso(curso);
    }

    public void setCurso(Curso curso) {
        this.curso = new Curso(curso);
    }

}
