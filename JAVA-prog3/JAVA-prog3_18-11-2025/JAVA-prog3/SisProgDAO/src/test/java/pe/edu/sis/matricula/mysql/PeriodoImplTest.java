//package pe.edu.sis.matricula.mysql;
//
//import java.util.Date;
//import java.util.List;
//
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
//import pe.edu.sis.matricula.dao.PeriodoDAO;
//import pe.edu.sis.model.matricula.PeriodoAcademico;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class PeriodoImplTest {
//    PeriodoDAO dao;
//    PeriodoAcademico periodo;
//
//    @BeforeAll
//    void CrearPeriodo() {
//        System.out.println("\n------------ PeriodoImplTest ------------");
//
//        periodo = new PeriodoAcademico("2025-patito", "Periodo Academico de prueba", new Date(), new Date());
//
//        dao = new PeriodoImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nPeriodoImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(periodo));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nPeriodoImplTest: VerificarRegistrosModificadosEsCorrecto");
//        periodo.setDescripcion("Nueva descripcion de prueba");
//
//        assertEquals(1, dao.modificar(periodo));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nPeriodoImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(periodo.getPeriodo_academico_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nPeriodoImplTest: VerificarQueObtenemosElMismoID");
//        PeriodoAcademico periodo2 = dao.obtener_por_id(periodo.getPeriodo_academico_id());
//
//        assertNotNull(periodo2);
//        assertNotEquals(0, periodo2.getPeriodo_academico_id());
//        assertEquals(periodo.getPeriodo_academico_id(), periodo2.getPeriodo_academico_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nPeriodoImplTest: VerificarQueListaSiRetorneAlgo");
//        List<PeriodoAcademico> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
