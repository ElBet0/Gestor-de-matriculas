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
//import pe.edu.sis.gracademico.dao.GradoDAO;
//import pe.edu.sis.model.grAcademico.GradoAcademico;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class GradoImplTest {
//
//    GradoDAO dao;
//    GradoAcademico grado;
//
//    @BeforeAll
//    void CrearGrado() {
//        System.out.println("\n------------ GradoImplTest ------------");
//        grado = new GradoAcademico("Secundaria Michilala", "secu");
//        dao = new GradoImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nGradoImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(grado));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nGradoImplTest: VerificarRegistrosModificadosEsCorrecto");
//        grado.setAbreviatura("SEC");
//        assertEquals(1, dao.modificar(grado));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nGradoImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(grado.getGrado_academico_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nGradoImplTest: VerificarQueObtenemosElMismoID");
//        GradoAcademico grado2 = dao.obtener_por_id(grado.getGrado_academico_id());
//        assertNotNull(grado2);
//        assertNotEquals(0, grado2.getGrado_academico_id());
//        assertEquals(grado.getGrado_academico_id(), grado2.getGrado_academico_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nGradoImplTest: VerificarQueListaSiRetorneAlgo");
//        List<GradoAcademico> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
