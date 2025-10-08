/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

/**
 *
 * @author seinc
 */
public class TipoDeuda {
    private int tipo_deuda_id;
    private String descripcion;
    private double monto_general;
    /**
     * @return the tipo_deuda_id
     */
    public int getTipo_deuda_id() {
        return tipo_deuda_id;
    }

    /**
     * @param tipo_deuda_id the tipo_deuda_id to set
     */
    public void setTipo_deuda_id(int tipo_deuda_id) {
        this.tipo_deuda_id = tipo_deuda_id;
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
        return "TipoDeuda{" + "tipo_deuda_id=" + tipo_deuda_id + ", descripcion=" + descripcion + ", monto_general=" 
                + monto_general ;
    }
    
}
