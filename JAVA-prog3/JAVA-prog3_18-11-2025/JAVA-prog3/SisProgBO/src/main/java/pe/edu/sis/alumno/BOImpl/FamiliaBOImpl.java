/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.alumno.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.alumno.BO.FamiliaBO;
import pe.edu.sis.alumno.dao.FamiliaDAO;
import pe.edu.sis.alumno.mysql.FamiliaImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

/**
 *
 * @author sdelr
 */
public class FamiliaBOImpl implements FamiliaBO{
    FamiliaDAO fam;
    

    public FamiliaBOImpl() {
        fam=new FamiliaImpl();
    }

    
    @Override
    public int insertar(Familia objeto) throws Exception {
        validar(objeto);
        objeto.setFamilia_id(fam.insertar(objeto));
        return objeto.getFamilia_id();
    }
    
    @Override
    public int modificar(Familia objeto) throws Exception {
        validar(objeto);
        return fam.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return fam.eliminar(Idobjeto);
    }

    @Override
    public Familia obtenerPorId(int Idobjeto) throws Exception {
        Familia familia;
        familia=fam.obtener_por_id(Idobjeto);
        return familia;
    }

    @Override
    public ArrayList<Familia> listarTodos() throws Exception {
        ArrayList<Familia> familias;
        familias = fam.listarTodos();
        return familias;
    }

    @Override
    public void validar(Familia objeto) throws Exception {
        if (objeto.getApellido_paterno().length()>45){
            throw new Exception("La longitud del apellido paterno no es valido");
        }
        if (objeto.getApellido_materno().length()>45){
            throw new Exception("La longitud del apellido materno no es valido");
        }
        if (objeto.getNumero_telefono().length()>12){
            throw new Exception("La longitud del numero de telefono no es valida");
        }
        if (objeto.getCorreo_electronico().length()>45){
            throw new Exception("La longitud del correo electronico no es valida");
        }
        if(objeto.getDireccion().length()>100){
            throw new Exception("la longitud de la direccion no es valida");
        }
    }
    @Override
    public ArrayList<Familia> buscarFamilia(String ape_pat,String ape_mat){
        
        ArrayList<Familia> f;
        f = fam.BuscarFamilia(ape_pat, ape_mat);
        return f;
        
    }
    
    @Override
    public ArrayList<Alumno>ObtenerHijos(int fam_id){
        
        ArrayList <Alumno>al;
        al = fam.ObtenerHijos(fam_id);
        return al;
    }
    
}
