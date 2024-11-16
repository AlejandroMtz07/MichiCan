<%-- 
    Document   : insertarMascota
    Created on : 16 may 2024, 14:20:43
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
        <title>Inserción correcta</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyInsertarMascota">
        <br><br><h1>Tu mascota se ha registrado correctamente</h1>
        <!-- Esta pagina solo será para insertar dentro de la tabla de mascotas del cliente, no tendrá interactividad con el cliente -->
        <%
            //Valor para validación de remitente
            String remitente = request.getHeader("referer");
            //Validación del remitente
            if (remitente == null || (!remitente.contains("http://localhost:8080/MichiCan/"))) {
                response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
            }
            //Obtener los parámetros ingresados por el cliente para registrar a su mascota
            String nombreMascota = request.getParameter("nombreMascota");
            String especieMascota = request.getParameter("especieMascota");
            String razaMascota = request.getParameter("razaMascota");
            String nacimientoMascota = request.getParameter("nacimientoMascota");
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date parsed = format.parse(nacimientoMascota);
            java.sql.Date sqlDate = new java.sql.Date(parsed.getTime());
            //Creación de una sesión para obtencion de cookies
            HttpSession sesion = request.getSession();
            String idUsuario=(String)sesion.getAttribute("ID");
            int idUsu = Integer.parseInt(idUsuario);
            try {
                    try {
                        Class.forName("org.postgresql.Driver");
                    } catch (ClassNotFoundException ex) {
                        System.out.println("Error al registrar el driver de PostgreSQL: " + ex);
                    }
                    Connection connection;
                    // Conectamos con la base de datos
                    connection = DriverManager.getConnection("jdbc:postgresql://localhost/MichiCanDB", "cliente", "1234");
                    boolean valid = connection.isValid(50000);
                    PreparedStatement materias = connection.prepareStatement("Insert into Mascota "
                    + "(Nombre_Mascota,Especie,Raza,Fecha_Nacimiento,ID_cliente) values (?,?,?,?,?);");
                    materias.setString(1, nombreMascota);
                    materias.setString(2, especieMascota);
                    materias.setString(3, razaMascota);
                    materias.setDate(4, sqlDate);
                    materias.setInt(5, idUsu);
                    ResultSet resultado = materias.executeQuery();
                    while(resultado.next()) {
                    }
                } catch (java.sql.SQLException sqle) {
                    System.out.println("Error: " + sqle);
                }
        %>
        <a href="http://localhost:8080/MichiCan/primera.jsp?ID=${ID}&contra=${contra}" class="linkRef">Regresar</a>
    </body>
</html>
