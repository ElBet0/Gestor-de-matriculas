/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.usuario;

import java.util.Date;

/**
 *
 * @author seinc
 */
public class Usuario {
    private int usuario_id;
    private String hashClave;
    private String nombre;
    private String Salt;
    private Date ultimo_acceso;
    private Rol rol;
    private int Iteracion;

    public Usuario(String hashClave, String nombre, Date ultimo_acceso, Rol rol) {
        this.hashClave = hashClave;
        this.nombre = nombre;
        this.ultimo_acceso = ultimo_acceso;
        this.rol = rol;
    }
    public Usuario(){}

    /**
     * @return the usuario_id
     */
    public int getUsuario_id() {
        return usuario_id;
    }

    /**
     * @param usuario_id the usuario_id to set
     */
    public void setUsuario_id(int usuario_id) {
        this.usuario_id = usuario_id;
    }

    /**
     * @return the hashClave
     */
    public String getHashClave() {
        return hashClave;
    }

    /**
     * @param hashClave the hashClave to set
     */
    public void setHashClave(String hashClave) {
        this.hashClave = hashClave;
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
     * @return the ultimo_acceso
     */
    public Date getUltimo_acceso() {
        return ultimo_acceso;
    }

    /**
     * @param ultimo_acceso the ultimo_acceso to set
     */
    public void setUltimo_acceso(Date ultimo_acceso) {
        this.ultimo_acceso = ultimo_acceso;
    }

    /**
     * @return the rol
     */
    public Rol getRol() {
        return rol;
    }

    /**
     * @param rol the rol to set
     */
    public void setRol(Rol rol) {
        this.rol = rol;
    }

    /**
     * @return the Salt
     */
    public String getSalt() {
        return Salt;
    }

    /**
     * @param Salt the Salt to set
     */
    public void setSalt(String Salt) {
        this.Salt = Salt;
    }

    /**
     * @return the Iteracion
     */
    public int getIteracion() {
        return Iteracion;
    }

    /**
     * @param Iteracion the Iteracion to set
     */
    public void setIteracion(int Iteracion) {
        this.Iteracion = Iteracion;
    }
    
}
