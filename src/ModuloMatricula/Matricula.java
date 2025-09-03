package ModuloMatricula;

import ModuloFamilia.Alumno;
import ModuloGradoAcademico.GradoAcademico;
import ModuloNotas.Bimestre;
import java.util.List;

/**
 * La clase Matricula representa la inscripción de un alumno en un período académico.
 * Contiene información sobre el alumno, el período, el grado, los bimestres y la pensión.
 */
public class Matricula {
    /**
     * El alumno que está matriculado.
     */
    private Alumno alum_matr;
    /**
     * El período académico en el que el alumno está matriculado.
     */
    private PeriodoAcademico periodo_actual;/*REVISAR LUEGO*/
    /**
     * El grado académico y los cursos en los que el alumno está matriculado.
     */
    private GradoAcademico cursos_ciclo;
    /**
     * La lista de bimestres del período académico.
     */
    private List<Bimestre> bimestre;
    /**
     * El monto de la pensión de la matrícula.
     */
    private int pension;

    /**
     * Devuelve una representación en cadena de la matrícula, mostrando la pensión.
     * @return una cadena que representa la pensión de la matrícula.
     */
    @Override
    public String toString() {
        return "La pension es: " + pension;
    }

    /**
     * Establece el monto de la pensión de la matrícula.
     * @param pension el monto de la pensión.
     */
    public void setPension(int pension) {
        this.pension = pension;
    }
}
