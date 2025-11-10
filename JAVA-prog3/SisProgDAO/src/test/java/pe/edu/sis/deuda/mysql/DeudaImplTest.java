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
//import pe.edu.sis.deuda.dao.DeudaDAO;
//import pe.edu.sis.model.alumno.Alumno;
//import pe.edu.sis.model.alumno.Familia;
//import pe.edu.sis.model.deuda.Deuda;
//import pe.edu.sis.model.deuda.TipoDeuda;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class DeudaImplTest {
//    DeudaDAO dao;
//    Deuda deuda;
//    Familia papis;
//    Alumno alumno;
//    TipoDeuda tipo;
//
//    @BeforeAll
//    void CrearDeuda() {
//        System.out.println("\n------------ DeudaImplTest ------------");
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
//        deuda = new Deuda();
//        deuda.setMonto(100.0);
//        deuda.setDescripcion("Marcelito quiso conoces el amor y consiguió una deuda con una cariñosa");
//        deuda.setFecha_emision(new Date());
//        deuda.setFecha_vencimiento(new Date());
//        deuda.setDescuento(0.0);
//        deuda.setAlumno(alumno);
//        deuda.setConcepto_deuda(tipo);
//
//        dao = new DeudaImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nDeudaImplTest: VerificarInsercionCorrecta");
//        deuda.setDeuda_id(dao.insertar(deuda));
//
//        assertNotEquals(-1, deuda.getDeuda_id());
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nDeudaImplTest: VerificarRegistrosModificadosEsCorrecto");
//        deuda.setDescripcion("Marcelito al final le regateo y consiguió un descuento");
//        deuda.setDescuento(20.0);
//
//        assertEquals(1, dao.modificar(deuda));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nDeudaImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(deuda.getDeuda_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nDeudaImplTest: VerificarQueObtenemosElMismoID");
//        Deuda deuda2 = dao.obtener_por_id(deuda.getDeuda_id());
//
//        assertNotNull(deuda2);
//        assertNotEquals(-1, deuda2.getDeuda_id());
//        assertEquals(deuda.getDeuda_id(), deuda2.getDeuda_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nDeudaImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Deuda> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//
//    @AfterAll
//    void EliminarDatos() {
//        new AlumnoImpl().eliminar(alumno.getAlumno_id());
//        new FamiliaImpl().eliminar(papis.getFamilia_id());
//        new TipoDeudaImpl().eliminar(tipo.getId_tipo_deuda());
//    }
//}
