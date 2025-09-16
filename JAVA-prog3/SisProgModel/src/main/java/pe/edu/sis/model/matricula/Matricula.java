/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import pe.edu.sis.model.alumno.Alumno;
import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.grAcademico.GradoAcademico;
import pe.edu.sis.model.notas.Bimestre;
/**
 *
 * @author seinc
 */
public class Matricula {
    private int matricula_id;
    private Alumno alumno;
    private PeriodoAcademico periodo;
    private List<Bimestre> bimestres=new ArrayList<>();
    private GradoAcademico grado;

    /**
     * @return the matricula_id
     */
    public int getMatricula_id() {
        return matricula_id;
    }

    /**
     * @param matricula_id the matricula_id to set
     */
    public void setMatricula_id(int matricula_id) {
        this.matricula_id = matricula_id;
    }

    /**
     * @return the alumno
     */
    public Alumno getAlumno() {
        return alumno;
    }

    /**
     * @param alumno the alumno to set
     */
    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    /**
     * @return the periodo
     */
    public PeriodoAcademico getPeriodo() {
        return periodo;
    }

    /**
     * @param periodo the periodo to set
     */
    public void setPeriodo(PeriodoAcademico periodo) {
        this.periodo = periodo;
    }

    /**
     * @return the bimestres
     */
    public List<Bimestre> getBimestres() {
        return new ArrayList<>(bimestres);
    }

    /**
     * @param bimestres the bimestres to set
     */
    public void setBimestres(List<Bimestre> bimestres) {
        this.bimestres = bimestres;
    }

    /**
     * @return the grado
     */
    public GradoAcademico getGrado() {
        return grado;
    }

    /**
     * @param grado the grado to set
     */
    public void setGrado(GradoAcademico grado) {
        this.grado = grado;
    }
}
