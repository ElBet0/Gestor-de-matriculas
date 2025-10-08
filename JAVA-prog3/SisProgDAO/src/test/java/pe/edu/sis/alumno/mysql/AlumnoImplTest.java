//package pe.edu.sis.alumno.mysql;
//
//import org.junit.jupiter.api.*;
//import pe.edu.sis.alumno.dao.AlumnoDAO;
//import pe.edu.sis.model.alumno.Alumno;
//import pe.edu.sis.model.alumno.Familia;
//
//import java.util.Date;
//import java.util.List;
//
//import static org.junit.jupiter.api.Assertions.*;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class AlumnoImplTest {
//    Alumno alumno;
//    Familia papis;
//    AlumnoDAO dao;
//
//    @BeforeAll
//    void CrearAlumno(){
//        papis = new Familia("Del rio", "Laos", "987654321",
//                "a20230417@pucp.edu.pe", "Jr. Zepitas");
//
//        papis.setFamilia_id(new FamiliaImpl().insertar(papis));
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
//        alumno.setAlumno_id(dao.insertar(alumno));
//
//        assertNotEquals(-1, alumno.getAlumno_id());
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        alumno.setReligion("Ateo");
//
//        assertEquals(1, dao.modificar(alumno));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        assertTrue(dao.eliminar(alumno.getAlumno_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        Alumno alumno2 = dao.obtener_por_id(alumno.getAlumno_id());
//        int id = alumno2 == null ? -1 : alumno2.getAlumno_id();
//        assertNotEquals(-1, id);
//        assertEquals(alumno.getAlumno_id(), id);
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        List<Alumno> lista = dao.listarTodos();
//        assertTrue(!lista.isEmpty());
//    }
//
//    @AfterAll
//    void EliminarDatosCreado(){
//        new FamiliaImpl().eliminar(papis.getFamilia_id());
//    }
//}