/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class VacantesGrado {
    private int vacantes_grado_id;
    private int vacantes_iniciales;
    private int vacantes_disponibles;
    private int vacantes_ocupadas;
    private List<VacantesAula> vacantes_aula=new ArrayList<>();
    /**
     * @return the vacantes_grado_id
     */
    public int getVacantes_grado_id() {
        return vacantes_grado_id;
    }

    /**
     * @param vacantes_grado_id the vacantes_grado_id to set
     */
    public void setVacantes_grado_id(int vacantes_grado_id) {
        this.vacantes_grado_id = vacantes_grado_id;
    }

    /**
     * @return the vacantes_iniciales
     */
    public int getVacantes_iniciales() {
        return vacantes_iniciales;
    }

    /**
     * @param vacantes_iniciales the vacantes_iniciales to set
     */
    public void setVacantes_iniciales(int vacantes_iniciales) {
        this.vacantes_iniciales = vacantes_iniciales;
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
