/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

import jakarta.xml.bind.annotation.XmlType;
import java.util.Date;

/**
 *
 * @author seinc
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Pago {
    public static final String MedioPago = null;
    private int pago_id;
    private double monto;
    private Date fecha;
    private MedioPago medio;
    private String observaciones;
    private Deuda deuda;
    private int activo;
 

    public Pago(double monto, Date fecha, Deuda deuda) {
        this.monto = monto;
        this.fecha = fecha;
        this.observaciones = "Sin observaciones";
        this.deuda = deuda;
        this.activo=1;
    }

    public Pago(double monto, Date fecha, MedioPago medio, String observaciones, Deuda deuda) {
        this.monto = monto;
        this.fecha = fecha;
        this.medio = medio;
        this.observaciones = observaciones;
        this.deuda = deuda;
    }

    public Pago() {
    }

    public Deuda getDeuda() {
        return deuda;
    }

    public void setDeuda(Deuda deuda) {
        this.deuda = deuda;
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

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
     public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "Pago{" + "pago_id=" + pago_id + ", monto=" + monto + ", fecha="
                + fecha + ", observaciones=" + observaciones + ", deuda=" + deuda;
    }

    /**
     * @return the medio
     */
    public MedioPago getMedio() {
        return medio;
    }

    /**
     * @param medio the medio to set
     */
    public void setMedio(MedioPago medio) {
        this.medio = medio;
    }
}
