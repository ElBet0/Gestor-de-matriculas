package ModuloGradoAcademico;

import java.util.ArrayList;
import java.util.List;

public class Competencia {
    private int codigo_competencia;
    private String nombre;
    private String descripcion;
    private String peso_competencia;
    private boolean activo;
    private List<Calificaciones> notas = new ArrayList<>();
}
