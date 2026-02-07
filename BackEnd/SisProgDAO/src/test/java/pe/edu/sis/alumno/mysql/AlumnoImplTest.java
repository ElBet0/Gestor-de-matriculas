//package pe.edu.sis.alumno.mysql;
//
//import java.util.Date;
//import java.util.List;
//
//import static org.junit.Assert.assertNotNull;
//import org.junit.jupiter.api.AfterAll;
//import static org.junit.jupiter.api.Assertions.assertEquals;
//import static org.junit.jupiter.api.Assertions.assertNotEquals;
//import static org.junit.jupiter.api.Assertions.assertTrue;
//import org.junit.jupiter.api.BeforeAll;
//import org.junit.jupiter.api.MethodOrderer;
//import org.junit.jupiter.api.Order;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.TestInstance;
//import org.junit.jupiter.api.TestMethodOrder;
//
//import pe.edu.sis.alumno.dao.AlumnoDAO;
//import pe.edu.sis.model.alumno.Alumno;
//import pe.edu.sis.model.alumno.Familia;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class AlumnoImplTest {
//    Alumno alumno;
//    Familia papis;
//    AlumnoDAO dao;
//
//    @BeforeAll
//    void CrearAlumno() {
//
//        System.out.println("\n------------ AlumnoImplTest ------------");
//
//        papis = new Familia("Del rio", "Laos", "987654321",
//                "a20230417@pucp.edu.pe", "Jr. Zepitas");
//
//        new FamiliaImpl().insertar(papis);
//
//        alumno = new Alumno("Marcelo", 0, new Date(2018, 2, 1), 'M',
//                papis, 0);
//
//        dao = new AlumnoImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nAlumnoImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(alumno));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nAlumnoImplTest: VerificarRegistrosModificadosEsCorrecto");
//        alumno.setReligion("Ateo");
//
//        assertEquals(1, dao.modificar(alumno));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nAlumnoImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(alumno.getAlumno_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nAlumnoImplTest: VerificarQueObtenemosElMismoID");
//        Alumno alumno2 = dao.obtener_por_id(alumno.getAlumno_id());
//        assertNotNull(alumno2);
//        assertNotEquals(-1, alumno2.getAlumno_id());
//        assertEquals(alumno.getAlumno_id(), alumno2.getAlumno_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nAlumnoImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Alumno> lista = dao.listarTodos();
//        assertTrue(!lista.isEmpty());
//    }
//
//    @AfterAll
//    void EliminarDatosCreado() {
//        new FamiliaImpl().eliminar(papis.getFamilia_id());
//    }
//}
