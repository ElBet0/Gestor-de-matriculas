//package pe.edu.sis.matricula.mysql;
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
//import pe.edu.sis.gracademico.mysql.AulaImpl;
//import pe.edu.sis.gracademico.mysql.GradoImpl;
//import pe.edu.sis.matricula.dao.MatriculaDAO;
//import pe.edu.sis.model.alumno.Alumno;
//import pe.edu.sis.model.alumno.Familia;
//import pe.edu.sis.model.grAcademico.Aula;
//import pe.edu.sis.model.grAcademico.GradoAcademico;
//import pe.edu.sis.model.matricula.Matricula;
//import pe.edu.sis.model.matricula.PeriodoAcademico;
//import pe.edu.sis.model.matricula.PeriodoXAula;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class MatriculaImplTest {
//    MatriculaDAO dao;
//    Matricula matricula;
//    Alumno alumno;
//    Familia familia;
//    PeriodoXAula periodoXAula;
//    PeriodoAcademico periodo;
//    Aula aula;
//    GradoAcademico grado;
//
//    @BeforeAll
//    void crearMatricula() {
//        // Dependencias
//        familia = new Familia("Perez", "Gomez", "999888777", "test@test.com", "Av. Siempre Viva 123");
//        new FamiliaImpl().insertar(familia);
//
//        alumno = new Alumno("Juanito", 12345678, new Date(), 'M', familia, 500.0);
//        new AlumnoImpl().insertar(alumno);
//
//        grado = new GradoAcademico("Primero", "1ro");
//        new GradoImpl().insertar(grado);
//
//        aula = new Aula("Aula 101", grado);
//        new AulaImpl().insertar(aula);
//
//        periodo = new PeriodoAcademico("2025-I", "Primer año patito 2025", new Date(), new Date());
//        new PeriodoImpl().insertar(periodo);
//
//        periodoXAula = new PeriodoXAula(periodo, aula, 30, 0);
//        new PeriodoXAulaImpl().insertar(periodoXAula);
//
//        // Objeto a probar
//        matricula = new Matricula(alumno, periodoXAula);
//        dao = new MatriculaImpl();
//    }
//
//    @Test
//    @Order(1)
//    void verificarInsercionCorrecta() {
//        System.out.println("\nMatriculaImplTest: verificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(matricula));
//    }
//
//    @Test
//    @Order(2)
//    void verificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nMatriculaImplTest: verificarRegistrosModificadosEsCorrecto");
//        matricula.getPeriodo_Aula().getAula().setNombre("Aula 102");
//        assertEquals(1, dao.modificar(matricula));
//    }
//
//    @Test
//    @Order(5)
//    void verificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nMatriculaImplTest: verificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(matricula.getMatricula_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void verificarQueObtenemosElMismoID() {
//        System.out.println("\nMatriculaImplTest: verificarQueObtenemosElMismoID");
//        Matricula matricula2 = dao.obtener_por_id(matricula.getMatricula_id());
//        assertNotNull(matricula2);
//        assertEquals(matricula.getMatricula_id(), matricula2.getMatricula_id());
//    }
//
//    @Test
//    @Order(4)
//    void verificarQueListaSiRetorneAlgo() {
//        System.out.println("\nMatriculaImplTest: verificarQueListaSiRetorneAlgo");
//        List<Matricula> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//
//    @AfterAll
//    void eliminarDatos() {
//        new AlumnoImpl().eliminar(alumno.getAlumno_id());
//        new FamiliaImpl().eliminar(familia.getFamilia_id());
//        new PeriodoXAulaImpl().eliminar(periodoXAula.getPeriodo_aula_id());
//        new PeriodoImpl().eliminar(periodo.getPeriodo_academico_id());
//        new AulaImpl().eliminar(aula.getAula_id());
//        new GradoImpl().eliminar(grado.getGrado_academico_id());
//    }
//}
