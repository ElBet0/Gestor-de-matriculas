/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.deuda;

import java.time.LocalDate;

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
    private LocalDate fecha_emision;
    /**
     * La fecha de vencimiento de la deuda.
     */
    private LocalDate fecha_vencimiento;
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
    private Pago cancelado;
}
