//package pe.edu.sis.usuario.mysql;
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
//import pe.edu.sis.model.usuario.Cargo;
//import pe.edu.sis.model.usuario.Personal;
//import pe.edu.sis.model.usuario.TipoContrato;
//import pe.edu.sis.usuario.dao.PersonalDAO;
//
//@TestInstance(TestInstance.Lifecycle.PER_CLASS)
//@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
//public class PersonalImpTest {
//
//    Personal personal;
//    PersonalDAO dao;
//    Cargo cargo;
//
//    @BeforeAll
//    void CrearPersonal() {
//        System.out.println("\n------------ PersonalImpTest ------------");
//
//        cargo = new Cargo();
//        cargo.setNombre("Prosor");
//        new CargoImpl().insertar(cargo);
//
//        personal = new Personal();
//        personal.setNombre("Sergio");
//        personal.setApellido_paterno("Ingunza");
//        personal.setApellido_materno("Michilala");
//        personal.setDni(20230417);
//        personal.setCorreo_electronico("a20230417@pucp.edu.pe");
//        personal.setTelefono("123456789");
//        personal.setSalario(1.00);
//        personal.setFecha_Contratacion(new Date());
//        personal.setFin_fecha_Contratacion(new Date());
//        personal.setTipo_contrato(TipoContrato.PARCIAL);
//        personal.setCargo(cargo);
//
//        dao = new PersonalImp();
//    }
//
//    @Test
//    @Order(1)
//    void VerificarInsercionCorrecta() {
//        System.out.println("\nPersonalImpTest: VerificarInsercionCorrecta");
//        assertNotEquals(-1, dao.insertar(personal));
//    }
//
//    @Test
//    @Order(2)
//    void VerificarRegistrosModificadosEsCorrecto() {
//        System.out.println("\nPersonalImpTest: VerificarRegistrosModificadosEsCorrecto");
//        personal.setSalario(0.5);
//        assertEquals(1, dao.modificar(personal));
//    }
//
//    @Test
//    @Order(5)
//    void VerificarEliminarDevuelveCodigoPositivo() {
//        System.out.println("\nPersonalImpTest: VerificarEliminarDevuelveCodigoPositivo");
//        assertTrue(dao.eliminar(personal.getPersonal_id()) > 0);
//    }
//
//    @Test
//    @Order(3)
//    void VerificarQueObtenemosElMismoID() {
//        System.out.println("\nPersonalImpTest: VerificarQueObtenemosElMismoID");
//        Personal personal2 = dao.obtener_por_id(personal.getPersonal_id());
//        assertNotNull(personal2);
//        assertNotEquals(-1, personal2.getPersonal_id());
//        assertEquals(personal.getPersonal_id(), personal2.getPersonal_id());
//    }
//
//    @Test
//    @Order(4)
//    void VerificarQueListaSiRetorneAlgo() {
//        System.out.println("\nPersonalImpTest: VerificarQueListaSiRetorneAlgo");
//        List<Personal> lista = dao.listarTodos();
//        assertTrue(!lista.isEmpty());
//    }
//
//    @AfterAll
//    void EliminarDatosCreado() {
//        new CargoImpl().eliminar(cargo.getCargo_id());
//        System.out.println("\nPersonalImpTest: Pruebas finalizadas.");
//    }
//}
