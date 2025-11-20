/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package pe.edu.sis.services.reportes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.awt.Image;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.util.HashMap;
import javax.swing.ImageIcon;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.sis.db.bd.DbManager;

/**
 *
 * @author Jason
 */

@WebService(serviceName = "ReportesWS",
        targetNamespace = "pe.edu.sis.services")
public class ReportesWS {

    public ReportesWS(){
        System.setProperty("user.language", "es");
        System.setProperty("user.country", "PE");
        System.setProperty("user.timezone", "GMT-5");
    }
    
    @WebMethod(operationName = "generarReporteDeudasFamilia")
    public byte[] generarReporteDeudasFamilia(@WebParam(name = "idFamilia") int idFamilia) {
        byte[] reporte = null;
        try{
            //Referenciamos el archivo Jasper
            JasperReport jr = (JasperReport) JRLoader.loadObject(getClass().getResourceAsStream("/pe/edu/sis/reports/ReporteDeudasFamilia.jasper"));
            
            //Referenciamos la imagen del logo y los subreportes
//            URL rutaURLImagen = getClass().getResource("/pe/edu/sis/images/logo.png");
            
            //Generamos los objetos necesarios en el reporte
//            String rutaImagen = URLDecoder.decode(rutaURLImagen.getPath(), "UTF-8");
//            Image imagen = (new ImageIcon(rutaImagen)).getImage();
            
            //Establecemos los parametros que necesita el reporte
            HashMap hm = new HashMap();
            hm.put("FAMILIA_ID", idFamilia);
//            hm.put("logo", imagen);
            
            //Establecemos la conexiÃ³n
            Connection con = DbManager.getInstance().getConnection();
            
            //Poblamos el reporte
            JasperPrint jp = JasperFillManager.fillReport(jr,hm,con);
            
            //Convertirmos el reporte a un arreglo de byte
            reporte = JasperExportManager.exportReportToPdf(jp);
        }catch(JRException ex){
            //UnsupportedEncodingException | JRException ex
            System.out.println("ERROR AL GENERAR EL REPORTE:" + ex.getMessage());
        }finally{
            DbManager.getInstance().cerrarConexion();
        }
        return reporte;
    }
}