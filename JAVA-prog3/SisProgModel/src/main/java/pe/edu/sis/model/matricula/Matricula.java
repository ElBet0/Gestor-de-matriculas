/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.matricula;

import pe.edu.sis.model.alumno.Alumno;
import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.grAcademico.GradoAcademico;
import pe.edu.sis.model.notas.Bimestre;
/**
 *
 * @author seinc
 */
public class Matricula {
    private int matricula_id;
    private Alumno alumno;
    private PeriodoAcademico periodo;
    private List<Bimestre> bimestres=new ArrayList<>();
    private GradoAcademico grado;
}
