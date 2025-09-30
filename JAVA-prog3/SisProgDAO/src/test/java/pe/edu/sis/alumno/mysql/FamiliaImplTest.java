package pe.edu.sis.alumno.mysql;

import org.junit.jupiter.api.*;
import pe.edu.sis.alumno.dao.FamiliaDAO;
import pe.edu.sis.model.alumno.Familia;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class FamiliaImplTest {
    FamiliaDAO dao;
    Familia familia;

    @BeforeAll
    void CrearFamilia(){
        familia = new Familia("Del rio", "Laos", "987654321",
                "a20230417@pucp.edu.pe", "Jr. Zepitas");

        dao = new FamiliaImpl();
    }

    @Test
    @Order(1)
    void VerificarInsercionCorrecta() {
        familia.setFamilia_id(dao.insertar(familia));

        assertNotEquals(-1, familia.getFamilia_id());
    }

    @Test
    @Order(2)
    void VerificarRegistrosModificadosEsCorrecto() {
        familia.setNumero_telefono("123456789");

        assertEquals(1, dao.modificar(familia));
    }

    @Test
    @Order(5)
    void VerificarEliminarDevuelveCodigoPositivo() {
        assertTrue(dao.eliminar(familia.getFamilia_id()) >= 0);
    }

    @Test
    @Order(3)
    void VerificarQueObtenemosElMismoID() {
        Familia familia2 = dao.obtener_por_id(familia.getFamilia_id());

        assertNotNull(familia2);
        assertNotEquals(-1, familia2.getFamilia_id());
        assertEquals(familia.getFamilia_id(), familia2.getFamilia_id());
    }

    @Test
    @Order(4)
    void VerificarQueListaSiRetorneAlgo() {
        List<Familia> lista = dao.listarTodos();
        assertFalse(lista.isEmpty());
    }
}