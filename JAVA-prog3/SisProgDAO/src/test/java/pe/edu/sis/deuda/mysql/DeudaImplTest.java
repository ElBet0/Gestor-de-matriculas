package pe.edu.sis.deuda.mysql;

import org.junit.jupiter.api.*;
import pe.edu.sis.alumno.mysql.AlumnoImpl;
import pe.edu.sis.alumno.mysql.FamiliaImpl;
import pe.edu.sis.deuda.dao.DeudaDAO;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.TipoDeuda;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class DeudaImplTest {
    DeudaDAO dao;
    Deuda deuda;
    Alumno alumno;
    Familia papis;

    @BeforeAll
    void CrearDeuda(){

        papis = new Familia("Del rio", "Laos", "987654321",
                "a20230417@pucp.edu.pe", "Jr. Zepitas");

        papis.setFamilia_id(new FamiliaImpl().insertar(papis));

        alumno = new Alumno("Marcelo", 0, new Date(2018, 2, 1), 'M',
                papis, 0);

        alumno.setAlumno_id(new AlumnoImpl().insertar(alumno));

        deuda = new Deuda(10, new Date(2015,1,1), new Date(2015,2,1), TipoDeuda.MULTA, alumno);

        dao = new DeudaImpl();
    }

    @Test
    @Order(1)
    void VerificarInsercionCorrecta() {
        deuda.setDeuda_id(dao.insertar(deuda));

        assertNotEquals(-1, deuda.getDeuda_id());
    }

    @Test
    @Order(2)
    void VerificarRegistrosModificadosEsCorrecto() {
        deuda.setDescripcion("Descripción generica así bien generica");

        assertEquals(1, dao.modificar(deuda));
    }

    @Test
    @Order(5)
    void VerificarEliminarDevuelveCodigoPositivo() {
        assertTrue(dao.eliminar(deuda.getDeuda_id()) >= 0);
    }

    @Test
    @Order(3)
    void VerificarQueObtenemosElMismoID() {
        Deuda deuda2 = dao.obtener_por_id(deuda.getDeuda_id());

        assertNotNull(deuda2);
        assertNotEquals(-1, deuda2.getDeuda_id());
        assertEquals(deuda.getDeuda_id(), deuda2.getDeuda_id());
    }

    @Test
    @Order(4)
    void VerificarQueListaSiRetorneAlgo() {
        List<Deuda> lista = dao.listarTodos();
        assertTrue(!lista.isEmpty());
    }

    @AfterAll
    void EliminarDatosCreado(){
        new FamiliaImpl().eliminar(papis.getFamilia_id());
        new AlumnoImpl().eliminar(alumno.getAlumno_id());
    }
}