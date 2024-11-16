<%-- 
    Document   : agregarHistorial
    Created on : 24 may 2024, 20:27:07
    Author     : aleja
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambios historial</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body>
        <h1>El cambio se realizó correctamente</h1>
        <%
            String fechaHist = request.getParameter("fechaHistorial");
            String descrHistorial = request.getParameter("descHistorial");
            String tratamiento = request.getParameter("trataHistorial");
            String idMascota = request.getParameter("idM");
            //Convertir la ID String a entero
            int id = Integer.parseInt(idMascota);
            //Convertir el String a tipo Date
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date parsed = format.parse(fechaHist);
            java.sql.Date sqlDate = new java.sql.Date(parsed.getTime());
            
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
                PreparedStatement historial = connection.prepareStatement("Insert into Historial (Fecha,Descripcion,Tratamiento,ID_Mascota)"
                + "values(?,?,?,?);");  
                historial.setDate(1, sqlDate);
                historial.setString(2, descrHistorial);
                historial.setString(3,tratamiento);
                historial.setInt(4,id);
                ResultSet resultado = historial.executeQuery();
                while (resultado.next()) {
                    out.println("Se hizo la inserción dentro del historial de la mascota");
                }
            } catch (java.sql.SQLException sqle) {
                out.println("Esa mascota no existe"+sqle);
            }
            
        %>
    </body>
</html>
