/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.alumno.BO.alumnoBO;
import pe.edu.sis.alumno.dao.AlumnoDAO;
import pe.edu.sis.alumno.mysql.AlumnoImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.matricula.Matricula;

/**
 *
 * @author sdelr
 */
public class alumnoBOImpl implements alumnoBO{
    private AlumnoDAO al;
    public alumnoBOImpl(){
        al=new AlumnoImpl();
    }
    @Override
    public int insertar(Alumno objeto) throws Exception {
        validar(objeto);
        objeto.setAlumno_id(al.insertar(objeto));
        return objeto.getAlumno_id();
    }

    @Override
    public int modificar(Alumno objeto) throws Exception {
        validar(objeto);
        return al.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return al.eliminar(Idobjeto);
    }

    @Override
    public Alumno obtenerPorId(int Idobjeto) throws Exception {
        Alumno alumno;
        alumno = al.obtener_por_id(Idobjeto);
        return alumno;
    }

    @Override
    public ArrayList<Alumno> listarTodos() throws Exception {
        ArrayList<Alumno> alumnos;
        alumnos=al.listarTodos();
        
        return alumnos;
    }

    @Override
    public void validar(Alumno objeto) throws Exception {
        if(objeto.getNombre().isEmpty()){
            throw new Exception("El nombre esta vacio");
        }
        if (objeto.getNombre().length()>45){
            throw new Exception ("El nombre tiene una cantidad de caracteres mayor a la permitida");
        }
        if(objeto.getDni()<= 10000000 || objeto.getDni() >= 99999999){
            throw new Exception ("El dni ingresado no es valido");
        }
        if (objeto.getFecha_ingreso()==null || objeto.getFecha_nacimiento()==null){
            throw new Exception ("Error en el registro de fecha");
        }
        if (objeto.getSexo()!='F' && objeto.getSexo()!='M'){
            throw new Exception ("El sexo ingresado no es valido");
        }
        if (objeto.getPadres().getFamilia_id()<0){
            throw new Exception ("El alumno no tiene una familia valida registrada");
        }
        if(objeto.getReligion()!=null && objeto.getReligion().length()>45){
            throw new Exception ("la religion ingresada no es valida");
        }
        if (objeto.getPension_base()<100){
            throw new Exception ("la pension ingresada no es valida");
        }
        if(objeto.getObservaciones()!=null && objeto.getObservaciones().length()>120){
            throw new Exception ("error en las observaciones del alumno");
        }
    }
    @Override
    public ArrayList<Alumno> buscar(int fam_id,String ape_pat,String apemat,String nombre,int dni){
        ArrayList<Alumno> alumno;
        
        alumno = al.BuscarAlumno(fam_id, ape_pat, apemat, nombre, dni);
        return alumno;
        
    }
    
    @Override 
    public ArrayList<Matricula> consultarMatriculas(int alumno_id){
        
        ArrayList<Matricula> mat;
        mat=al.ConsultarMatriculas(alumno_id);
        return mat;
        
    }
    
    
}
