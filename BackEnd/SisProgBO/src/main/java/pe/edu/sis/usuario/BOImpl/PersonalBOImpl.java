/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.usuario.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.model.usuario.Personal;
import pe.edu.sis.usuario.BO.PersonalBO;
import pe.edu.sis.usuario.dao.PersonalDAO;
import pe.edu.sis.usuario.mysql.PersonalImp;

/**
 *
 * @author sdelr
 */
public class PersonalBOImpl implements PersonalBO{
    PersonalDAO personal;
    public PersonalBOImpl(){
        personal=new PersonalImp();
    }

    @Override
    public int insertar(Personal objeto) throws Exception {
        validar(objeto);
        objeto.setPersonal_id(personal.insertar(objeto));
        return objeto.getPersonal_id();    }

    @Override
    public int modificar(Personal objeto) throws Exception {
        validar(objeto);
        return personal.modificar(objeto);   
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return personal.eliminar(Idobjeto);
    }

    @Override
    public Personal obtenerPorId(int Idobjeto) throws Exception {
        Personal p;
        p= personal.obtener_por_id(Idobjeto);
        return p;
    }

    @Override
    public ArrayList<Personal> listarTodos() throws Exception {
        ArrayList<Personal> p;
        p= personal.listarTodos();
        return p;
    }

    @Override
    public void validar(Personal objeto) throws Exception {
        if(objeto.getApellido_materno().length()>45){
            throw new Exception("la longitud del ape mat no es valido");
        }
        if(objeto.getApellido_paterno().length()>45){
            throw new Exception("la longitud del ape pat no es valido");
        
        }
        if(objeto.getNombre().length()>45){
            throw new Exception("la longitud del nombre no es valido");
        }
        if(objeto.getCargo().getCargo_id()<0){
            throw new Exception("el cargo asignado al personal no es valido");
        }
        if(objeto.getDni()<= 10000000 || objeto.getDni() >= 99999999){
            throw new Exception ("El dni ingresado no es valido");
        }
        if (objeto.getTelefono().length()>12){
            throw new Exception("La longitud del numero de telefono no es valida");
        }
        if(!objeto.getFecha_Contratacion().before(objeto.getFin_fecha_Contratacion())){
            throw new Exception("el orden de las fechas no es valido");
        }
        if(objeto.getSalario()<1130){
            throw new Exception("El salario es muy bajo");
        }
        if (objeto.getCorreo_electronico().length()>45){
            throw new Exception("La longitud del correo electronico no es valida");
        }
        
    }
    @Override
    public ArrayList<Personal> buscarDniNombre(int dni,String nombre){
        ArrayList<Personal> pe;
        pe=personal.buscarPersonal(dni, nombre);
        return pe;
    }
    
}
