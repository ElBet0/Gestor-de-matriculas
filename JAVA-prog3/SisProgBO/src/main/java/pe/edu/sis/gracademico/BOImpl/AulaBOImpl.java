/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gracademico.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.gracademico.BO.AulaBO;
import pe.edu.sis.gracademico.dao.AulaDAO;
import pe.edu.sis.gracademico.mysql.AulaImpl;
import pe.edu.sis.model.grAcademico.Aula;

/**
 *
 * @author sdelr
 */
public class AulaBOImpl implements AulaBO{
    AulaDAO aula;

    public AulaBOImpl() {
        aula= new AulaImpl();
    }
    
    
    @Override
    public int insertar(Aula objeto) throws Exception {
        validar(objeto);
        objeto.setAula_id(aula.insertar(objeto));
        return objeto.getAula_id();
    }

    @Override
    public int modificar(Aula objeto) throws Exception {
        validar(objeto);
        return aula.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return aula.eliminar(Idobjeto);
    }

    @Override
    public Aula obtenerPorId(int Idobjeto) throws Exception {
        Aula a;
        a=aula.obtener_por_id(Idobjeto);
        return a;
    }

    @Override
    public ArrayList<Aula> listarTodos() throws Exception {
        ArrayList<Aula> a;
        a=aula.listarTodos();
        return a;
    }

    @Override
    public void validar(Aula objeto) throws Exception {
        if(objeto.getGrado().getGrado_academico_id()<0){
            throw new Exception("El grado asignado al aula no es valido");
        }
        if(objeto.getNombre().length()>45){
            throw new Exception("la longitud del nombre para el aula no es valido");
        }
    }
    
    @Override
    public ArrayList<Aula> buscarNombre(String nombre,String nombre_grado){
        ArrayList<Aula> aulas;
        aulas=aula.buscarAulaPorNombreONombreGrado(nombre, nombre_grado);
        return aulas;
    }
    
}
