package ModuloNotas;

import java.time.LocalDate;
import java.util.List;

/**
 * La clase Bimestre representa un período de evaluación bimestral.
 * Contiene información sobre el bimestre, sus fechas y los cursos académicos asociados.
 */
public class Bimestre {
    /**
     * El código único que identifica el bimestre.
     */
    private int codigo_bimestre;
    /**
     * Una descripción del bimestre.
     */
    private String descripcion;
    /**
     * La fecha de inicio del bimestre.
     */
    private LocalDate fecha_inicio;
    /**
     * La fecha de finalización del bimestre.
     */
    private LocalDate fecha_final;
    /**
     * La lista de cursos académicos que se imparten en este bimestre.
     */
    private List<CursoAcademico> cursos_acade;

}
