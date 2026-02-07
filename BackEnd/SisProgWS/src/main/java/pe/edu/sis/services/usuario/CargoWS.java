/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.sis.services.usuario;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.ArrayList;
import pe.edu.sis.model.usuario.Cargo;
import pe.edu.sis.usuario.BO.CargoBO;
import pe.edu.sis.usuario.BOImpl.CargoBOImpl;

/**
 *
 * @author jaso
 */
@WebService(serviceName = "CargoWS")
public class CargoWS {
    
    private CargoBO boCargo;
    
    public CargoWS(){
        this.boCargo=new CargoBOImpl();
    }
    
    @WebMethod(operationName = "insertarCargo")
    public int insertarCargo(@WebParam(name = "cargo")Cargo cargo){
        int resultado = 0;
        try{
            resultado = boCargo.insertar(cargo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "modificarCargo")
    public int modificarCargo(@WebParam(name = "cargo")Cargo cargo){
        int resultado = 0;
        try{
            resultado = boCargo.modificar(cargo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "eliminarCargoPorId")
    public int eliminarCargoPorId(@WebParam(name = "idCargo")int idCargo){
        int resultado = 0;
        try{
            resultado = boCargo.eliminar(idCargo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return resultado;
    }
    
    @WebMethod(operationName = "obtenerCargoPorId")
    public Cargo obtenerCargoPorId(@WebParam(name = "idCargo")int idCargo){
        Cargo cargo = null;
        try{
            cargo = boCargo.obtenerPorId(idCargo);
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return cargo;
    }
    
    @WebMethod(operationName = "listarCargosTodos")
    public ArrayList<Cargo> listarCargosTodos() {
        ArrayList<Cargo> cargos = null;
        try{
            cargos = boCargo.listarTodos();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return cargos;
    }
}
