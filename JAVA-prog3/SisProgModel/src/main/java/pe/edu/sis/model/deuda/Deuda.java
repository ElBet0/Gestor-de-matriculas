/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

import pe.edu.sis.model.alumno.Alumno;

import java.util.Date;

/**
 *
 * @author seinc
 */
public class Deuda {
    private int deuda_id;
    private double monto;
    private int estado;
    private Date fecha_emision;
    private Date fecha_vencimiento;
    private String descripcion;
    private double descuento;
    private TipoDeuda concepto_deuda;
    private Alumno alumno;

    public Deuda(double monto, Date fecha_emision, Date fecha_vencimiento, TipoDeuda concepto_deuda, Alumno alumno) {
        this.monto = monto;
        this.fecha_emision = fecha_emision;
        this.fecha_vencimiento = fecha_vencimiento;
        this.descripcion = "No definido";
        this.descuento = 0;
        this.concepto_deuda = concepto_deuda;
        this.alumno = alumno;
    }

    public Deuda() {
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

    public int getDeuda_id() {
        return deuda_id;
    }

    public void setDeuda_id(int deuda_id) {
        this.deuda_id = deuda_id;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Date getFecha_emision() {
        return fecha_emision;
    }

    public void setFecha_emision(Date fecha_emision) {
        this.fecha_emision = fecha_emision;
    }

    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public TipoDeuda getConcepto_deuda() {
        return concepto_deuda;
    }

    public void setConcepto_deuda(TipoDeuda concepto_deuda) {
        this.concepto_deuda = concepto_deuda;
    }

    @Override
    public String toString() {
        return "Deuda{" + "deuda_id=" + deuda_id + ", monto=" + monto + ", estado=" + estado + ", fecha_emision=" + fecha_emision + ", fecha_vencimiento=" + fecha_vencimiento + ", descripcion=" + descripcion + ", descuento=" + descuento + ", concepto_deuda=" + concepto_deuda + '}';
    }
}
