package ModuloGradoAcademico;

import java.util.ArrayList;
import java.util.List;

/**
 * La clase GradoAcademico representa un grado o nivel educativo.
 * Contiene información sobre el grado, como su nombre, nivel, vacantes y cursos asociados.
 */
public class GradoAcademico {
    /**
     * El código único que identifica el grado académico.
     */
    private int codigo_grado;
    /**
     * El nombre del grado académico.
     */
    private String nombre;
    /**
     * El número de vacantes disponibles para este grado.
     */
    private int vacantes_disponibles;
    /**
     * El número de vacantes ocupadas en este grado.
     */
    private int vacantes_ocupados;
    /**
     * El nivel educativo al que pertenece el grado (por ejemplo, 1 para primer grado).
     */
    private int nivel;
    /**
     * La abreviatura del nombre del grado.
     */
    private String abreviatura;
    /**
     * La lista de cursos asociados a este grado académico.
     */
    private List<Curso> cursos = new ArrayList<>();
}
