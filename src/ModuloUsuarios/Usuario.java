package ModuloUsuarios;

public abstract class Usuario {
    private int codigo_usuario;
    private String claveHash;
    private String salt;
    private String nombre;
    private String apellido_paterno;
    private String apellido_materno;
    private int nivel_seguridad;
    private String email;
}

