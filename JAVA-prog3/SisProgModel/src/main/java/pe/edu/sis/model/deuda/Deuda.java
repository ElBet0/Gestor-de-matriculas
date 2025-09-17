/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

import java.util.Date;
import pe.edu.sis.model.alumno.Alumno;

/**
 *
 * @author seinc
 */
public class Deuda {
    /**
     * El código único que identifica la deuda.
     */
    private int deuda_id;
    /**
     * El monto de la deuda.
     */
    private double monto;
    /**
     * El estado de la deuda (pagada o no pagada).
     */
    private int estado;
    /**
     * La fecha en que se emitió la deuda.
     */
    private Date fecha_emision;
    /**
     * La fecha de vencimiento de la deuda.
     */
    private Date fecha_vencimiento;
    /**
     * Una descripción detallada de la deuda.
     */
    private String descripcion;
    /**
     * Descuento aplicado a la deuda
     */
    private double descuento;
    /**
     * El tipo o concepto de la deuda.
     */
    private TipoDeuda concepto_deuda;
    /**
     * Acceso en caso se haya cancelado la deuda
     */
    private Alumno alumno;

    public Deuda(double monto, Date fecha_emision, Date fecha_vencimiento, String descripcion, double descuento, TipoDeuda concepto_deuda, Alumno alumno) {
        this.monto = monto;
        this.fecha_emision = fecha_emision;
        this.fecha_vencimiento = fecha_vencimiento;
        this.descripcion = descripcion;
        this.descuento = descuento;
        this.concepto_deuda = concepto_deuda;
        this.alumno = alumno;
    }

    public Deuda() {
    }

    /**
     * @return the alumno
     */
    public Alumno getAlumno() {
        return alumno;
    }

    /**
     * @param alumno the alumno to set
     */
    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    /**
     * @return the deuda_id
     */
    public int getDeuda_id() {
        return deuda_id;
    }

    /**
     * @param deuda_id the deuda_id to set
     */
    public void setDeuda_id(int deuda_id) {
        this.deuda_id = deuda_id;
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
     * @return the estado
     */
    public int getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(int estado) {
        this.estado = estado;
    }

    /**
     * @return the fecha_emision
     */
    public Date getFecha_emision() {
        return fecha_emision;
    }

    /**
     * @param fecha_emision the fecha_emision to set
     */
    public void setFecha_emision(Date fecha_emision) {
        this.fecha_emision = fecha_emision;
    }

    /**
     * @return the fecha_vencimiento
     */
    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    /**
     * @param fecha_vencimiento the fecha_vencimiento to set
     */
    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
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
     * @return the descuento
     */
    public double getDescuento() {
        return descuento;
    }

    /**
     * @param descuento the descuento to set
     */
    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    /**
     * @return the concepto_deuda
     */
    public TipoDeuda getConcepto_deuda() {
        return concepto_deuda;
    }

    /**
     * @param concepto_deuda the concepto_deuda to set
     */
    public void setConcepto_deuda(TipoDeuda concepto_deuda) {
        this.concepto_deuda = concepto_deuda;
    }

    @Override
    public String toString() {
        return "Deuda{" + "deuda_id=" + deuda_id + ", monto=" + monto + ", estado=" + estado + ", fecha_emision=" + fecha_emision + ", fecha_vencimiento=" + fecha_vencimiento + ", descripcion=" + descripcion + ", descuento=" + descuento + ", concepto_deuda=" + concepto_deuda + '}';
    }    
    
    
}
