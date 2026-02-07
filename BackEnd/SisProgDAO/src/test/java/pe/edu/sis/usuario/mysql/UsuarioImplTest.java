package pe.edu.sis.usuario.mysql;

import java.util.List;

import static org.junit.Assert.assertNotNull;
import org.junit.jupiter.api.AfterAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestMethodOrder;

import pe.edu.sis.model.usuario.Rol;
import pe.edu.sis.model.usuario.Usuario;
import pe.edu.sis.usuario.dao.UsuarioDAO;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class UsuarioImplTest {

    Usuario user;
    UsuarioDAO dao;

    @BeforeAll
    void CrearUsuario() throws Exception {
        System.out.println("\n------------ UsuarioImplTest ------------");
        user = new Usuario("xXxTestUserXxX", "TestPassword1234", Rol.DIRECTOR);

        dao = new UsuarioImpl();
    }

    @Test
    @Order(1)
    void VerificarInsercionCorrecta() {
        System.out.println("\nUsuarioImplTest: VerificarInsercionCorrecta");
        assertNotEquals(-1, dao.insertar(user));
    }

    @Test
    @Order(2)
    void VerificarRegistrosModificadosEsCorrecto() {
        System.out.println("\nUsuarioImplTest: VerificarRegistrosModificadosEsCorrecto");
        user.setNombre("TestUserModified");
        assertEquals(1, dao.modificar(user));
    }

    @Test
    @Order(5)
    void VerificarEliminarDevuelveCodigoPositivo() {
        System.out.println("\nUsuarioImplTest: VerificarEliminarDevuelveCodigoPositivo");
        assertTrue(dao.eliminar(user.getUsuario_id()) > 0);
    }

    @Test
    @Order(3)
    void VerificarQueObtenemosElMismoID() {
        System.out.println("\nUsuarioImplTest: VerificarQueObtenemosElMismoID");
        Usuario user2 = dao.obtener_por_id(user.getUsuario_id());
        assertNotNull(user2);
        assertNotEquals(-1, user2.getUsuario_id());
        assertEquals(user.getUsuario_id(), user2.getUsuario_id());
    }

    @Test
    @Order(4)
    void VerificarQueListaSiRetorneAlgo() {
        System.out.println("\nUsuarioImplTest: VerificarQueListaSiRetorneAlgo");
        List<Usuario> lista = dao.listarTodos();
        assertTrue(!lista.isEmpty());
    }
//
//    @AfterAll
//    void EliminarDatosCreado() {
//        System.out.println("\nUsuarioImplTest: Pruebas finalizadas.");
//    }
}
