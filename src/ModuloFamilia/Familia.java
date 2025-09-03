package ModuloFamilia;

import java.util.ArrayList;
import java.util.List;

/**
 * La clase Familia representa a una familia en el sistema.
 * Contiene información de contacto y una lista de los hijos que son alumnos.
 */
public class Familia {
    /**
     * El código único que identifica a la familia.
     */
    private int codigo_familia;
    /**
     * El apellido paterno de la familia.
     */
    private String apellido_paterno;
    /**
     * El apellido materno de la familia.
     */
    private String apellido_materno;
    /**
     * El número de teléfono de contacto de la familia.
     */
    private int numero_telefono;
    /**
     * El correo electrónico de contacto de la familia.
     */
    private String correo_electronico;
    /**
     * La dirección de la familia.
     */
    private String direccion;
    /**
     * La lista de hijos de la familia que son alumnos en la institución.
     */
    private List<Alumno> hijos = new ArrayList<>();
}
