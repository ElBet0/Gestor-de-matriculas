package pe.edu.sis.deuda.mysql;

import org.junit.jupiter.api.*;
import pe.edu.sis.alumno.mysql.AlumnoImpl;
import pe.edu.sis.alumno.mysql.FamiliaImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.Medio;
import pe.edu.sis.model.deuda.Pago;
import pe.edu.sis.model.deuda.TipoDeuda;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class PagoImplTest {
    PagoImpl dao;
    Pago pago;
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

        deuda.setDeuda_id(new DeudaImpl().insertar(deuda));

        pago = new Pago(10, new Date(2016,10,1), Medio.EFECTIVO, deuda);

        dao = new PagoImpl();
    }

    @Test
    @Order(1)
    void VerificarInsercionCorrecta() {
        pago.setPago_id(dao.insertar(pago));

        assertNotEquals(-1, pago.getPago_id());
    }

    @Test
    @Order(2)
    void VerificarRegistrosModificadosEsCorrecto() {
        pago.setObservaciones("Completo pago");

        assertEquals(1, dao.modificar(pago));
    }

    @Test
    @Order(5)
    void VerificarEliminarDevuelveCodigoPositivo() {
        assertTrue(dao.eliminar(pago.getPago_id()) >= 0);
    }

    @Test
    @Order(3)
    void VerificarQueObtenemosElMismoID() {
        Pago pago1 = dao.obtener_por_id(pago.getPago_id());

        assertNotNull(pago1);
        assertNotEquals(-1, pago1.getPago_id());
        assertEquals(pago.getPago_id(), pago1.getPago_id());
    }

    @Test
    @Order(4)
    void VerificarQueListaSiRetorneAlgo() {
        List<Pago> lista = dao.listarTodos();
        assertTrue(!lista.isEmpty());
    }

    @AfterAll
    void EliminarDatosCreado(){
        new FamiliaImpl().eliminar(papis.getFamilia_id());
        new AlumnoImpl().eliminar(alumno.getAlumno_id());
        new DeudaImpl().eliminar(deuda.getDeuda_id());
    }
}