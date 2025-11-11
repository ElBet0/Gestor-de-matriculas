
package pe.edu.sis.db.bd;

import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Map;
import java.util.Properties;

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
    private String ruta = "db.properties";
    private Connection conn;
    private Properties datos;
    private ResultSet rs;

    /* CREACION DE LOS DATOS */
    private DbManager() {
        datos = new Properties();
        try {
            InputStream input = getClass().getClassLoader().getResourceAsStream(ruta);
            datos.load(input);
        } catch (IOException e) {
            System.out.println("Error al leer el archivo de datos " + e.getMessage());
        }
        this.user = datos.getProperty("user");
        this.password = datos.getProperty("password");
        this.host = datos.getProperty("hostname");
        this.tipo = datos.getProperty("tipoBD");
        this.esquema = datos.getProperty("database");
        this.url = "jdbc:" + this.tipo + "://" + this.host + "/" + this.esquema + "?useSSL=false";
    }

    public static DbManager getInstance() {
        if (dbmanager == null) {
            dbmanager = new DbManager();
        }
        return dbmanager;
    }

    public Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                System.out.println("Se ha establecido la conexion con la base de datos.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error al conectarse a la base de datos " + e.getMessage());
        }
        return conn;
    }

    public void cerrarConexion() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexion: " + e.getMessage());
        }
    }
    /* MANEJO DE LA BD */

    public int ejecutarProcedimiento(String nombreProcedimiento, Map<Integer, Object> parametrosEntrada,
            Map<Integer, Object> parametrosSalida) {
        int resultado = 0;
        try {
            CallableStatement cst = formarLlamadaProcedimiento(nombreProcedimiento, parametrosEntrada,
                    parametrosSalida);
            if (parametrosEntrada != null)
                registrarParametrosEntrada(cst, parametrosEntrada);
            if (parametrosSalida != null)
                registrarParametrosSalida(cst, parametrosSalida);

            resultado = cst.executeUpdate();

            if (parametrosSalida != null)
                obtenerValoresSalida(cst, parametrosSalida);
        } catch (SQLException ex) {
            System.out.println("Error ejecutando procedimiento almacenado: " + ex.getMessage());
            if(ex.getErrorCode() > 0) resultado = -ex.getErrorCode();
            else if(ex.getErrorCode() == 0) resultado = -1;
            else resultado = ex.getErrorCode();
            
        } catch (Exception e) {
            System.out.println("Error inesperado: " + e.getMessage());
            resultado = -1;
        } finally {
            cerrarConexion();
        }
        return resultado;
    }

    public ResultSet ejecutarProcedimientoLectura(String nombreProcedimiento, Map<Integer, Object> parametrosEntrada) {
        try {
            CallableStatement cs = formarLlamadaProcedimiento(nombreProcedimiento, parametrosEntrada, null);
            if (parametrosEntrada != null)
                registrarParametrosEntrada(cs, parametrosEntrada);
            rs = cs.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error ejecutando procedimiento almacenado de lectura: " + ex.getMessage());
        }
        return rs;
    }

    public CallableStatement formarLlamadaProcedimiento(String nombreProcedimiento,
            Map<Integer, Object> parametrosEntrada, Map<Integer, Object> parametrosSalida) throws SQLException {
        conn = getConnection();
        StringBuilder call = new StringBuilder("{call " + nombreProcedimiento + "(");
        int cantParametrosEntrada = 0;
        int cantParametrosSalida = 0;
        if (parametrosEntrada != null)
            cantParametrosEntrada = parametrosEntrada.size();
        if (parametrosSalida != null)
            cantParametrosSalida = parametrosSalida.size();
        int numParams = cantParametrosEntrada + cantParametrosSalida;
        for (int i = 0; i < numParams; i++) {
            call.append("?");
            if (i < numParams - 1) {
                call.append(",");
            }
        }
        call.append(")}");
        return conn.prepareCall(call.toString());
    }

    private void registrarParametrosEntrada(CallableStatement cs, Map<Integer, Object> parametros) throws SQLException {
        for (Map.Entry<Integer, Object> entry : parametros.entrySet()) {
            Integer key = entry.getKey();
            Object value = entry.getValue();
            switch (value) {
                case Integer entero -> cs.setInt(key, entero);
                case String cadena -> cs.setString(key, cadena);
                case Double decimal -> cs.setDouble(key, decimal);
                case Boolean booleano -> cs.setBoolean(key, booleano);
                case java.util.Date fecha -> cs.setDate(key, new java.sql.Date(fecha.getTime()));
                case Character caracter -> cs.setString(key, String.valueOf(caracter));
                case byte[] archivo -> cs.setBytes(key, archivo);
                default -> {
                }
            }
        }
    }

    private void registrarParametrosSalida(CallableStatement cst, Map<Integer, Object> params) throws SQLException {
        for (Map.Entry<Integer, Object> entry : params.entrySet()) {
            Integer posicion = entry.getKey();
            int sqlType = (int) entry.getValue();
            cst.registerOutParameter(posicion, sqlType);
        }
    }

    private void obtenerValoresSalida(CallableStatement cst, Map<Integer, Object> parametrosSalida)
            throws SQLException {
        for (Map.Entry<Integer, Object> entry : parametrosSalida.entrySet()) {
            Integer posicion = entry.getKey();
            int sqlType = (int) entry.getValue();
            Object value = null;
            switch (sqlType) {
                case Types.INTEGER -> value = cst.getInt(posicion);
                case Types.VARCHAR -> value = cst.getString(posicion);
                case Types.DOUBLE -> value = cst.getDouble(posicion);
                case Types.BOOLEAN -> value = cst.getBoolean(posicion);
                case Types.DATE -> value = cst.getDate(posicion);
                case Types.BLOB -> value = cst.getBytes(posicion);
            }
            parametrosSalida.put(posicion, value);
        }
    }
}
