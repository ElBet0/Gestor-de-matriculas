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
//import pe.edu.sis.gracademico.dao.CursoDAO;
//import pe.edu.sis.gracademico.dao.GradoDAO;
//import pe.edu.sis.model.grAcademico.Curso;
//import pe.edu.sis.model.grAcademico.GradoAcademico;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class CursoImplTest {
//
//    CursoDAO dao;
//    Curso curso;
//
//    @BeforeAll
//    void CrearCurso() {
//        System.out.println("\n------------ CursoImplTest ------------");
//
//        GradoDAO gradoDAO = new GradoImpl();
//        GradoAcademico grado = new GradoAcademico("Tercero Secundaria patito", "xd");
//        gradoDAO.insertar(grado);
//
//        curso = new Curso("Programacion", "Curso de programacion", 4, "PROG", grado);
//        dao = new CursoImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nCursoImplTest: VerificarInsercionCorrecta");
//        assertNotEquals(-1, dao.insertar(curso));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nCursoImplTest: VerificarRegistrosModificadosEsCorrecto");
//        curso.setDescripcion("Nueva descripcion del curso");
//        assertEquals(1, dao.modificar(curso));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nCursoImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(curso.getCurso_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nCursoImplTest: VerificarQueObtenemosElMismoID");
//        Curso curso2 = dao.obtener_por_id(curso.getCurso_id());
//        assertNotNull(curso2);
//        assertNotEquals(0, curso2.getCurso_id());
//        assertEquals(curso.getCurso_id(), curso2.getCurso_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nCursoImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Curso> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
