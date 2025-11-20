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
//import pe.edu.sis.gracademico.dao.AulaDAO;
//import pe.edu.sis.gracademico.dao.GradoDAO;
//import pe.edu.sis.gracademico.mysql.AulaImpl;
//import pe.edu.sis.gracademico.mysql.GradoImpl;
//import pe.edu.sis.matricula.dao.PeriodoDAO;
//import pe.edu.sis.matricula.dao.PeriodoXAulaDAO;
//import pe.edu.sis.model.grAcademico.Aula;
//import pe.edu.sis.model.grAcademico.GradoAcademico;
//import pe.edu.sis.model.matricula.PeriodoAcademico;
//import pe.edu.sis.model.matricula.PeriodoXAula;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class PeriodoXAulaImplTest {
//
//    PeriodoXAulaDAO dao;
//    PeriodoXAula periodoXAula;
//
//    @BeforeAll
//    void CrearPeriodoXAula() {
//        System.out.println("\n------------ PeriodoXAulaImplTest ------------");
//
//        GradoDAO gradoDAO = new GradoImpl();
//        GradoAcademico grado = new GradoAcademico("1er Grado Primaria", "1erP");
//        gradoDAO.insertar(grado);
//
//        AulaDAO aulaDAO = new AulaImpl();
//        Aula aula = new Aula("Aula 1", grado);
//        aulaDAO.insertar(aula);
//
//        PeriodoDAO periodoDAO = new PeriodoImpl();
//        PeriodoAcademico periodo = new PeriodoAcademico("2025-II", "Periodo de prueba para PeriodoXAula", new Date(),
//                new Date());
//        periodoDAO.insertar(periodo);
//
//        periodoXAula = new PeriodoXAula(periodo, aula, 30, 0);
//        dao = new PeriodoXAulaImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nPeriodoXAulaImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(periodoXAula));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nPeriodoXAulaImplTest: VerificarRegistrosModificadosEsCorrecto");
//        periodoXAula.setVacantes_disponibles(25);
//        assertEquals(1, dao.modificar(periodoXAula));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nPeriodoXAulaImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(periodoXAula.getPeriodo_aula_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nPeriodoXAulaImplTest: VerificarQueObtenemosElMismoID");
//        PeriodoXAula periodoXAula2 = dao.obtener_por_id(periodoXAula.getPeriodo_aula_id());
//        assertNotNull(periodoXAula2);
//        assertNotEquals(0, periodoXAula2.getPeriodo_aula_id());
//        assertEquals(periodoXAula.getPeriodo_aula_id(), periodoXAula2.getPeriodo_aula_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nPeriodoXAulaImplTest: VerificarQueListaSiRetorneAlgo");
//        List<PeriodoXAula> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
