<%-- 
    Document   : altaVeterinarios
    Created on : 24 may 2024, 13:56:59
    Author     : aleja
--%>

<%@page import="java.sql.Time"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta veterinarios</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body>
        <h1>Veterinario dado de alta</h1>
        <%
            String nombreVet = request.getParameter("nombreVet");
            String apellidoVet = request.getParameter("apellidoVet");
            String telefonoVet = request.getParameter("telefonoVet");
            String especialidadVet = request.getParameter("especialidadVet");
            String horaEnt = request.getParameter("horaEntrada");
            java.sql.Time horaEntrada = java.sql.Time.valueOf(horaEnt+":00");
            String horaSal = request.getParameter("horaSalida");
            java.sql.Time horaSalida = java.sql.Time.valueOf(horaSal+":00");
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
                PreparedStatement veterinarios = connection.prepareStatement("insert into Veterinario (Nombre,Apellido,Telefono,Especialidad,HoraEntrada,"
                + "HoraSalida) values(?,?,?,?,?,?);");
                veterinarios.setString(1, nombreVet);
                veterinarios.setString(2, apellidoVet);
                veterinarios.setString(3, telefonoVet);
                veterinarios.setString(4, especialidadVet);
                veterinarios.setTime(5, horaEntrada);
                veterinarios.setTime(6, horaSalida);
                ResultSet resultado = veterinarios.executeQuery();
                while (resultado.next()) {
                    
                }
            } catch (java.sql.SQLException sqle) {
                out.println("Error al insertar al veterinario"+sqle);
            }
        %>
        <h3>Llave de ingreso para el veterinario</h3>
        <%
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
                PreparedStatement veterinarios = connection.prepareStatement("Select (ID_Veterinario) from Veterinario where (Nombre,Apellido,Telefono,Especialidad,HoraEntrada,HoraSalida)"
                + "=(?,?,?,?,?,?);");
                veterinarios.setString(1, nombreVet);
                veterinarios.setString(2, apellidoVet);
                veterinarios.setString(3, telefonoVet);
                veterinarios.setString(4, especialidadVet);
                veterinarios.setTime(5, horaEntrada);
                veterinarios.setTime(6, horaSalida);
                ResultSet resultado = veterinarios.executeQuery();
                while (resultado.next()) {
                    out.println("<p>"+resultado.getString(1)+"</p>");
                }
            } catch (java.sql.SQLException sqle) {
                
            }
        %>
        <h3>*Pulse la tecla regresar y recargue la pagina para visualizar los cambios*</h3>
    </body>
</html>
