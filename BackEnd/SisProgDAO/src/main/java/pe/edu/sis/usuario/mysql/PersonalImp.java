package pe.edu.sis.usuario.mysql;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.model.usuario.Cargo;
import pe.edu.sis.model.usuario.Personal;
import pe.edu.sis.model.usuario.TipoContrato;
import pe.edu.sis.usuario.dao.PersonalDAO;

public class PersonalImp implements PersonalDAO {
    private ResultSet rs;

    @Override
    public int insertar(Personal personal) {
        Map<Integer, Object> in = new HashMap<>();
        Map<Integer, Object> out = new HashMap<>();
        out.put(1, Types.INTEGER);
        in.put(2, personal.getCargo().getCargo_id());
        in.put(3, personal.getNombre());
        in.put(4, personal.getApellido_paterno());
        in.put(5, personal.getApellido_materno());
        in.put(6, personal.getDni());
        in.put(7, personal.getCorreo_electronico());
        in.put(8, personal.getTelefono());
        in.put(9, personal.getSalario());
        in.put(10, new Date(personal.getFecha_Contratacion().getTime()));
        in.put(11, new Date(personal.getFin_fecha_Contratacion().getTime()));
        in.put(12, personal.getTipo_contrato().toString());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_PERSONAL", in, out);
        personal.setPersonal_id((int) out.get(1));
        System.out.println("Se ha realizado el registro del personal");
        return personal.getPersonal_id();
    }

    @Override
    public int modificar(Personal personal) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, personal.getPersonal_id());
        in.put(2, personal.getCargo().getCargo_id());
        in.put(3, personal.getNombre());
        in.put(4, personal.getApellido_paterno());
        in.put(5, personal.getApellido_materno());
        in.put(6, personal.getDni());
        in.put(7, personal.getCorreo_electronico());
        in.put(8, personal.getTelefono());
        in.put(9, personal.getSalario());
        in.put(10, new Date(personal.getFecha_Contratacion().getTime()));
        in.put(11, new Date(personal.getFin_fecha_Contratacion().getTime()));
        in.put(12, personal.getTipo_contrato().toString());
        int resultado = DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_PERSONAL", in, null);
        System.out.println("Se ha realizado la modificacion del personal");
        return resultado;
    }

    @Override
    public int eliminar(int idObjeto) {
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        int resultado = DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_PERSONAL", in, null);
        System.out.println("Se ha realizado la eliminacion del personal");
        return resultado;
    }

    @Override
    public Personal obtener_por_id(int idObjeto) {
        Personal personal = null;
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, idObjeto);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_PERSONAL_POR_ID", in);
        try {
            while (rs.next()) {
                personal = new Personal();
                personal.setPersonal_id(rs.getInt("ID_PERSONAL"));
                personal.setNombre(rs.getString("nombre"));
                personal.setApellido_paterno(rs.getString("apellido_paterno"));
                personal.setApellido_materno(rs.getString("apellido_materno"));
                personal.setDni(rs.getInt("dni"));
                personal.setCorreo_electronico(rs.getString("correo_electronico"));
                personal.setTelefono(rs.getString("telefono"));
                personal.setSalario(rs.getDouble("salario"));
                personal.setFecha_Contratacion(rs.getDate("fecha_contratacion"));
                personal.setFin_fecha_Contratacion(rs.getDate("fin_fecha_contrato"));
                personal.setTipo_contrato(TipoContrato.valueOf(rs.getString("tipo_contrato")));
                Cargo cargo = new Cargo();
                cargo.setCargo_id(rs.getInt("id_cargo"));
                cargo.setNombre(rs.getString("CARGO_DESCRIPCION"));
                personal.setCargo(cargo);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return personal;
    }

    @Override
    public ArrayList<Personal> listarTodos() {
        ArrayList<Personal> personales = new ArrayList<>();
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_PERSONAL", null);
        try {
            while (rs.next()) {
                Personal personal = new Personal();
                personal.setPersonal_id(rs.getInt("ID_PERSONAL"));
                personal.setNombre(rs.getString("nombre"));
                personal.setApellido_paterno(rs.getString("apellido_paterno"));
                personal.setApellido_materno(rs.getString("apellido_materno"));
                personal.setDni(rs.getInt("dni"));
                personal.setCorreo_electronico(rs.getString("correo_electronico"));
                personal.setTelefono(rs.getString("telefono"));
                personal.setSalario(rs.getDouble("salario"));
                personal.setFecha_Contratacion(rs.getDate("fecha_contratacion"));
                personal.setFin_fecha_Contratacion(rs.getDate("FIN_FECHA_CONTRATO"));
                personal.setTipo_contrato(TipoContrato.valueOf(rs.getString("tipo_contrato")));
                Cargo cargo = new Cargo();
                cargo.setCargo_id(rs.getInt("ID_CARGO"));
                cargo.setNombre(rs.getString("CARGO_DESCRIPCION"));
                personal.setCargo(cargo);

                personales.add(personal);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            DbManager.getInstance().cerrarConexion();
        }

        return personales;
    }
    
    @Override
    public ArrayList<Personal> buscarPersonal(int dni, String nombreApellidos) {
        
        Map<Integer, Object> in = new HashMap<>();
        in.put(1, dni);
        in.put(2, nombreApellidos);
        rs = DbManager.getInstance().ejecutarProcedimientoLectura("BUSCAR_PERSONAL_POR_DNI_O_NOMBRE_APELLIDOS", in);
        ArrayList<Personal> lista = new ArrayList<>();

        try {
            
            while ( rs.next()) {
                Personal p = new Personal();
                p.setPersonal_id(rs.getInt("ID_PERSONAL"));
                p.setNombre(rs.getString("NOMBRE"));
                p.setApellido_paterno(rs.getString("APELLIDO_PATERNO"));
                p.setApellido_materno(rs.getString("APELLIDO_MATERNO"));
                p.setDni(rs.getInt("DNI"));

                Cargo c = new Cargo();
                c.setNombre(rs.getString("NOMBRE_CARGO"));
                p.setCargo(c);

                p.setCorreo_electronico(rs.getString("CORREO_ELECTRONICO"));
                p.setTelefono(rs.getString("TELEFONO"));
                p.setSalario(rs.getDouble("SALARIO"));
                p.setFecha_Contratacion(rs.getDate("FECHA_CONTRATACION"));
                p.setFin_fecha_Contratacion(rs.getDate("FIN_FECHA_CONTRATO"));

                lista.add(p);
            }
        } catch (SQLException ex) {
            System.out.println("Error en BUSCAR_PERSONAL...: " + ex.getMessage());
        } catch (NullPointerException nul) {
            System.out.println("Error: rs devolvió null");
        } finally {
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }

    
    
}
