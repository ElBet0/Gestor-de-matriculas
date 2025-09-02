package ModuloFamilia;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Alumno {
    private int codigo_alumno;
    private String nombre_alumno;
    private String apellido_paterno;
    private String apellido_materno;
    private LocalDate fecha_nacimiento;
    private LocalDate fecha_ingreso;
    private String sexo;
    private Religiones religion;
    private Familia papis;
    private List<Deuda> deudas = new ArrayList<>();
}
