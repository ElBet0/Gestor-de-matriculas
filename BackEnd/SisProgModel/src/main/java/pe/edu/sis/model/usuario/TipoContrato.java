/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.model.usuario;

import jakarta.xml.bind.annotation.XmlType;

/**
 *
 * @author sdelr
 */
@XmlType(namespace = "http://sisprog.com/model")
public enum TipoContrato {
    COMPLETO,PARCIAL
}
