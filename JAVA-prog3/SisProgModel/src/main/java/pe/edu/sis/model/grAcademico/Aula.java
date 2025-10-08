/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;


/**
 *
 * @author seinc
 */
public class Aula {
private int aula_id;
    private String nombre;
    private GradoAcademico grado;
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
    

   
    @Override
    public String toString() {
        return "Aula{" + "aula_id=" + getAula_id() + ", nombre=" + getNombre() ;
    }

}
