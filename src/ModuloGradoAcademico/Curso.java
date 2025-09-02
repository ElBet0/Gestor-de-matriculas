package ModuloGradoAcademico;

import java.util.ArrayList;
import java.util.List;

public class Curso {
    private int codigo_curso;
    private String nombre;
    private String descripcion;
    private String abreviatura;
    private int horas_semanales;
    private boolean activo;
    private List<Competencia> competencias = new ArrayList<>();
}
