package ModuloGradoAcademico;

import java.util.ArrayList;
import java.util.List;

/**
 * La clase Competencia representa una competencia académica dentro de un curso.
 * Contiene información sobre la competencia, su peso y las calificaciones asociadas.
 */
public class Competencia {
    /**
     * El código único que identifica la competencia.
     */
    private int codigo_competencia;
    /**
     * El nombre de la competencia.
     */
    private String nombre;
    /**
     * Una descripción de la competencia.
     */
    private String descripcion;
    /**
     * El peso o ponderación de la competencia en el cálculo final.
     */
    private String peso_competencia;
    /**
     * Indica si la competencia está activa o no.
     */
    private boolean activo;
    /**
     * La lista de calificaciones asociadas a esta competencia.
     */
    private List<Calificaciones> notas = new ArrayList<>();
}
