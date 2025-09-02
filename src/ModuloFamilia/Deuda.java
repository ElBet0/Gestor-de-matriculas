package ModuloFamilia;

import java.time.LocalDate;

public class Deuda {
    private int codigo_deuda;
    private double monto;
    private boolean estado;
    private LocalDate fecha_emision;
    private LocalDate fecha_vencimiento;
    private String descripcion;
    private TipoDeuda concepto_deuda;
}
