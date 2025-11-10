//package pe.edu.sis.usuario.mysql;
//
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
//import pe.edu.sis.model.usuario.Cargo;
//import pe.edu.sis.usuario.dao.CargoDAO;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class CargoImplTest {
//
//    Cargo cargo;
//    CargoDAO dao;
//
//    @BeforeAll
//    void CrearCargo() {
//        System.out.println("\n------------ CargoImplTest ------------");
//        cargo = new Cargo();
//        cargo.setNombre("TestCargo");
//
//        dao = new CargoImpl();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nCargoImplTest: VerificarInsercionCorrecta");
//        assertNotEquals(-1, dao.insertar(cargo));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nCargoImplTest: VerificarRegistrosModificadosEsCorrecto");
//        cargo.setNombre("TestCargoModified");
//        assertEquals(1, dao.modificar(cargo));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nCargoImplTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(cargo.getCargo_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nCargoImplTest: VerificarQueObtenemosElMismoID");
//        Cargo cargo2 = dao.obtener_por_id(cargo.getCargo_id());
//        assertNotNull(cargo2);
//        assertNotEquals(-1, cargo2.getCargo_id());
//        assertEquals(cargo.getCargo_id(), cargo2.getCargo_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nCargoImplTest: VerificarQueListaSiRetorneAlgo");
//        List<Cargo> lista = dao.listarTodos();
//        assertTrue(!lista.isEmpty());
//    }
//
//    @AfterAll
//    void EliminarDatosCreado() {
//        System.out.println("\nCargoImplTest: Pruebas finalizadas.");
//    }
//}
