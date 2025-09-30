/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.grAcademico.GradoAcademico;
/**
 *
 * @author ElBet0
 */
public class Matricula {

    private int matricula_id;
    private Alumno alumno;
    private PeriodoAcademico periodo;
    private GradoAcademico grado;
    private int estado;
    
    public Matricula(Alumno alumno, PeriodoAcademico periodo, GradoAcademico grado) {
        this.alumno = alumno;
        this.periodo = periodo;
        this.grado = grado;
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public Matricula(Matricula other) {
        this.matricula_id = other.matricula_id;
        this.alumno = Alumno.Clone(other.alumno);
        this.periodo = new PeriodoAcademico(other.periodo);
        this.grado = new GradoAcademico(other.grado);
        this.estado = other.estado;
    }

    public Matricula(int matricula_id){
        this.matricula_id = matricula_id;
        this.alumno = new Alumno(-1);
    }

    public Matricula(){}

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getMatricula_id() {
        return matricula_id;
    }

    public void setMatricula_id(int matricula_id) {
        this.matricula_id = matricula_id;
    }


    public Alumno getAlumno() {
        return Alumno.Clone(alumno);
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = Alumno.Clone(alumno);
    }

    public PeriodoAcademico getPeriodo() {
        return new PeriodoAcademico(periodo);
    }

    public void setPeriodo(PeriodoAcademico periodo) {
        this.periodo = new PeriodoAcademico(periodo);
    }

    public GradoAcademico getGrado() {
        return new GradoAcademico(grado);
    }

    public void setGrado(GradoAcademico grado) {
        this.grado = new GradoAcademico(grado);
    }
}
