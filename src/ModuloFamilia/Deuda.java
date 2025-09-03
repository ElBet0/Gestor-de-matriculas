package ModuloFamilia;

import java.time.LocalDate;

/**
 * La clase Deuda representa una obligación financiera de un alumno.
 * Contiene información sobre el monto, estado, fechas y descripción de la deuda.
 */
public class Deuda {
    /**
     * El código único que identifica la deuda.
     */
    private int codigo_deuda;
    /**
     * El monto de la deuda.
     */
    private double monto;
    /**
     * El estado de la deuda (pagada o no pagada).
     */
    private boolean estado;
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
     * El tipo o concepto de la deuda.
     */
    private TipoDeuda concepto_deuda;
}
