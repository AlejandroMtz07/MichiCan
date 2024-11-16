<%-- 
    Document   : cambiosAdministrador
    Created on : 22 may 2024, 22:21:05
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
        <title>Cambios</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body>
        <h1>Pagina de cambios</h1>
        Pulse la flecha regresar y recargue la pagina para ver los cambios
        <%
            String nombreServicio = request.getParameter("nombreServicio");
            nombreServicio.replace("", "");
            String descripcionServicio = request.getParameter("descripcionServ");
            String costoServicio = request.getParameter("costoServicio");
            float costo = Float.parseFloat(costoServicio);
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
                    PreparedStatement materias = connection.prepareStatement("insert into servicio (Nombre,Descripcion,Costo) values(?,?,?);");
                    materias.setString(1, nombreServicio);
                    materias.setString(2, descripcionServicio);
                    materias.setFloat(3, costo);
                    ResultSet resultado = materias.executeQuery();
                    if(resultado.next()) {
                        out.println(resultado.getString(1));
                    }
                } catch (java.sql.SQLException sqle) {
                     response.sendRedirect("http://localhost:8080/MichiCan/loginAdministrador.jsp?nombreUsuario=postgres&contraUsuario=juan2307");
                }
        %>
    </body>
</html>
