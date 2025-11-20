/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.usuario;

import jakarta.xml.bind.annotation.XmlType;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.Date;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 *
 * @author seinc
 */
@XmlType(namespace = "http://sisprog.com/model")
public class Usuario {
    private int usuario_id;
    private String hashClave;
    private String nombre;
    private String salt;
    private Date ultimo_acceso;
    private Rol rol;
    private int iteracion;
    public Usuario(){}

    public Usuario(String nombre, String Password, Rol rol) throws Exception {
        this.nombre = nombre;
        CrearSaltYHashClave(Password);
        this.ultimo_acceso = new Date();
        this.rol = rol;
    }

    public Usuario(String hashClave, int iteracion, String nombre, Rol rol, String salt, Date ultimo_acceso) {
        this.hashClave = hashClave;
        this.iteracion = iteracion;
        this.nombre = nombre;
        this.rol = rol;
        this.salt = salt;
        this.ultimo_acceso = ultimo_acceso;
    }

    /**
     * @return the usuario_id
     */
    public int getUsuario_id() {
        return usuario_id;
    }

    /**
     * @param usuario_id the usuario_id to set
     */
    public void setUsuario_id(int usuario_id) {
        this.usuario_id = usuario_id;
    }

    /**
     * @return the hashClave
     */
    public String getHashClave() {
        return hashClave;
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
     * @return the ultimo_acceso
     */
    public Date getUltimo_acceso() {
        return ultimo_acceso;
    }

    /**
     * @param ultimo_acceso the ultimo_acceso to set
     */
    public void setUltimo_acceso(Date ultimo_acceso) {
        this.ultimo_acceso = ultimo_acceso;
    }

    /**
     * @return the rol
     */
    public Rol getRol() {
        return rol;
    }

    /**
     * @param rol the rol to set
     */
    public void setRol(Rol rol) {
        this.rol = rol;
    }

    /**
     * @return the Salt
     */
    public String getSalt() {
        return salt;
    }

    /**
     * @return the Iteracion
     */
    public int getIteracion() {
        return iteracion;
    }

    private void CrearSaltYHashClave(String password) throws Exception {
        final int ITERATIONS = 65536;
        final int KEY_LENGTH = 256; // bits
        final int SALT_LENGTH = 16; // bytes

        // Generar sal aleatoria
        byte[] _salt = new byte[SALT_LENGTH];
        SecureRandom random = new SecureRandom();
        random.nextBytes(_salt);

        // Crear especificación de clave
        KeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                _salt,
                ITERATIONS,
                KEY_LENGTH);

        // Generar hash
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] _hash = factory.generateSecret(spec).getEncoded();

        // Convertir a Base64 para almacenamiento
        hashClave = Base64.getEncoder().encodeToString(_hash);
        setSalt(Base64.getEncoder().encodeToString(_salt));
        setIteracion(ITERATIONS);
    }

    /**
     * @param salt the salt to set
     */
    public void setSalt(String salt) {
        this.salt = salt;
    }

    /**
     * @param iteracion the iteracion to set
     */
    public void setIteracion(int iteracion) {
        this.iteracion = iteracion;
    }
}