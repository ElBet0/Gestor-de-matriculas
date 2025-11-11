package pe.edu.sis.usuario.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.usuario.Personal;

public interface PersonalDAO extends IDAO<Personal> {
    public ArrayList<Personal> buscarPersonal(int dni, String nombreApellidos);
}
