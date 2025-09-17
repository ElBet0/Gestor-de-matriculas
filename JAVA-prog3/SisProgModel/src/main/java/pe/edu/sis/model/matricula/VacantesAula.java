/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

/**
 *
 * @author seinc
 */
public class VacantesAula {
    private int aula_id;
    private String nombre;
    private int vacantes_disponibles;
    private int vacantes_ocupadas;
    private int estado;
    public VacantesAula(String nombre, int vacantes_disponibles, int vacantes_ocupadas) {
        this.nombre = nombre;
        this.vacantes_disponibles = vacantes_disponibles;
        this.vacantes_ocupadas = vacantes_ocupadas;
    }
    public VacantesAula(){};
    /**
     * @return the aula_id
     */
    public int getAula_id() {
        return aula_id;
    }

    /**
     * @param aula_id the aula_id to set
     */
    public void setAula_id(int aula_id) {
        this.aula_id = aula_id;
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

    /**
     * @return the estado
     */
    public int getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(int estado) {
        this.estado = estado;
    }
    
    
}
