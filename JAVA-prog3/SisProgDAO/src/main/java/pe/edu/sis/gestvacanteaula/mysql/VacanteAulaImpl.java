/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gestvacanteaula.mysql;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import pe.edu.sis.db.bd.DbManager;
import pe.edu.sis.gestvacanteaula.dao.VacanteAulaDAO;
import pe.edu.sis.model.matricula.VacantesAula;

/**
 *
 * @author seinc
 */
public class VacanteAulaImpl implements VacanteAulaDAO {
   private ResultSet rs; 
    @Override
    public int insertar(VacantesAula vac) {
        Map<Integer, Object> in= new HashMap<>();
        Map<Integer, Object> out= new HashMap<>();
        out.put(1,Types.INTEGER);
        in.put(2,vac.getNombre());
        in.put(3,vac.getVacantes_disponibles());
        in.put(4,vac.getVacantes_ocupadas());
        DbManager.getInstance().ejecutarProcedimiento("INSERTAR_VACANTES_AULA",in,out);
        vac.setAula_id((int)out.get(1));
        System.out.println("Se ha realizado el registro de las Vacantes en el Aula ");
        return vac.getAula_id();
    }

    @Override
    public int modificar(VacantesAula vac) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,vac.getAula_id());
        in.put(2,vac.getNombre());
        in.put(3,vac.getVacantes_disponibles());
        in.put(4,vac.getVacantes_ocupadas());
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_VACANTES_AULA",in,null);
        System.out.println("Se ha realizado la modificacion de las Vacantes en el Aula ");
        return resultado;
    }

    @Override
    public int eliminar(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        int resultado=DbManager.getInstance().ejecutarProcedimiento("MODIFICAR_VACANTES_AULA",in,null);
        System.out.println("Se ha realizado la modificacion de las Vacantes en el Aula ");
        return resultado;
    }

    @Override
    public VacantesAula obtener_por_id(int pos) {
        Map<Integer, Object> in= new HashMap<>();
        in.put(1,pos);
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("OBTENER_AULA_POR_ID",in);
        VacantesAula vac=new VacantesAula();
        try{
            while(rs.next()){
                vac.setAula_id(rs.getInt("aula_id"));
                vac.setNombre(rs.getString("nombre"));
                vac.setVacantes_disponibles(rs.getInt("vacantes_disponibles"));
                vac.setVacantes_ocupadas(rs.getInt("vacantes_ocupadas"));
                vac.setEstado(rs.getInt("estado"));
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        return vac;
    }

    @Override
    public ArrayList<VacantesAula> listarTodos() {
        rs=DbManager.getInstance().ejecutarProcedimientoLectura("LISTAR_AULAS",null);
        ArrayList<VacantesAula> lista=new ArrayList<>();
        try{
            while(rs.next()){
                VacantesAula vac=new VacantesAula();
                vac.setAula_id(rs.getInt("aula_id"));
                vac.setNombre(rs.getString("nombre"));
                vac.setVacantes_disponibles(rs.getInt("vacantes_disponibles"));
                vac.setVacantes_ocupadas(rs.getInt("vacantes_ocupadas"));
                vac.setEstado(rs.getInt("estado"));
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
