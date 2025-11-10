//package pe.edu.sis.gracademico.mysql;
//
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
//import pe.edu.sis.gracademico.dao.AulaDAO;
//import pe.edu.sis.gracademico.dao.GradoDAO;
//import pe.edu.sis.model.grAcademico.Aula;
//import pe.edu.sis.model.grAcademico.GradoAcademico;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class AulaImplTest {
//
//    AulaDAO dao;
//    Aula aula;
//
//    @BeforeAll
//    void CrearAula() {
//        System.out.println("\n------------ AulaImplTest ------------");
//
//        GradoDAO gradoDAO = new GradoImpl();
//        GradoAcademico grado = new GradoAcademico("Inicial", "Pato");
//        gradoDAO.insertar(grado);
//
//        aula = new Aula("Salon 1", grado);
//        dao = new AulaImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nAulaImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(aula));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nAulaImplTest: VerificarRegistrosModificadosEsCorrecto");
//        aula.setNombre("Salon 2");
//        assertEquals(1, dao.modificar(aula));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nAulaImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(aula.getAula_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nAulaImplTest: VerificarQueObtenemosElMismoID");
//        Aula aula2 = dao.obtener_por_id(aula.getAula_id());
//        assertNotNull(aula2);
//        assertNotEquals(0, aula2.getAula_id());
//        assertEquals(aula.getAula_id(), aula2.getAula_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nAulaImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Aula> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
