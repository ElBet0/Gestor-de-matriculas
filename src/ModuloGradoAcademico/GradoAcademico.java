package ModuloGradoAcademico;

import java.util.ArrayList;
import java.util.List;

public class GradoAcademico {
    private int codigo_grado;
    private String nombre;
    private int vacantes_disponibles;
    private int vacantes_ocupados;
    private int nivel;
    private String abreviatura;
    private List<Curso> cursos = new ArrayList<>();
}
