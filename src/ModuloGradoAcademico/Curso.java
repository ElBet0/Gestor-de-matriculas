package ModuloGradoAcademico;

import java.util.ArrayList;
import java.util.List;

/**
 * La clase Curso representa una materia o curso académico.
 * Contiene información sobre el curso, como su nombre, descripción, horas semanales y competencias asociadas.
 */
public class Curso {
    /**
     * El código único que identifica el curso.
     */
    private int codigo_curso;
    /**
     * El nombre del curso.
     */
    private String nombre;
    /**
     * Una descripción del curso.
     */
    private String descripcion;
    /**
     * La abreviatura del nombre del curso.
     */
    private String abreviatura;
    /**
     * El número de horas semanales del curso.
     */
    private int horas_semanales;
    /**
     * Indica si el curso está activo o no.
     */
    private boolean activo;
    /**
     * La lista de competencias asociadas a este curso.
     */
    private List<Competencia> competencias = new ArrayList<>();
}
