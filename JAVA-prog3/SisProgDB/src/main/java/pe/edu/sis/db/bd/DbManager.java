
package pe.edu.sis.db.bd;

import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author seinc
 */
public class DbManager {
    private static DbManager dbmanager;
    private final String user;
    private final String password;
    private final String host;
    private final String tipo;
    private final String esquema;
    private final String url;
    private String ruta="db.properties";
    private Connection conn;
    private Properties datos;
    private DbManager(){
        datos=new Properties();
        try{
            InputStream input=getClass().getClassLoader().getResourceAsStream(ruta);
            datos.load(input);
        }catch(IOException e){
            System.out.println("Error al leer el archivo de datos " + e.getMessage());
        }
        this.user=datos.getProperty("user");
        this.password=datos.getProperty("password");
        this.host=datos.getProperty("hostname");
        this.tipo=datos.getProperty("tipoBD");
        this.esquema=datos.getProperty("database");
        this.url="jdbc:" + this.tipo + "://" + this.host + "/" + this.esquema;
    }
    public static DbManager getInstance(){
        if(dbmanager==null){
            dbmanager= new DbManager();
        }
        return dbmanager;
    }
    public Connection getConnection(){
        try{
            if(conn==null || conn.isClosed()){
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn=DriverManager.getConnection(url, user, password);
                System.out.println("Se ha establecido la conexion con la base de datos.");
            }   
        }catch(ClassNotFoundException | SQLException e){
            System.out.println("Error al conectarse a la base de datos " + e.getMessage());
        }
        return conn;
    }
    public void cerrarConexion(){
        try{
            conn.close();
        }catch(SQLException e){
            System.out.println("Error al cerrar la conexion: " + e.getMessage());
        }
    }
    
}
