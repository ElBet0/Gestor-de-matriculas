package ModuloMatricula;

import ModuloFamilia.Alumno;
import ModuloGradoAcademico.GradoAcademico;
import ModuloNotas.Bimestre;

import java.util.List;

public class Matricula {
    private Alumno alum_matr;
    private PeriodoAcademico periodo_actual;/*REVISAR LUEGO*/
    private GradoAcademico cursos_ciclo;
    private List<Bimestre> bimestre;
    private int pension;
    @Override
    public String toString() {
        return "La pension es: " + pension;
    }
    public void setPension(int pension){this.pension=pension;}
}
