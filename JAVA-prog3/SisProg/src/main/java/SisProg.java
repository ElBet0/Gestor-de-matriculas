
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import pe.edu.sis.gestalumno.dao.AlumnoDAO;
import pe.edu.sis.gestalumno.mysql.AlumnoImpl;
import pe.edu.sis.gestfamilia.dao.FamiliaDAO;
import pe.edu.sis.gestfamilia.mysql.FamiliaImpl;
import pe.edu.sis.model.alumno.Alumno;
import pe.edu.sis.model.alumno.Familia;

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
        Familia familia =new Familia("Laos","Del Rio","99999999","asd@gmail.com","por la pucp");
        FamiliaDAO fam=new FamiliaImpl();
        //---------------INSERTAR 
        //fam.insertar(familia);
        //familia.setApellido_materno("Laos(modificado)");
        //-------------------MODIFICAR
        //int res=fam.modificar(familia);
        //if(res!=0)System.out.println("SE MODIFICO");
        //-----------------------ELIMINAR
        //fam.eliminar(2);
        //----------------Obtener por id
        familia=fam.obtener_por_id(1);
        //System.out.println(familia);
        //----------------------Listar todo
        //ArrayList<Familia> lista=fam.listarTodos();
        //for(Familia f : lista)System.out.println(f);
        /*--------------------CRUD ALUMNO----------------------*/
//        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
//        Alumno alumno=new Alumno("Manuel", 1231234, sdf.parse("08-09-1478"), sdf.parse("02-03-1978"), 'M', "Judio", familia, "Problematico", 1000);
//        AlumnoDAO al=new AlumnoImpl();
        //---------------INSERTAR 
//        familia=fam.obtener_por_id(4);
//        al.insertar(alumno);
//        alumno= new Alumno("Pedrito", 74158423, sdf.parse("08-09-1478"), sdf.parse("02-03-1978"), 'M', "Judio", familia, "Problematico", 1000);
//        al.insertar(alumno);
////        //-------------------MODIFICAR
//        alumno.setNombre("Roberto(Modificado)");
//        int res=al.modificar(alumno);
//        if(res!=0)System.out.println("SE MODIFICO");
////        //-----------------------ELIMINAR
//        al.eliminar(2);
        //----------------Obtener por id
//       alumno=al.obtener_por_id(1);
//       System.out.println(alumno);
//        //----------------------Listar todo
//        ArrayList<Alumno> lista=al.listarTodos();
//       for(Alumno a : lista)System.out.println(a);
        /*--------------------CRUD DEUDAS----------------------*/
    }
}
