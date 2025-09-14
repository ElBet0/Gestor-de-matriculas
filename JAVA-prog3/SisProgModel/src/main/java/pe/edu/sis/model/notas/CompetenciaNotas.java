/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.util.ArrayList;
import java.util.List;
import pe.edu.sis.model.grAcademico.Competencia;

/**
 *
 * @author seinc
 */
public class CompetenciaNotas {
    private int competencia_notas_id;
    private double calificacion_final;
    private Competencia competencia;
    private List<NotaAcademica> nota_academica= new ArrayList<>();
}
