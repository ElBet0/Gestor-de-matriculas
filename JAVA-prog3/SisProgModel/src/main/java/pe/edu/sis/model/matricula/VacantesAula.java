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
    private VacantesGrado vacantesGrado;

    public VacantesAula(VacantesGrado vacantesGrado, String nombre, int vacantes_disponibles, int vacantes_ocupadas) {
        this.nombre = nombre;
        this.vacantesGrado = new VacantesGrado(vacantesGrado);
        this.vacantes_disponibles = vacantes_disponibles;
        this.vacantes_ocupadas = vacantes_ocupadas;
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public VacantesAula(VacantesAula other) {
        this.aula_id = other.aula_id;
        this.nombre = other.nombre;
        this.vacantes_disponibles = other.vacantes_disponibles;
        this.vacantes_ocupadas = other.vacantes_ocupadas;
        this.estado = other.estado;
        this.vacantesGrado = new VacantesGrado(other.vacantesGrado);
    }

    public VacantesAula(){};

    public int getAula_id() {
        return aula_id;
    }

    public void setAula_id(int aula_id) {
        this.aula_id = aula_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
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

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public VacantesGrado getVacantesGrado() {
        return new VacantesGrado(vacantesGrado);
    }

    public void setVacantesGrado(VacantesGrado vacantesGrado) {
        this.vacantesGrado = new VacantesGrado(vacantesGrado);
    }

    @Override
    public String toString() {
        return "VacantesAula{" + "aula_id=" + aula_id + ", nombre=" + nombre + ", vacantes_disponibles=" + vacantes_disponibles + ", vacantes_ocupadas=" + vacantes_ocupadas + ", estado=" + estado + '}';
    }

}
