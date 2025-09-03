package ModuloMatricula;

import ModuloGradoAcademico.GradoAcademico;

/**
 * La clase VacantesPorGrado representa el número de vacantes para un grado académico específico.
 * Contiene información sobre las vacantes iniciales, disponibles y ocupadas.
 */
public class VacantesPorGrado {
    /**
     * El código único que identifica el registro de vacantes.
     */
    private int codigo;
    /**
     * El número inicial de vacantes para el grado.
     */
    private int vacantes_iniciales;
    /**
     * El número de vacantes actualmente disponibles.
     */
    private int vacantes_disponibles;
    /**
     * El número de vacantes que ya han sido ocupadas.
     */
    private int vacantes_ocupadas;
    /**
     * El grado académico al que se refieren estas vacantes.
     */
    private GradoAcademico grado_academico;
}
