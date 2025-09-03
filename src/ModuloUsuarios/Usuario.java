package ModuloUsuarios;

/**
 * La clase abstracta Usuario representa a un usuario genérico del sistema.
 * Contiene los atributos comunes a todos los tipos de usuarios.
 */
public abstract class Usuario {
    /**
     * El código único que identifica al usuario.
     */
    private int codigo_usuario;
    /**
     * La contraseña del usuario almacenada como un hash.
     */
    private String claveHash;
    /**
     * El salt utilizado para generar el hash de la contraseña.
     */
    private String salt;
    /**
     * El nombre del usuario.
     */
    private String nombre;
    /**
     * El apellido paterno del usuario.
     */
    private String apellido_paterno;
    /**
     * El apellido materno del usuario.
     */
    private String apellido_materno;
    /**
     * El nivel de seguridad del usuario, que determina sus permisos en el sistema.
     */
    private int nivel_seguridad;
    /**
     * La dirección de correo electrónico del usuario.
     */
    private String email;
}
