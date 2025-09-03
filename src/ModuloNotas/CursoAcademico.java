package ModuloNotas;

import ModuloGradoAcademico.Curso;
import java.util.List;

/**
 * La clase CursoAcademico representa la calificación de un alumno in un curso específico.
 * Contiene información sobre la calificación, el curso evaluado y las competencias académicas asociadas.
 */
public class CursoAcademico {
    /**
     * El código único que identifica el registro del curso académico.
     */
    private int codigo;
    /**
     * La calificación obtenida en el curso.
     */
    private double calificacion;
    /**
     * El curso que se está evaluando.
     */
    private Curso curso;
    /**
     * La lista de competencias académicas que componen la calificación del curso.
     */
    private List<CompetenciaAcademica> compe;
}
