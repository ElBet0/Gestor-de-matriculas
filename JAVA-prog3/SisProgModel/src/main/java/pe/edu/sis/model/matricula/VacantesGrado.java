/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

/**
 *
 * @author seinc
 */
public class VacantesGrado {
    private int vacantes_grado_id;
    private int vacantes_iniciales;
    private int vacantes_disponibles;
    private int vacantes_ocupadas;
    private int activo;
    private PeriodoAcademico periodoAcademico;

    public VacantesGrado(PeriodoAcademico periodoAcademico, int vacantes_iniciales, int vacantes_disponibles, int vacantes_ocupadas) {
        this.periodoAcademico = periodoAcademico;
        this.vacantes_iniciales = vacantes_iniciales;
        this.vacantes_disponibles = vacantes_disponibles;
        this.vacantes_ocupadas = vacantes_ocupadas;
    }


    public int getVacantes_grado_id() {
        return vacantes_grado_id;
    }

    public void setVacantes_grado_id(int vacantes_grado_id) {
        this.vacantes_grado_id = vacantes_grado_id;
    }

    public int getVacantes_iniciales() {
        return vacantes_iniciales;
    }

    public void setVacantes_iniciales(int vacantes_iniciales) {
        this.vacantes_iniciales = vacantes_iniciales;
    }

    public int getVacantes_disponibles() {
        return vacantes_disponibles;
    }

    public void setVacantes_disponibles(int vacantes_disponibles) {
        this.vacantes_disponibles = vacantes_disponibles;
    }

    public int getVacantes_ocupadas() {
        return vacantes_ocupadas;
    }

    public void setVacantes_ocupadas(int vacantes_ocupadas) {
        this.vacantes_ocupadas = vacantes_ocupadas;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int estado) {
        this.activo = estado;
    }
    
}
