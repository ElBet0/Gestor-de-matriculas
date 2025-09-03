package ModuloNotas;

import ModuloGradoAcademico.Calificaciones;
import java.time.LocalDate;

/**
 * La clase NotaAcademica representa la nota de un alumno en una calificación específica.
 * Contiene información sobre la nota, su descripción, fecha de registro y la calificación a la que pertenece.
 */
public class NotaAcademica {
    /**
     * El código único que identifica la nota académica.
     */
    private int codigo_notaComp;
    /**
     * Una descripción de la nota.
     */
    private String descripcion;
    /**
     * El valor numérico de la nota académica.
     */
    private double nota_academica; //NOTA REAL
    /**
     * La fecha en que se registró la nota.
     */
    private LocalDate fecha_registro;
    /**
     * La calificación a la que pertenece esta nota.
     */
    private Calificaciones calificacion;

}
