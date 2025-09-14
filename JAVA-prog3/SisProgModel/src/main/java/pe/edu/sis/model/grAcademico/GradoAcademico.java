/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.grAcademico;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author seinc
 */
public class GradoAcademico {
    private int grado_academico_id;
    private String nombre;
    private String abreviatura;
    private List<Curso> cursos=new ArrayList<>();
}
