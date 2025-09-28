/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.alumno;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;
import pe.edu.sis.model.deuda.Deuda;
/**
 *
 * @author seinc
 */
public class Alumno {

    private int alumno_id;
    private String nombre;
    private int dni;
    private Date fecha_nacimiento;
    private Date fecha_ingreso;
    private char sexo;
    private String religion;
    private Familia padres;
    private String observaciones; //creo que deberia ser una lista
    private double pension_base;

    public Alumno(String nombre, int dni, Date fecha_nacimiento, Date fecha_ingreso, char sexo, String religion,
                  Familia padres, String observaciones, double pension_base) {
        this.nombre = nombre;
        this.dni = dni;
        this.fecha_nacimiento = fecha_nacimiento;
        this.fecha_ingreso = fecha_ingreso;
        this.sexo = sexo;
        this.religion = religion;
        this.padres = new Familia(padres);
        this.observaciones = observaciones;
        this.pension_base = pension_base;
    }

    public Alumno(String nombre, int dni, Date fecha_ingreso, char sexo, Familia padres, double pension_base) {
        this.nombre = nombre;
        this.dni = dni;
        this.fecha_nacimiento = new Date(2000, 1, 1);
        this.fecha_ingreso = fecha_ingreso;
        this.sexo = sexo;
        this.religion = "Sin asignar";
        this.padres = new Familia(padres);
        this.observaciones = "Sin Observaciones";
        this.pension_base = pension_base;
    }

    public Alumno(int alumno_id){
        this.alumno_id = alumno_id;
        this.nombre = "No asignado";
        this.dni = 0;
        this.fecha_nacimiento = new Date();
        this.fecha_ingreso = new Date();
        this.sexo = '.';
        this.religion = "No asignado";
        this.padres = null;
        this.observaciones = "Sin observaciones";
        this.pension_base = 0;
    }

    @SuppressWarnings("IncompleteCopyConstructor")
    public Alumno(Alumno other) {
        this.alumno_id = other.alumno_id;
        this.nombre = other.nombre;
        this.dni = other.dni;
        this.fecha_nacimiento = other.fecha_nacimiento;
        this.fecha_ingreso = other.fecha_ingreso;
        this.sexo = other.sexo;
        this.religion = other.religion;
        this.padres = other.padres;
        this.padres = new Familia(this.padres);
        this.observaciones = other.observaciones;
        this.pension_base = other.pension_base;
    }

    public Alumno(){
        this.nombre = "Error al leer alumno";
    }

    @Override
    public String toString() {
        String apellidos;
        if(this.padres == null){
            apellidos = "No hay apellidos";
        }else{
            apellidos = ", apellido paterno="+this.padres.getApellido_paterno();
        }
        
        return "Alumno{" + "alumno_id=" + alumno_id + ", nombre=" + nombre +
                apellidos +
                ", dni=" + dni + ", fecha_nacimiento=" + fecha_nacimiento + 
                ", fecha_ingreso=" + fecha_ingreso + ", sexo=" + sexo + 
                ", religion=" + religion + ", observaciones=" + observaciones + 
                ", pension_base=" + pension_base + '}' ;
                
    }
    

    public int getAlumno_id() {
        return alumno_id;
    }

    public void setAlumno_id(int alumno_id) {
        this.alumno_id = alumno_id;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(Date fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public Date getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(Date fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public char getSexo() {
        return sexo;
    }

    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    public String getReligion() {
        return religion;
    }

    public void setReligion(String religion) {
        this.religion = religion;
    }

    public Familia getPadres() {
        return new Familia(padres);
    }

    public void setPadres(Familia padres) {
        this.padres = new Familia(padres);
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public double getPension_base() {
        return pension_base;
    }

    public void setPension_base(double pension_base) {
        this.pension_base = pension_base;
    }
}
