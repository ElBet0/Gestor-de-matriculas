/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.usuario;

import jakarta.xml.bind.annotation.XmlType;
import java.util.Date;

/**
 *
 * @author sdelr
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Personal {

    private int personal_id;
    private String nombre;
    private String Apellido_paterno;
    private String Apellido_materno;
    private String correo_electronico;
    private String telefono;
    private double salario;
    private Date Fecha_Contratacion;
    private Date fin_fecha_Contratacion;
    private TipoContrato tipo_contrato;
    private Cargo cargo;
    private int dni;

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    /**
     * @return the personal_id
     */
    public int getPersonal_id() {
        return personal_id;
    }

    /**
     * @param personal_id the personal_id to set
     */
    public void setPersonal_id(int personal_id) {
        this.personal_id = personal_id;
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
     * @return the Apellido_paterno
     */
    public String getApellido_paterno() {
        return Apellido_paterno;
    }

    /**
     * @param Apellido_paterno the Apellido_paterno to set
     */
    public void setApellido_paterno(String Apellido_paterno) {
        this.Apellido_paterno = Apellido_paterno;
    }

    /**
     * @return the Apellido_materno
     */
    public String getApellido_materno() {
        return Apellido_materno;
    }

    /**
     * @param Apellido_materno the Apellido_materno to set
     */
    public void setApellido_materno(String Apellido_materno) {
        this.Apellido_materno = Apellido_materno;
    }

    /**
     * @return the correo_electronico
     */
    public String getCorreo_electronico() {
        return correo_electronico;
    }

    /**
     * @param correo_electronico the correo_electronico to set
     */
    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    /**
     * @return the telefono
     */
    public String getTelefono() {
        return telefono;
    }

    /**
     * @param telefono the telefono to set
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * @return the salario
     */
    public double getSalario() {
        return salario;
    }

    /**
     * @param salario the salario to set
     */
    public void setSalario(double salario) {
        this.salario = salario;
    }

    /**
     * @return the Fecha_Contratacion
     */
    public Date getFecha_Contratacion() {
        return Fecha_Contratacion;
    }

    /**
     * @param Fecha_Contratacion the Fecha_Contratacion to set
     */
    public void setFecha_Contratacion(Date Fecha_Contratacion) {
        this.Fecha_Contratacion = Fecha_Contratacion;
    }

    /**
     * @return the fin_fecha_Contratacion
     */
    public Date getFin_fecha_Contratacion() {
        return fin_fecha_Contratacion;
    }

    /**
     * @param fin_fecha_Contratacion the fin_fecha_Contratacion to set
     */
    public void setFin_fecha_Contratacion(Date fin_fecha_Contratacion) {
        this.fin_fecha_Contratacion = fin_fecha_Contratacion;
    }

    /**
     * @return the tipo_contrato
     */
    public TipoContrato getTipo_contrato() {
        return tipo_contrato;
    }

    /**
     * @param tipo_contrato the tipo_contrato to set
     */
    public void setTipo_contrato(TipoContrato tipo_contrato) {
        this.tipo_contrato = tipo_contrato;
    }

    /**
     * @return the cargo
     */
    public Cargo getCargo() {
        return cargo;
    }

    /**
     * @param cargo the cargo to set
     */
    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }

}
