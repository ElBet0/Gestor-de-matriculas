package pe.edu.sis.gracademico.dao;

import java.util.ArrayList;
import pe.edu.sis.dao.IDAO;
import pe.edu.sis.model.grAcademico.Aula;

public interface AulaDAO extends IDAO<Aula> {
    public ArrayList<Aula> buscarAulaPorNombreONombreGrado(String nombreAula, String nombreGrado);
}
