/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import jakarta.xml.bind.annotation.XmlType;
import pe.edu.sis.model.alumno.Alumno;

/**
 *
 * @author ElBet0
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Matricula {

    private int matricula_id;
    private Alumno alumno;
    private PeriodoXAula periodo;
    private int activo;

    public Matricula(Alumno alumno, PeriodoXAula periodo) {
        this.alumno = alumno;
        this.periodo = periodo;
    }

    public Matricula() {
    }

    public int getMatricula_id() {
        return matricula_id;
    }

    public void setMatricula_id(int matricula_id) {
        this.matricula_id = matricula_id;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public PeriodoXAula getPeriodo_Aula() {
        return periodo;
    }

    public void setPeriodo_Aula(PeriodoXAula periodo) {
        this.periodo = periodo;
    }

    /**
     * @return the activo
     */
    public int getActivo() {
        return activo;
    }

    /**
     * @param activo the activo to set
     */
    public void setActivo(int activo) {
        this.activo = activo;
    }
}
