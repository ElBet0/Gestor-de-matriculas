
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import pe.edu.sis.gestalumno.dao.AlumnoDAO;
import pe.edu.sis.gestalumno.mysql.AlumnoImpl;
import pe.edu.sis.gestdeuda.dao.DeudaDAO;
import pe.edu.sis.gestdeuda.mysql.DeudaImpl;
import pe.edu.sis.gestfamilia.dao.FamiliaDAO;
import pe.edu.sis.gestfamilia.mysql.FamiliaImpl;
import pe.edu.sis.gestpago.dao.PagoDAO;
import pe.edu.sis.gestpago.mysql.PagoImpl;
import pe.edu.sis.gestvacanteaula.dao.VacanteAulaDAO;
import pe.edu.sis.gestvacanteaula.mysql.VacanteAulaImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;
import pe.edu.sis.model.deuda.Deuda;
import pe.edu.sis.model.deuda.Medio;
import pe.edu.sis.model.deuda.Pago;
import pe.edu.sis.model.deuda.TipoDeuda;
import pe.edu.sis.model.matricula.VacantesAula;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
/**
 *
 * @author seinc
 */
public class SisProg {

    public static void main(String[] args) throws Exception {
        /*--------------------CRUD FAMILIA----------------------*/
        System.out.println("FAMILIA: \n");

        Familia _familia = new Familia("Laos", "Del Rio", "99999999", "asd@gmail.com", "por la pucp");
        FamiliaDAO familiaDAO = new FamiliaImpl();
        //---------------INSERTAR 
        familiaDAO.insertar(_familia);
        //-------------------MODIFICAR
        _familia.setApellido_materno("Laos(modificado)");
        int res = familiaDAO.modificar(_familia);
        if (res != 0) {
            System.out.println("SE MODIFICO");
        }
        
        //----------------Obtener por id
        Familia _familia2 = familiaDAO.obtener_por_id(_familia.getFamilia_id());
        System.out.println(_familia2);
        
        //----------------------Imprimir todo
        for (Familia f : familiaDAO.listarTodos()) {
            System.out.println(f);
        }
        
        System.out.println();
        System.out.println();
        
        System.out.println("ALUMNO: \n");

        /*--------------------CRUD ALUMNO----------------------*/
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        Alumno _alumno = new Alumno("Manuel", 111, sdf.parse("08-09-1478"), sdf.parse("02-03-1978"), 'M', "Judio", _familia2, "Problematico", 1000);
        AlumnoDAO alumnoDAO = new AlumnoImpl();
        
        //---------------INSERTAR 
        alumnoDAO.insertar(_alumno);
        _alumno = new Alumno("Pedrito", 112, sdf.parse("08-09-1478"), sdf.parse("02-03-1978"), 'M', "Judio", _familia, "Problematico", 1000);
        alumnoDAO.insertar(_alumno);
        
        //-------------------MODIFICAR
        _alumno.setNombre("Roberto(Modificado)");
        res = alumnoDAO.modificar(_alumno);
        if (res != 0) {
            System.out.println("SE MODIFICO");
        }

        //----------------Obtener por id
        Alumno _alumno2 = alumnoDAO.obtener_por_id(_alumno.getAlumno_id());
        System.out.println(_alumno2);
    
        //----------------------Listar todo
        for (Alumno a : alumnoDAO.listarTodos()) {
            System.out.println(a);
        }
        
        System.out.println();
        System.out.println();
        
        System.out.println("DEUDAS: \n");
        
        /*--------------------CRUD DEUDAS----------------------*/
        Deuda _deuda = new Deuda(100, sdf.parse("23-12-2023"),
                sdf.parse("23-12-2025"), "descripcion buena", 0,
                TipoDeuda.MATRICULA, _alumno);
        DeudaDAO deudaDAO = new DeudaImpl();
        //INSERTAR
        deudaDAO.insertar(_deuda);

        //MODIFICAR
        _deuda.setMonto(200);
        int resultado = deudaDAO.modificar(_deuda);
        if (resultado != 0) {
            System.out.println("Se modifico con resultado: " + resultado);
        }

        //Obtener por id
        Deuda _deuda2 = deudaDAO.obtener_por_id(_deuda.getDeuda_id());
        System.out.println(_deuda2);
        
        //obtenemos lista de todos las deudas registradas
        ArrayList<Deuda> arrDeudas = deudaDAO.listarTodos();
        for (var d : arrDeudas) {
            System.out.println(d);
        }
        
  
        System.out.println();
        System.out.println();
        
        System.out.println("PAGOS: \n");

        /*--------------------CRUD PAGOS----------------------*/
        Pago _pago = new Pago(100, sdf.parse("22-11-2025"), Medio.EFECTIVO, "Pago deuda completa", _deuda);
        PagoDAO pagoDAO = new PagoImpl();

        //Insert
        pagoDAO.insertar(_pago);

        //modificar
        _pago.setMonto(_pago.getMonto() * 0.8);
        pagoDAO.modificar(_pago);

        
        Pago _pago2 = pagoDAO.obtener_por_id(_pago.getPago_id());
        System.out.println(_pago2);
        
        //Listar todos los pagos
        for (var p : pagoDAO.listarTodos()) {
            System.out.println(p);
        }
        
        System.out.println();
        System.out.println();
        
        System.out.println("AULAS VACANTES: \n");

        /*--------------------CRUD AULAS_VACANTES----------------------*/
        VacantesAula _vacAula = new VacantesAula("2do B", 9, 1);
        VacanteAulaDAO vacAulaDAO = new VacanteAulaImpl();
        
        //INSERT
        vacAulaDAO.insertar(_vacAula);
        
        //MODIFICAR
        _vacAula.setVacantes_ocupadas(_vacAula.getVacantes_ocupadas() + 1);
        vacAulaDAO.modificar(_vacAula);
        
        //Obtener por id
        VacantesAula _vacAula2 = vacAulaDAO.obtener_por_id(_vacAula.getAula_id());
        System.out.println(_vacAula2);
        
        //Listar todos
        for(var v : vacAulaDAO.listarTodos())
            System.out.println(v);
        
        //-----------------------ELIMINAR
        pagoDAO.eliminar(_pago.getPago_id());
        deudaDAO.eliminar(_deuda.getDeuda_id());
        familiaDAO.eliminar(_familia.getFamilia_id());
        alumnoDAO.eliminar(_alumno.getAlumno_id());
        vacAulaDAO.eliminar(_vacAula.getAula_id());
    }
}
