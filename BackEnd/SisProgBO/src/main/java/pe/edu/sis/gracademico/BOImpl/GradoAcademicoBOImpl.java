/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.gracademico.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.gracademico.BO.GradoAcademicoBO;
import pe.edu.sis.gracademico.dao.GradoDAO;
import pe.edu.sis.gracademico.mysql.GradoImpl;
import pe.edu.sis.model.grAcademico.Aula;
import pe.edu.sis.model.grAcademico.GradoAcademico;

/**
 *
 * @author sdelr
 */
public class GradoAcademicoBOImpl implements GradoAcademicoBO{
    GradoDAO grado;

    public GradoAcademicoBOImpl() {
        grado=new GradoImpl();
        
    }
    
    
    @Override
    public int insertar(GradoAcademico objeto) throws Exception {
        validar (objeto);
        objeto.setGrado_academico_id(grado.insertar(objeto));
        return objeto.getGrado_academico_id();
        
    }

    @Override
    public int modificar(GradoAcademico objeto) throws Exception {
        validar(objeto);
        return grado.modificar(objeto);    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return grado.eliminar(Idobjeto);
    }

    @Override
    public GradoAcademico obtenerPorId(int Idobjeto) throws Exception {
        GradoAcademico g;
        g=grado.obtener_por_id(Idobjeto);
        return g;
    }

    @Override
    public ArrayList<GradoAcademico> listarTodos() throws Exception {
        ArrayList<GradoAcademico> g;
        g=grado.listarTodos();
        return g;
    }

    @Override
    public void validar(GradoAcademico objeto) throws Exception {
        if(!objeto.getAbreviatura().isEmpty() &&objeto.getAbreviatura().length()>10){
            throw new Exception("la longitud de la abreviatura no es valida");
        }
        if(objeto.getNombre().length()> 45){
            throw new Exception("la longitud del nombre no es valida");
        }
    }
    
    @Override
    public GradoAcademico buscarGrado(String abre,String nombre){
        GradoAcademico g;
        
        g=grado.buscarPorNombreOAbreviatura(abre, nombre);
        return g;
    }
    
    @Override
    public ArrayList<Aula> obtenerAulas(int id){
        ArrayList<Aula> aulas;
        aulas=grado.listarAulasPorGrado(id);
        return aulas;
    }
}
