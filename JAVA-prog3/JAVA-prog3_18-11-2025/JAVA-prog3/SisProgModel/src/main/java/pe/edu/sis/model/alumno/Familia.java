/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.alumno;

import jakarta.xml.bind.annotation.XmlType;

/**
 *
 * @author seinc
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Familia {
    private int familia_id;
    private String apellido_paterno;
    private String apellido_materno;
    private String numero_telefono;
    private String correo_electronico;
    private String direccion;
    
    //Si estas usando este, cambialo por el que tiene familia_id, evitamos errores
    public Familia(String apellido_paterno, String apellido_materno, String numero_telefono, String correo_electronico, String direccion) {
        this.apellido_paterno = apellido_paterno;
        this.apellido_materno = apellido_materno;
        this.numero_telefono = numero_telefono;
        this.correo_electronico = correo_electronico;
        this.direccion = direccion;
    }

    public Familia(int familia_id, String apellido_paterno, String apellido_materno) {
        this.familia_id = familia_id;
        this.apellido_paterno = apellido_paterno;
        this.apellido_materno = apellido_materno;
        this.numero_telefono = "Sin asignar";
        this.correo_electronico = "Sin asignar";
        this.direccion = "Sin asignar";
    }

    public Familia (){}

    public Familia(int familia_id){
        this.familia_id = familia_id;
        this.apellido_paterno = "No asignado";
        this.apellido_materno = "No asignado";
        this.numero_telefono = "No asignado";
        this.correo_electronico = "No asignado";
        this.direccion = "No asignado";
    }

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
}
