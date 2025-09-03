package ModuloNotas;

import ModuloGradoAcademico.Competencia;
import java.util.List;

/**
 * La clase CompetenciaAcademica representa la calificación de un alumno en una competencia específica.
 * Contiene información sobre la calificación, la competencia evaluada y las notas académicas asociadas.
 */
public class CompetenciaAcademica {
    /**
     * El código único que identifica el registro de la competencia académica.
     */
    private int codigo;
    /**
     * La calificación obtenida en la competencia.
     */
    private double calificacion;
    /**
     * La competencia que se está evaluando.
     */
    private Competencia competencia;
    /**
     * La lista de notas académicas que componen la calificación de la competencia.
     */
    private List<NotaAcademica> notas;
}
