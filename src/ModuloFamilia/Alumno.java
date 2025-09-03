package ModuloFamilia;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * La clase Alumno representa a un estudiante en el sistema.
 * Contiene información personal del alumno, así como su relación con una familia y sus deudas.
 */
public class Alumno {
    /**
     * El código único que identifica al alumno.
     */
    private int codigo_alumno;
    /**
     * El nombre del alumno.
     */
    private String nombre_alumno;
    /**
     * El apellido paterno del alumno.
     */
    private String apellido_paterno;
    /**
     * El apellido materno del alumno.
     */
    private String apellido_materno;
    /**
     * La fecha de nacimiento del alumno.
     */
    private LocalDate fecha_nacimiento;
    /**
     * La fecha de ingreso del alumno a la institución.
     */
    private LocalDate fecha_ingreso;
    /**
     * El sexo del alumno.
     */
    private String sexo;
    /**
     * La religión del alumno.
     */
    private Religiones religion;
    /**
     * La familia a la que pertenece el alumno.
     */
    private Familia papis;
    /**
     * La lista de deudas asociadas al alumno.
     */
    private List<Deuda> deudas = new ArrayList<>();
}
