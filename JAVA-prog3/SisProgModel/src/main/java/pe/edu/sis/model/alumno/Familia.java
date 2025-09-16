/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.alumno;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class Familia {
    /**
     * El código único que identifica a la familia.
     */
    private int familia_id;
    /**
     * El apellido paterno de la familia.
     */
    private String apellido_paterno;
    /**
     * El apellido materno de la familia.
     */
    private String apellido_materno;
    /**
     * El número de teléfono de contacto de la familia.
     */
    private String numero_telefono;
    /**
     * El correo electrónico de contacto de la familia.
     */
    private String correo_electronico;
    /**
     * La dirección de la familia.
     */
    private String direccion;
    /**
     * La lista de hijos de la familia que son alumnos en la institución.
     */
    private List<Alumno> hijos = new ArrayList<>();

    public Familia(String apellido_paterno, String apellido_materno, String numero_telefono, String correo_electronico, String direccion) {
        this.apellido_paterno = apellido_paterno;
        this.apellido_materno = apellido_materno;
        this.numero_telefono = numero_telefono;
        this.correo_electronico = correo_electronico;
        this.direccion = direccion;
    }
    public Familia (){}
    /**
     * @return the familia_id
     */
    
    public int getFamilia_id() {
        return familia_id;
    }

    @Override
    public String toString() {
        return "Familia{" + "familia_id=" + familia_id + ", apellido_paterno=" + apellido_paterno + ", apellido_materno=" + apellido_materno + ", numero_telefono=" + numero_telefono + ", correo_electronico=" + correo_electronico + ", direccion=" + direccion + '}';
    }

    /**
     * @param familia_id the familia_id to set
     */
    public void setFamilia_id(int familia_id) {
        this.familia_id = familia_id;
    }

    /**
     * @return the apellido_paterno
     */
    public String getApellido_paterno() {
        return apellido_paterno;
    }

    /**
     * @param apellido_paterno the apellido_paterno to set
     */
    public void setApellido_paterno(String apellido_paterno) {
        this.apellido_paterno = apellido_paterno;
    }

    /**
     * @return the apellido_materno
     */
    public String getApellido_materno() {
        return apellido_materno;
    }

    /**
     * @param apellido_materno the apellido_materno to set
     */
    public void setApellido_materno(String apellido_materno) {
        this.apellido_materno = apellido_materno;
    }

    /**
     * @return the numero_telefono
     */
    public String getNumero_telefono() {
        return numero_telefono;
    }

    /**
     * @param numero_telefono the numero_telefono to set
     */
    public void setNumero_telefono(String numero_telefono) {
        this.numero_telefono = numero_telefono;
    }

    /**
     * @return the correo_electronico
     */
    public String getCorreo_electronico() {
        return correo_electronico;
    }

    /**
     * @param correo_electronico the correo_electronico to set
     */
    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    /**
     * @return the direccion
     */
    public String getDireccion() {
        return direccion;
    }

    /**
     * @param direccion the direccion to set
     */
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    /**
     * @return the hijos
     */
    public List<Alumno> getHijos() {
        return new ArrayList<Alumno>(hijos);
    }

    /**
     * @param hijos the hijos to set
     */
    public void setHijos(List<Alumno> hijos) {
        this.hijos = hijos;
    }
}
