/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

import jakarta.xml.bind.annotation.XmlType;

/**
 *
 * @author seinc
 */
@XmlType(namespace = "http://sisprog.com/model")
public class TipoDeuda {
    public static final String MedioPago = null;
    private int id_tipo_deuda;
    private String descripcion;
    private double monto_general;
    private int activo;
    
    public TipoDeuda(String descripcion, double monto_general) {
        this.descripcion = descripcion;
        this.monto_general = monto_general;
        this.activo=1;
    }

    public TipoDeuda() {
    }

    /**
     * @return the tipo_deuda_id
     */
    public int getId_tipo_deuda() {
        return id_tipo_deuda;
    }
    
    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    /**
     * @param tipo_deuda_id the tipo_deuda_id to set
     */
    public void setId_tipo_deuda(int tipo_deuda_id) {
        this.id_tipo_deuda = tipo_deuda_id;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the monto_general
     */
    public double getMonto_general() {
        return monto_general;
    }

    /**
     * @param monto_general the monto_general to set
     */
    public void setMonto_general(double monto_general) {
        this.monto_general = monto_general;
    }

    @Override
    public String toString() {
        return "TipoDeuda{" + "tipo_deuda_id=" + id_tipo_deuda + ", descripcion=" + descripcion + ", monto_general="
                + monto_general;
    }

}
