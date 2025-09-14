/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.notas;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class Bimestre {
    private int bimestre_id;
    private String descripcion;
    private LocalDate fecha_inicio;
    private LocalDate fecha_fin;
    private List<CursoNotas> nota = new ArrayList<>();
}
