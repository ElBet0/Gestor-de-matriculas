//package pe.edu.sis.alumno.mysql;
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
//import pe.edu.sis.alumno.dao.FamiliaDAO;
//import pe.edu.sis.model.alumno.Familia;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class FamiliaImplTest {
//    FamiliaDAO dao;
//    Familia familia;
//
//    @BeforeAll
//    void CrearFamilia() {
//        System.out.println("\n------------ FamiliaImplTest ------------");
//
//        familia = new Familia("Del rio", "Laos", "987654321",
//                "a20230417@pucp.edu.pe", "Jr. Zepitas");
//
//        dao = new FamiliaImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nFamiliaImplTest: VerificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(familia));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nFamiliaImplTest: VerificarRegistrosModificadosEsCorrecto");
//        familia.setNumero_telefono("123456789");
//
//        assertEquals(1, dao.modificar(familia));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nFamiliaImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(familia.getFamilia_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nFamiliaImplTest: VerificarQueObtenemosElMismoID");
//        Familia familia2 = dao.obtener_por_id(familia.getFamilia_id());
//
//        assertNotNull(familia2);
//        assertNotEquals(-1, familia2.getFamilia_id());
//        assertEquals(familia.getFamilia_id(), familia2.getFamilia_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nFamiliaImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Familia> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
