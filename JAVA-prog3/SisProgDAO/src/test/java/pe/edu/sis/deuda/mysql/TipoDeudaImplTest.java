//package pe.edu.sis.deuda.mysql;
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
//import pe.edu.sis.deuda.dao.TipoDeudaDAO;
//import pe.edu.sis.model.deuda.TipoDeuda;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//class TipoDeudaImplTest {
//    TipoDeudaDAO dao;
//    TipoDeuda tipoDeuda;
//
//    @BeforeAll
//    void crearTipoDeuda() {
//        System.out.println("\n------------ TipoDeudaImplTest ------------");
//        tipoDeuda = new TipoDeuda("Test Deuda", 250.0);
//        dao = new TipoDeudaImpl();
//    }
//
//    @Test
//    @Order(1)
//    void verificarInsercionCorrecta() {
//        System.out.println("\nTipoDeudaImplTest: verificarInsercionCorrecta");
//
//        assertNotEquals(-1, dao.insertar(tipoDeuda));
//    }
//
//    @Test
//    @Order(2)
//    void verificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nTipoDeudaImplTest: verificarRegistrosModificadosEsCorrecto");
//        tipoDeuda.setDescripcion("Test Deuda Modificado");
//        tipoDeuda.setMonto_general(300.0);
//        assertEquals(1, dao.modificar(tipoDeuda));
//    }
//
//    @Test
//    @Order(5)
//    void verificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nTipoDeudaImplTest: verificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(tipoDeuda.getId_tipo_deuda()) >= 0);
//    }
//
//    @Test
//    @Order(3)
//    void verificarQueObtenemosElMismoID() {
//        System.out.println("\nTipoDeudaImplTest: verificarQueObtenemosElMismoID");
//        TipoDeuda tipoDeuda2 = dao.obtener_por_id(tipoDeuda.getId_tipo_deuda());
//        assertNotNull(tipoDeuda2);
//        assertEquals(tipoDeuda.getId_tipo_deuda(), tipoDeuda2.getId_tipo_deuda());
//    }
//
//    @Test
//    @Order(4)
//    void verificarQueListaSiRetorneAlgo() {
//        System.out.println("\nTipoDeudaImplTest: verificarQueListaSiRetorneAlgo");
//        List<TipoDeuda> lista = dao.listarTodos();
//        assertFalse(lista.isEmpty());
//    }
//}
