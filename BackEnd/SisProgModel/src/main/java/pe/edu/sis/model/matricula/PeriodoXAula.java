/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import jakarta.xml.bind.annotation.XmlType;
import pe.edu.sis.model.grAcademico.Aula;

/**
 *
 * @author sdelr
 */
@XmlType(namespace = "http://sisprog.com/model")
public class PeriodoXAula {
    private int Periodo_aula_id;
    private PeriodoAcademico periodo;
    private Aula aula;
    private int vacantes_disponibles;
    private int vacantes_ocupadas;
    private int activo;
    
    
    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    

    public PeriodoXAula() {
    }

    public PeriodoXAula(PeriodoAcademico periodo, Aula aula, int vacantes_disponibles, int vacantes_ocupadas) {
        this.periodo = periodo;
        this.aula = aula;
        this.vacantes_disponibles = vacantes_disponibles;
        this.vacantes_ocupadas = vacantes_ocupadas;
        this.activo=1;
    }

    /**
     * @return the Periodo_aula_id
     */
    public int getPeriodo_aula_id() {
        return Periodo_aula_id;
    }

    /**
     * @param Periodo_aula_id the Periodo_aula_id to set
     */
    public void setPeriodo_aula_id(int Periodo_aula_id) {
        this.Periodo_aula_id = Periodo_aula_id;
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
     * @return the aula
     */
    public Aula getAula() {
        return aula;
    }

    /**
     * @param aula the aula to set
     */
    public void setAula(Aula aula) {
        this.aula = aula;
    }

    /**
     * @return the vacantes_disponibles
     */
    public int getVacantes_disponibles() {
        return vacantes_disponibles;
    }

    /**
     * @param vacantes_disponibles the vacantes_disponibles to set
     */
    public void setVacantes_disponibles(int vacantes_disponibles) {
        this.vacantes_disponibles = vacantes_disponibles;
    }

    /**
     * @return the vacantes_ocupadas
     */
    public int getVacantes_ocupadas() {
        return vacantes_ocupadas;
    }

    /**
     * @param vacantes_ocupadas the vacantes_ocupadas to set
     */
    public void setVacantes_ocupadas(int vacantes_ocupadas) {
        this.vacantes_ocupadas = vacantes_ocupadas;
    }

}
