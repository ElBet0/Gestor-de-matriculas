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

    public Pago(double monto, Date fecha, Medio medioPago, Deuda deuda) {
        this.monto = monto;
        this.fecha = fecha;
        this.medioPago = medioPago;
        this.observaciones = "Sin observaciones";
        this.deuda = Deuda.Clone(deuda);
    }

    public static Pago Clone(Pago pago){
        return pago == null ? null : new Pago(pago);
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    private Pago(Pago other) {
        this.pago_id = other.pago_id;
        this.monto = other.monto;
        this.fecha = other.fecha;
        this.medioPago = other.medioPago;
        this.observaciones = other.observaciones;
        this.deuda = Deuda.Clone(other.deuda);
        this.estado = other.estado;
    }

    public Pago(){}

    public Deuda getDeuda() {
        return Deuda.Clone(deuda);
    }

    public void setDeuda(Deuda deuda) {
        this.deuda = Deuda.Clone(deuda);
    }

    public int getPago_id() {
        return pago_id;
    }

    public void setPago_id(int pago_id) {
        this.pago_id = pago_id;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Medio getMedioPago() {
        return medioPago;
    }

    public void setMedioPago(Medio medioPago) {
        this.medioPago = medioPago;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    @Override
    public String toString() {
        return "Pago{" + "pago_id=" + pago_id + ", monto=" + monto + ", fecha=" + fecha + ", medioPago=" + medioPago + ", observaciones=" + observaciones + ", deuda=" + deuda + ", estado=" + estado + '}';
    }
}
