<%-- 
    Document   : consultaHistoriales
    Created on : 2 jun 2024, 21:17:25
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
        <title>Historial</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyHistorialVet">
        <div id="divHistorial">
        <h1>Aquí encontrarás todos los procedimientos de la mascota:</h1>
        <%
            String idMascota = request.getParameter("IDMascota");
            int id = Integer.parseInt(idMascota);
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
                PreparedStatement historial = connection.prepareStatement("Select * from Historial where ID_Mascota=?;");
                historial.setInt(1, id);
                ResultSet resultado = historial.executeQuery();
                out.println("<h3>Historiales</h3>");
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>ID_Historial</th>");
                out.println("<th>Fecha</th>");
                out.println("<th>Servicio</th>");
                out.println("<th>Descripcion</th>");
                out.println("<th>ID_Mascota</th>");
                out.println("</tr>");
                while(resultado.next()){
                    out.println("<tr>");
                    out.println("<td>"+resultado.getString(1)+"</td>");
                    out.println("<td>"+resultado.getString(2)+"</td>");
                    out.println("<td>"+resultado.getString(3)+"</td>");
                    out.println("<td>"+resultado.getString(4)+"</td>");
                    out.println("<td>"+resultado.getString(5)+"</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch (java.sql.SQLException sqle) {
                out.println("<p>No se encontró el historial de la mascota o la mascota no existe</p>"+sqle);
            }
        %>
        </div>
    </body>
</html>
