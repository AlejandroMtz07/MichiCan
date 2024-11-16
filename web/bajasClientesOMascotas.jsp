<%-- 
    Document   : cambiosAdministrador
    Created on : 19 may 2024, 20:53:50
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bajas</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css">
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyBajas"> 
        <h1>Cambio</h1>
        <%
            String bajaMascota = request.getParameter("id_mascota");
            String bajaCliente = request.getParameter("id_cliente");
            
            //Condiciona lo que se quiera hacer, en este caso, la baja de una mascota
            if(!bajaMascota.isEmpty()){
                int idBajaMascota = Integer.parseInt(bajaMascota);
                try {
                    try {
                        Class.forName("org.postgresql.Driver");
                    } catch (ClassNotFoundException ex) {
                        System.out.println("Error al registrar el driver de PostgreSQL: " + ex);
                    }
                    Connection connection;
                    // Conectamos con la base de datos
                    connection = DriverManager.getConnection("jdbc:postgresql://localhost/MichiCanDB", "postgres", "juan2307");
                    boolean valid = connection.isValid(50000);
                    PreparedStatement materias = connection.prepareStatement("delete from mascota where ID_Mascota=?;");
                    materias.setInt(1, idBajaMascota);
                    ResultSet resultado = materias.executeQuery();
                    if(resultado.next()) {
                    }
                } catch (java.sql.SQLException sqle) {
                    out.println("Se ha eliminado a la mascota");
                }
                //Baja de un cliente
            }else if(!bajaCliente.isEmpty()){
                int idBajaCliente = Integer.parseInt(bajaCliente);
                try {
                    try {
                        Class.forName("org.postgresql.Driver");
                    } catch (ClassNotFoundException ex) {
                        System.out.println("Error al registrar el driver de PostgreSQL: " + ex);
                    }
                    Connection connection;
                    // Conectamos con la base de datos
                    connection = DriverManager.getConnection("jdbc:postgresql://localhost/MichiCanDB", "postgres", "juan2307");
                    boolean valid = connection.isValid(50000);
                    PreparedStatement materias = connection.prepareStatement("delete from cliente where ID_Cliente=?;");
                    materias.setInt(1, idBajaCliente);
                    ResultSet resultado = materias.executeQuery();
                    if(resultado.next()) {
                        
                    }
                } catch (java.sql.SQLException sqle) {
                    out.println("Se ha eliminado al cliente, pulsa flecha regresar y refresca para ver los cambios");
                }
            }
        %>
    </body>
</html>
