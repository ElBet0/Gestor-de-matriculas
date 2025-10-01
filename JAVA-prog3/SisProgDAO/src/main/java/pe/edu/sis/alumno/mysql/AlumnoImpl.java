/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.mysql;

import pe.edu.sis.alumno.dao.AlumnoDAO;
import pe.edu.sis.alumno.dao.FamiliaDAO;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


/**
 *
 * @author seinc
 */
public class AlumnoImpl implements AlumnoDAO {
    private ResultSet rs;

    @Override
    public int insertar(Alumno al) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,al.getDni());
        in.put(3,al.getNombre());
        in.put(4,new Date(al.getFecha_nacimiento().getTime()));
        in.put(5,new Date(al.getFecha_ingreso().getTime()));
        in.put(6,al.getSexo());
        in.put(7,al.getReligion());
        in.put(8,al.getObservaciones());
        in.put(9,al.getPension_base());
        in.put(10,al.getPadres().getFamilia_id());
        if(DbManager.getInstance().ejecutarProcedimiento("INSERTAR_ALUMNO",in,out) < 0) return -1;
        al.setAlumno_id((int)out.get(1));
        System.out.println("Se ha realizado el registro del alumno");
        return al.getAlumno_id();
    }
    @Override
    public int modificar(Alumno al) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,al.getAlumno_id());
        in.put(2,al.getDni());
        in.put(3,al.getNombre());
        in.put(4,new Date(al.getFecha_nacimiento().getTime()));
        in.put(5,new Date(al.getFecha_ingreso().getTime()));
        in.put(6,al.getSexo());
        in.put(7,al.getReligion());
        in.put(8,al.getObservaciones());
        in.put(9,al.getPension_base());
        in.put(10,al.getPadres().getFamilia_id());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_ALUMNO",in,null);
        System.out.println("Se ha realizado la modificacion del alumno");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_ALUMNO", in, null);
        System.out.println("Se ha realizado la eliminacion del alumno");
        return resultado;
    }

    @Override
    public Alumno obtener_por_id(int pos) {
        Alumno al = null;
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_ALUMNO_POR_ID", in);
        FamiliaDAO fam = new FamiliaImpl();
        int fam_id=0;
        try{
            if(rs != null && rs.next()){
                al = new Alumno();
                al.setAlumno_id(rs.getInt("alumno_id"));
                al.setDni(rs.getInt("dni"));
                al.setFecha_ingreso(rs.getDate("fecha_ingreso"));
                al.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                al.setNombre(rs.getString("nombre"));
                al.setObservaciones(rs.getString("observaciones"));
                fam_id=rs.getInt("familia_id");
                al.setPension_base(rs.getDouble("pension_base"));
                al.setReligion(rs.getString("religion"));
                al.setSexo(rs.getString("sexo").charAt(0));
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        if(al == null) return null;

        al.setPadres(fam.obtener_por_id(fam_id));
        return al;
    }

    @Override
    public ArrayList<Alumno> listarTodos() {
        ArrayList<Alumno> alumno= new ArrayList<>();
        Map<Integer, Object> in= new HashMap<>();
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_ALUMNOS", in);
        FamiliaDAO fam = new FamiliaImpl();
        ArrayList<Integer> ids=new ArrayList<>();
        try{
            while(rs != null && rs.next()){
                Alumno al=new Alumno();
                al.setAlumno_id(rs.getInt("alumno_id"));
                al.setDni(rs.getInt("dni"));
                al.setFecha_ingreso(rs.getDate("fecha_ingreso"));
                al.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                al.setNombre(rs.getString("nombre"));
                al.setObservaciones(rs.getString("observaciones"));
                ids.add(rs.getInt("familia_id"));
                al.setPension_base(rs.getDouble("pension_base"));
                al.setReligion(rs.getString("religion"));
                al.setSexo(rs.getString("sexo").charAt(0));
                alumno.add(al);
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        Familia fami;
        for(int i=0;i<ids.size();i++){
            fami = fam.obtener_por_id((int)ids.get(i));
            alumno.get(i).setPadres(fami);
        }
        return alumno;
    }
}
