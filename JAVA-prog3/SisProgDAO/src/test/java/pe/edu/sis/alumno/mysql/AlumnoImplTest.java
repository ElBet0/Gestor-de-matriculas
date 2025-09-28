package pe.edu.sis.alumno.mysql;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import pe.edu.sis.alumno.dao.AlumnoDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Date;
import java.util.List;

class AlumnoImplTest {

    Alumno alumno;
    AlumnoDAO alumnoDAO = new AlumnoImpl();
    Familia papis;
    @Test
    @Order(1)
    void insertar() {
        papis = new Familia("Del rio", "Laos", "987654321",
                "a20230417@pucp.edu.pe", "Jr. Zepitas");

        papis.setFamilia_id(new FamiliaImpl().insertar(papis));

        alumno = new Alumno("Marcelo", 12345678, new Date(2018, 2, 1), 'M',
                new Familia(1), 0);

        alumno.setAlumno_id(alumnoDAO.insertar(alumno));

        assertNotEquals(-1, alumno.getAlumno_id());
    }

    @Test
    @Order(2)
    void modificar() {
        alumno.setReligion("Ateo");
        alumno.setObservaciones("No llegara al fin de año");
        alumno.setFecha_nacimiento(new Date(2010, 10, 9));

        assertEquals(1, alumnoDAO.modificar(alumno));
    }

    @Test
    @Order(5)
    void eliminar() {
        new FamiliaImpl().eliminar(papis.getFamilia_id());
        assertTrue(alumnoDAO.eliminar(alumno.getAlumno_id()) > 0);
    }

    @Test
    @Order(3)
    void obtener_por_id() {
        Alumno alumno2 = alumnoDAO.obtener_por_id(alumno.getAlumno_id());

        assertNotNull(alumno2);
    }

    @Test
    @Order(4)
    void listarTodos() {
        List<Alumno> lista = alumnoDAO.listarTodos();
        assertFalse(lista.isEmpty());
    }
}