<%-- 
    Document   : actualizarHorario
    Created on : 3 jun 2024, 13:22:47
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
        <title>Horario actualizado</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyActualizarHorario">
        <h1>Cambios realizados:</h1>
        <%
            String idVeterinario = request.getParameter("idVet");
            int id = Integer.parseInt(idVeterinario);
            String nuevaH = request.getParameter("nuevaEntrada");
            java.sql.Time horaEntrada = java.sql.Time.valueOf(nuevaH+":00");
            String nuevaS = request.getParameter("nuevaSalida");
            java.sql.Time horaSalida = java.sql.Time.valueOf(nuevaS+":00");
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
                PreparedStatement veterinarios = connection.prepareStatement("Update Veterinario set HoraEntrada=?, HoraSalida=? where ID_Veterinario"
                + "=?;");
                veterinarios.setTime(1, horaEntrada);
                veterinarios.setTime(2,horaSalida);
                veterinarios.setInt(3, id);
                ResultSet resultado = veterinarios.executeQuery();
                while (resultado.next()) {
                    
                }
            } catch (java.sql.SQLException sqle) {
                out.println("<p style=text-align:center>Cambios realizados correctamente al veterinario:"+idVeterinario+"</p>");
                out.println("<p style=text-align:center>Haga clic en la flecha atrás y refresque para ver los cambios</p>");
            }
        %>
        
    </body>
</html>
