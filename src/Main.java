import ModuloMatricula.Matricula;
import ModuloMatricula.PeriodoAcademico;

public class Main {
    public static void main(String[] args) {
        PeriodoAcademico periodoAcademico = new PeriodoAcademico();
        Matricula matricula = new Matricula();
        periodoAcademico.agregarMatricula( matricula );
        matricula.setPension(50000);
        System.out.println(matricula);
    }
}