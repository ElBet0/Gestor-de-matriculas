/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.grAcademico.Curso;

/**
 *
 * @author seinc
 */
public class CursoNotas {
    private int curso_notas_id;
    private Curso curso;
    private double calificacion_final;
    private List<CompetenciaNotas> compe_notas=new ArrayList<>();
}
