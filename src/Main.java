import ModuloMatricula.Matricula;
import ModuloMatricula.PeriodoAcademico;
//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        PeriodoAcademico periodoAcademico = new PeriodoAcademico();
        Matricula matricula = new Matricula();
        periodoAcademico.agregarMatricula( matricula );
        matricula.setPension(50000);
        System.out.println(matricula);
    }
}