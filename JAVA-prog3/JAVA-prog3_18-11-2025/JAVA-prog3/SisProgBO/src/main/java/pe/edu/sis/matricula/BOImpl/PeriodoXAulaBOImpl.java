/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.sis.matricula.BOImpl;

import java.util.ArrayList;
import pe.edu.sis.matricula.BO.PeriodoXAulaBO;
import pe.edu.sis.matricula.dao.PeriodoXAulaDAO;
import pe.edu.sis.matricula.mysql.PeriodoXAulaImpl;
import pe.edu.sis.model.matricula.PeriodoXAula;

/**
 *
 * @author sdelr
 */
public class PeriodoXAulaBOImpl implements PeriodoXAulaBO{
    PeriodoXAulaDAO p;

    public PeriodoXAulaBOImpl() {
        p=new PeriodoXAulaImpl();
    }
    
    @Override
    public int insertar(PeriodoXAula objeto) throws Exception {
        validar(objeto);
        objeto.setPeriodo_aula_id(p.insertar(objeto));
        return objeto.getPeriodo_aula_id();
    }

    @Override
    public int modificar(PeriodoXAula objeto) throws Exception {
        validar(objeto);
        return p.modificar(objeto);
    }

    @Override
    public int eliminar(int Idobjeto) throws Exception {
        return p.eliminar(Idobjeto);
    }

    @Override
    public PeriodoXAula obtenerPorId(int Idobjeto) throws Exception {
        PeriodoXAula per;
        per=p.obtener_por_id(Idobjeto);
        return per;
    }

    @Override
    public ArrayList<PeriodoXAula> listarTodos() throws Exception {
        ArrayList<PeriodoXAula> periodos;
        periodos=p.listarTodos();
        return periodos;
    }

    @Override
    public void validar(PeriodoXAula objeto) throws Exception {
        
        if(objeto.getAula().getAula_id()<0){
            throw new Exception("el aula asignada al periodo_aula no es valido");
        }
        if(objeto.getPeriodo().getPeriodo_academico_id()<0){
            throw new Exception("el periodo asignado al periodo_aula no es valido");
        }
        if(objeto.getVacantes_disponibles()<0){
            throw new Exception("las vacantes disponibles no son validas");
        }
        if(objeto.getVacantes_ocupadas()>objeto.getVacantes_disponibles()){
            throw new Exception("las vacantes ocupadas no pueden ser mayor a las disponibles");
        }
        
    }
    
}
