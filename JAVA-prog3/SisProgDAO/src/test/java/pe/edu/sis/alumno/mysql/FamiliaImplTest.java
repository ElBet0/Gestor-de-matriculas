package pe.edu.sis.alumno.mysql;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import pe.edu.sis.alumno.dao.FamiliaDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class FamiliaImplTest {
    FamiliaDAO dao = new FamiliaImpl();
    Familia familia;

    @Test
    @Order(1)
    void insertar() {
        familia = new Familia("Del rio", "Laos", "987654321",
                "a20230417@pucp.edu.pe", "Jr. Zepitas");

        familia.setFamilia_id(new FamiliaImpl().insertar(familia));

        assertNotEquals(-1, familia.getFamilia_id());
    }

    @Test
    @Order(2)
    void modificar() {
        familia.setNumero_telefono("123456789");

        assertEquals(1, dao.modificar(familia));
    }

    @Test
    @Order(5)
    void eliminar() {
        assertTrue(dao.eliminar(familia.getFamilia_id()) > 0);
        new FamiliaImpl().eliminar(familia.getFamilia_id());
    }

    @Test
    @Order(3)
    void obtener_por_id() {
        Familia familia2 = dao.obtener_por_id(familia.getFamilia_id());

        assertNotEquals(null, familia2);
    }

    @Test
    @Order(4)
    void listarTodos() {
        List<Familia> lista = dao.listarTodos();
        assertFalse(lista.isEmpty());
    }
}