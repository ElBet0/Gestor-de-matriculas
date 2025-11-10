//package pe.edu.sis.deuda.mysql;
//
//import java.util.Date;
//import java.util.List;
//
//import org.junit.jupiter.api.AfterAll;
//import static org.junit.jupiter.api.Assertions.assertEquals;
//import static org.junit.jupiter.api.Assertions.assertFalse;
//import static org.junit.jupiter.api.Assertions.assertNotEquals;
//import static org.junit.jupiter.api.Assertions.assertNotNull;
//import static org.junit.jupiter.api.Assertions.assertTrue;
//import org.junit.jupiter.api.BeforeAll;
//import org.junit.jupiter.api.MethodOrderer;
//import org.junit.jupiter.api.Order;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.TestInstance;
//import org.junit.jupiter.api.TestMethodOrder;
//
//import pe.edu.sis.alumno.mysql.AlumnoImpl;
//import pe.edu.sis.alumno.mysql.FamiliaImpl;
//import pe.edu.sis.deuda.dao.PagoDAO;
//import pe.edu.sis.model.alumno.Alumno;
//import pe.edu.sis.model.alumno.Familia;
//import pe.edu.sis.model.deuda.Deuda;
//import pe.edu.sis.model.deuda.MedioPago;
//import pe.edu.sis.model.deuda.Pago;
//import pe.edu.sis.model.deuda.TipoDeuda;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class PagoImplTest {
//    PagoDAO dao;
//    Pago pago;
//    Deuda deuda;
//    Familia papis;
//    Alumno alumno;
//    TipoDeuda tipo;
//
//    @BeforeAll
//    void CrearPago() {
//        System.out.println("\n------------ PagoImplTest ------------");
//
//        papis = new Familia("Del rio", "Laos", "987654321",
//                "a20230417@pucp.edu.pe", "Jr. Zepitas");
//
//        new FamiliaImpl().insertar(papis);
//
//        alumno = new Alumno("Marcelo", 0, new Date(2018, 2, 1), 'M',
//                papis, 0);
//
//        new AlumnoImpl().insertar(alumno);
//
//        tipo = new TipoDeuda("Matricula", 150.0);
//
//        new TipoDeudaImpl().insertar(tipo);
//
//        deuda = new Deuda(alumno, tipo, "Deuda de prueba para pago", 0.0, new Date(), new Date(), 100.0);
//
//        new DeudaImpl().insertar(deuda);
//
//        pago = new Pago(100, new Date(), MedioPago.DEPOSITO, "...", deuda);
//
//        dao = new PagoImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nPagoImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(pago));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nPagoImplTest: VerificarRegistrosModificadosEsCorrecto");
//        pago.setMonto(80.0);
//
//        assertEquals(1, dao.modificar(pago));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nPagoImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(pago.getPago_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nPagoImplTest: VerificarQueObtenemosElMismoID");
//        Pago pago2 = dao.obtener_por_id(pago.getPago_id());
//
//        assertNotNull(pago2);
//        assertNotEquals(-1, pago2.getPago_id());
//        assertEquals(pago.getPago_id(), pago2.getPago_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nPagoImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Pago> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//
//    @AfterAll
//    void EliminarDatos() {
//        new DeudaImpl().eliminar(deuda.getDeuda_id());
//        new AlumnoImpl().eliminar(alumno.getAlumno_id());
//        new FamiliaImpl().eliminar(papis.getFamilia_id());
//        new TipoDeudaImpl().eliminar(tipo.getId_tipo_deuda());
//    }
//}
