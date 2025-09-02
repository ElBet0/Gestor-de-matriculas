package ModuloMatricula;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PeriodoAcademico {
    public int getCodigo_periodo() {
        return codigo_periodo;
    }

    public void setCodigo_periodo(int codigo_periodo) {
        this.codigo_periodo = codigo_periodo;
    }

    private int codigo_periodo;
    private String nombre;
    private LocalDate fecha_inicio;
    private LocalDate fecha_final;
    private EstadoPeriodoAcademico estado;
    private VacantesPorGrado vacantes;
    private List<Matricula> matriculados = new ArrayList<>();
    public void agregarMatricula(Matricula m){
        this.matriculados.add(m);
    }
}
