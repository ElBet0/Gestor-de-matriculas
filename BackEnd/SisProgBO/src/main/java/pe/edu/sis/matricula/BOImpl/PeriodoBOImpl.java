/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.matricula.BO.PeriodoBO;
import pe.edu.sis.matricula.dao.PeriodoDAO;
import pe.edu.sis.matricula.mysql.PeriodoImpl;
import pe.edu.sis.model.matricula.PeriodoAcademico;

/**
 *
 * @author sdelr
 */

//   COMO QUE IMPLEMENTA IBASEBOOO IMPLEMENTA PERIODOBO CARAJOOOOOOOOOOOOOOOOO
public class PeriodoBOImpl implements PeriodoBO {
    PeriodoDAO per;

    public PeriodoBOImpl() {
        per=new PeriodoImpl();
    }
    
    @Override
    public int insertar(PeriodoAcademico objeto) throws Exception {
        validar(objeto);
        objeto.setPeriodo_academico_id(per.insertar(objeto));
        return objeto.getPeriodo_academico_id();
    }

    @Override
    public int modificar(PeriodoAcademico objeto) throws Exception {
        validar(objeto);
        return per.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return per.eliminar(Idobjeto);
    }

    @Override
    public PeriodoAcademico obtenerPorId(int Idobjeto) throws Exception {
        PeriodoAcademico p;
        p= per.obtener_por_id(Idobjeto);
        return p;
    }

    @Override
    public ArrayList<PeriodoAcademico> listarTodos() throws Exception {
        ArrayList<PeriodoAcademico> p;
        p = per.listarTodos();
        return p;
    }

    @Override
    public void validar(PeriodoAcademico objeto) throws Exception {
        if(objeto.getDescripcion().length()>100){
            throw new Exception("la longitud de la descripcion no es valida");
        }
        if(!objeto.getFecha_inicio().before(objeto.getFecha_fin())){
            throw new Exception("el orden de las fechas del periodo no es correcto");
        }
        if(objeto.getNombre().length()>45){
            throw new Exception("la longitud del nombre no es valido");
        }
    }
    
    
}
