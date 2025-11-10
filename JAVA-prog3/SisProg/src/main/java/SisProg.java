
import java.util.ArrayList;
import pe.edu.sis.alumno.BO.alumnoBO;
import pe.edu.sis.alumno.BOImpl.alumnoBOImpl;
import pe.edu.sis.model.alumno.Alumno;


/**
 *
 * @author seinc
 * @author ElBet0
 */
public class SisProg {

    public static alumnoBO bo = new alumnoBOImpl();

    public static void main(String[] args) {
        ArrayList<Alumno> alumnos = null;
        try {
            alumnos = bo.listarTodos();
            for (Alumno a : alumnos) {
                System.out.println(a.getAlumno_id() + " - " + a.getNombre());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
