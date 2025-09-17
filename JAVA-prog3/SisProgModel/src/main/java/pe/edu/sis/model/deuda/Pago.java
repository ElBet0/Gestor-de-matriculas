/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

import java.util.Date;

/**
 *
 * @author seinc
 */
public class Pago {
    private int pago_id;
    private double monto;
    private Date fecha;
    private Medio medioPago;
    private String observaciones;
    private Deuda deuda;
    private int estado;

    public Pago(double monto, Date fecha, Medio medioPago, String observaciones, Deuda deuda) {
        this.monto = monto;
        this.fecha = fecha;
        this.medioPago = medioPago;
        this.observaciones = observaciones;
        this.deuda = deuda;
    }
    public Pago(){}

    /**
     * @return the deuda
     */
    public Deuda getDeuda() {
        return deuda;
    }

    /**
     * @param deuda the deuda to set
     */
    public void setDeuda(Deuda deuda) {
        this.deuda = deuda;
    }
    /**
     * @return the pago_id
     */
    public int getPago_id() {
        return pago_id;
    }

    /**
     * @param pago_id the pago_id to set
     */
    public void setPago_id(int pago_id) {
        this.pago_id = pago_id;
    }

    /**
     * @return the monto
     */
    public double getMonto() {
        return monto;
    }

    /**
     * @param monto the monto to set
     */
    public void setMonto(double monto) {
        this.monto = monto;
    }

    /**
     * @return the fecha
     */
    public Date getFecha() {
        return fecha;
    }

    /**
     * @param fecha the fecha to set
     */
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    /**
     * @return the medioPago
     */
    public Medio getMedioPago() {
        return medioPago;
    }

    /**
     * @param medioPago the medioPago to set
     */
    public void setMedioPago(Medio medioPago) {
        this.medioPago = medioPago;
    }

    /**
     * @return the observaciones
     */
    public String getObservaciones() {
        return observaciones;
    }

    /**
     * @param observaciones the observaciones to set
     */
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    @Override
    public String toString() {
        return "Pago{" + "pago_id=" + pago_id + ", monto=" + monto + ", fecha=" + fecha + ", medioPago=" + medioPago + ", observaciones=" + observaciones + ", deuda=" + deuda + ", estado=" + estado + '}';
    }
}
