<%-- 
    Document   : bajaVeterinarios
    Created on : 29 may 2024, 12:12:44
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
        <title>Baja veterinario</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body>
        <h1>Se ha hecho la consulta</h1>
        <%
            //Valor para la validación de remitente 
            String remitente = request.getHeader("referer");
            //Validación del remitente
            if (remitente == null || (!remitente.contains("http://localhost:8080/MichiCan/"))) {
                response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
            }
            String idVeterinario = request.getParameter("ID_Vet");
            int idVet = Integer.parseInt(idVeterinario);
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
                PreparedStatement veterinarios = connection.prepareStatement("delete from veterinario where ID_Veterinario=?;");
                veterinarios.setInt(1, idVet);
                ResultSet resultado = veterinarios.executeQuery();
                while (resultado.next()) {
                    out.println(resultado.getString(1));
                }
            } catch (java.sql.SQLException sqle) {
                out.println("Es ID de veterinario, no existe dentro de la base de datos");
            }
        %>
    </body>
</html>
