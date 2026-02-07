/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.usuario;

import jakarta.xml.bind.annotation.XmlType;

/**
 *
 * @author sdelr
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Cargo {
    private int cargo_id;
    private String nombre;
    /**
     * @return the cargo_id
     */
    public int getCargo_id() {
        return cargo_id;
    }

    /**
     * @param cargo_id the cargo_id to set
     */
    public void setCargo_id(int cargo_id) {
        this.cargo_id = cargo_id;
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
   
}
