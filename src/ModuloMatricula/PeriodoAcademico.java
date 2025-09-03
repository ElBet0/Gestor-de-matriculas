package ModuloMatricula;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * La clase PeriodoAcademico representa un período de tiempo académico (por ejemplo, un semestre o un año).
 * Contiene información sobre el período, su estado, las vacantes y los alumnos matriculados.
 */
public class PeriodoAcademico {
    /**
     * El código único que identifica el período académico.
     */
    private int codigo_periodo;
    /**
     * El nombre del período académico.
     */
    private String nombre;
    /**
     * La fecha de inicio del período académico.
     */
    private LocalDate fecha_inicio;
    /**
     * La fecha de finalización del período académico.
     */
    private LocalDate fecha_final;
    /**
     * El estado actual del período académico.
     */
    private EstadoPeriodoAcademico estado;
    /**
     * Las vacantes disponibles para el período académico.
     */
    private VacantesPorGrado vacantes;
    /**
     * La lista de alumnos matriculados en este período académico.
     */
    private List<Matricula> matriculados = new ArrayList<>();

    /**
     * Obtiene el código del período académico.
     * @return el código del período académico.
     */
    public int getCodigo_periodo() {
        return codigo_periodo;
    }

    /**
     * Establece el código del período académico.
     * @param codigo_periodo el nuevo código del período académico.
     */
    public void setCodigo_periodo(int codigo_periodo) {
        this.codigo_periodo = codigo_periodo;
    }

    /**
     * Agrega una matrícula a la lista de matriculados del período académico.
     * @param m la matrícula a agregar.
     */
    public void agregarMatricula(Matricula m){
        this.matriculados.add(m);
    }
}
