/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.mysql;

import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.matricula.dao.VacanteAulaDAO;
import pe.edu.sis.model.grAcademico.Aula;

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
public class VacanteAulaImpl implements VacanteAulaDAO {
   private ResultSet rs; 
    @Override
    public int insertar(Aula vac) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,vac.getNombre());
//        in.put(3,vac.getVacantes_disponibles());
//        in.put(4,vac.getVacantes_ocupadas());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_VACANTES_AULA",in,out);
        vac.setAula_id((int)out.get(1));
        System.out.println("Se ha realizado el registro de las Vacantes en el Aula ");
        return vac.getAula_id();
    }

    @Override
    public int modificar(Aula vac) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,vac.getAula_id());
        in.put(2,vac.getNombre());
//        in.put(3,vac.getVacantes_disponibles());
//        in.put(4,vac.getVacantes_ocupadas());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_VACANTES_AULA",in,null);
        System.out.println("Se ha realizado la modificacion de las Vacantes en el Aula ");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("ELIMINAR_VACANTES_AULA",in,null);
        System.out.println("Se ha realizado la eliminación de las Vacantes en el Aula ");
        return resultado;
    }

    @Override
    public Aula obtener_por_id(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_AULA_POR_ID",in);
        Aula vac=new Aula();
        try{
            while(rs.next()){
                vac.setAula_id(rs.getInt("aula_id"));
                vac.setNombre(rs.getString("nombre"));
//                vac.setVacantes_disponibles(rs.getInt("vacantes_disponibles"));
//                vac.setVacantes_ocupadas(rs.getInt("vacantes_ocupadas"));
//                vac.setActivo(rs.getInt("estado"));
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        return vac;
    }

    @Override
    public ArrayList<Aula> listarTodos() {
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_AULAS",null);
        ArrayList<Aula> lista=new ArrayList<>();
        try{
            while(rs.next()){
                Aula vac=new Aula();
                vac.setAula_id(rs.getInt("aula_id"));
                vac.setNombre(rs.getString("nombre"));
//                vac.setVacantes_disponibles(rs.getInt("vacantes_disponibles"));
//                vac.setVacantes_ocupadas(rs.getInt("vacantes_ocupadas"));
//                vac.setActivo(rs.getInt("estado"));
                lista.add(vac);
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        return lista;
    }
    
}
