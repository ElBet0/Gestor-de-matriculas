/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.usuario;

import java.time.LocalDate;

/**
 *
 * @author seinc
 */
public class Usuario {
    private int usuario_id;
    private String hashClave;
    private String nombre;
    private String apellido_paterno;
    private String apellido_materno;
    private int estado;
    private String email;
    private LocalDate ultimo_acceso;
    private Rol rol;
}
