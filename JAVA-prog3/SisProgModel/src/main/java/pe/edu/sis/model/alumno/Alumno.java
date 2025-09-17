/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.alumno;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import pe.edu.sis.model.deuda.Deuda;
/**
 *
 * @author seinc
 */
public class Alumno {

    /**
     * El código único que identifica al alumno.
     */
    private int alumno_id;
    /**
     * El nombre del alumno.
     */
    private String nombre;
    /**
     * El dni del alumno
     */
    private int dni;
    /**
     * La fecha de nacimiento del alumno.
     */
    private Date fecha_nacimiento;
    /**
     * La fecha de ingreso del alumno a la institución.
     */
    private Date fecha_ingreso;
    /**
     * El sexo del alumno.
     */
    private char sexo;
    /**
     * La religión del alumno.
     */
    private String religion;
    /**
     * La familia a la que pertenece el alumno.
     */
    private Familia padres;
    /**
     * Observaciones del alumno
     */
    private String observaciones; //creo que deberia ser una lista
    
    /**
     * Pension base del alumno
     */
    private double pension_base;
    /**
     * La lista de deudas asociadas al alumno.
     */
    private List<Deuda> deudas = new ArrayList<>();

    public Alumno(String nombre, int dni, Date fecha_nacimiento, Date fecha_ingreso, char sexo, String religion, Familia padres, String observaciones, double pension_base) {
        this.nombre = nombre;
        this.dni = dni;
        this.fecha_nacimiento = fecha_nacimiento;
        this.fecha_ingreso = fecha_ingreso;
        this.sexo = sexo;
        this.religion = religion;
        this.padres = padres;
        this.observaciones = observaciones;
        this.pension_base = pension_base;
    }
    public Alumno(){}

    @Override
    public String toString() {
        return "Alumno{" + "alumno_id=" + alumno_id + ", nombre=" + nombre +
                ", apellido paterno="+this.padres.getApellido_paterno() +
                ", apellido materno="+this.padres.getApellido_materno() +  
                ", dni=" + dni + ", fecha_nacimiento=" + fecha_nacimiento + 
                ", fecha_ingreso=" + fecha_ingreso + ", sexo=" + sexo + 
                ", religion=" + religion + ", observaciones=" + observaciones + 
                ", pension_base=" + pension_base + '}' ;
                
    }
    

    /**
     * @return the alumno_id
     */
    public int getAlumno_id() {
        return alumno_id;
    }

    /**
     * @param alumno_id the alumno_id to set
     */
    public void setAlumno_id(int alumno_id) {
        this.alumno_id = alumno_id;
    }

    /**
     * @return the dni
     */
    public int getDni() {
        return dni;
    }

    /**
     * @param dni the dni to set
     */
    public void setDni(int dni) {
        this.dni = dni;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    /**
     * @return the fecha_nacimiento
     */
    public Date getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    /**
     * @param fecha_nacimiento the fecha_nacimiento to set
     */
    public void setFecha_nacimiento(Date fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    /**
     * @return the fecha_ingreso
     */
    public Date getFecha_ingreso() {
        return fecha_ingreso;
    }

    /**
     * @param fecha_ingreso the fecha_ingreso to set
     */
    public void setFecha_ingreso(Date fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    /**
     * @return the sexo
     */
    public char getSexo() {
        return sexo;
    }

    /**
     * @param sexo the sexo to set
     */
    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    /**
     * @return the religion
     */
    public String getReligion() {
        return religion;
    }

    /**
     * @param religion the religion to set
     */
    public void setReligion(String religion) {
        this.religion = religion;
    }

    /**
     * @return the padres
     */
    public Familia getPadres() {
        return padres;
    }

    /**
     * @param padres the padres to set
     */
    public void setPadres(Familia padres) {
        this.padres = padres;
    }

    /**
     * @return the observaciones
     */
    public String getObservaciones() {
        return observaciones;
    }

    /**
     * @param observaciones the observaciones to set
     */
    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    /**
     * @return the pension_base
     */
    public double getPension_base() {
        return pension_base;
    }

    /**
     * @param pension_base the pension_base to set
     */
    public void setPension_base(double pension_base) {
        this.pension_base = pension_base;
    }
    /**
     * @return the deudas
     */
    public List<Deuda> getDeudas() {
        return new ArrayList<>(deudas);
    }

    /**
     * @param deudas the deudas to set
     */
    public void setDeudas(List<Deuda> deudas) {
        this.deudas = deudas;
    }
}
