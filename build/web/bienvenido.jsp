<%-- 
    Document   : bienvenido
    Created on : 16 may 2024, 07:25:31
    Author     : aleja
--%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bienvenido</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css">
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyCredenciales">
        <%
            //Valor para validación de remitente
            String remitente = request.getHeader("referer");
            //Validación del remitente
            if (remitente == null || (!remitente.contains("http://localhost:8080/MichiCan/"))) {
                response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
            }
            //Valores para registro
            String nombre = request.getParameter("nombreUsuario");
            String apellido = request.getParameter("apellidoUsuario");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            String contrasenia = request.getParameter("contrasenia");
            String sexo = request.getParameter("sexoUsuario");
            //Validación de datos ingresados
            boolean validaNombre = Pattern.matches("[a-zA-Z0-9_áéíóúÁÉÍÓÚñÑ]+", nombre);
            boolean validaApellido = Pattern.matches("[a-zA-Z0-9_áéíóúÁÉÍÓÚñÑ]+", nombre);
            boolean validaContrasenia = Pattern.matches("[a-zA-Z0-9_áéíóúÁÉÍÓÚñÑ]+", nombre);

            if (!validaNombre) {
                response.sendRedirect("http://localhost:8080/MichiCan/registroCliente.jsp?Mensaje=No-ingreses-caracteres-invalidos");
            } else if (!validaApellido) {
                response.sendRedirect("http://localhost:8080/MichiCan/registroCliente.jsp?Mensaje=No-ingreses-caracteres-invalidos");
            } else if (!validaContrasenia) {
                response.sendRedirect("http://localhost:8080/MichiCan/registroCliente.jsp?Mensaje=No-ingreses-caracteres-invalidos");
            }
            //Insancia de sesion para cookies
            HttpSession sesion = request.getSession();
            //Creación de cookies
            sesion.setAttribute("nombreUsuario", nombre);
            sesion.setAttribute("apellidoUsuario", apellido);
            sesion.setAttribute("telefono", telefono);
            sesion.setAttribute("correo", correo);
            sesion.setAttribute("contrasenia", contrasenia);
            //Creación de la consulta a la base de datos y redirección al inicio luego de inserción de usuario
            if (nombre == null) {
                response.sendRedirect("http://localhost:8080/MichiCan/registroCliente.jsp");
            } else {
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
                    PreparedStatement materias = connection.prepareStatement("Insert into cliente (Nombre,Contraseña,Apellido,Telefono,Sexo,Correo) "
                    + "values (?,?,?,?,?,?);");
                    materias.setString(1, nombre);
                    materias.setString(2, contrasenia);
                    materias.setString(3, apellido);
                    materias.setString(4, telefono);
                    materias.setString(5, sexo);
                    materias.setString(6, correo);
                    ResultSet resultado = materias.executeQuery();
                    while (resultado.next()) {

                    }
                } catch (java.sql.SQLException sqle) {
                    System.out.println("Error: " + sqle);
                }
            }
        %>
        <h1>¡Conserve bien sus credenciales!</h1>
        <div id="mensajeCredenciales">
            Dentro de este campo habrá las credenciales para iniciar sesión:
            <%
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
                PreparedStatement materias = connection.prepareStatement("Select (ID_Cliente) from cliente where (Contraseña,Apellido,Telefono)=(?,?,?);");
                materias.setString(1, contrasenia);
                materias.setString(2, apellido);
                materias.setString(3, telefono);
                ResultSet resultado = materias.executeQuery();
                while(resultado.next()) {
                    out.println("<br>Esta es su id: "+resultado.getString(1));
                    out.println("Esta es su contraseña: "+contrasenia);
                    
                }
            } catch (java.sql.SQLException sqle) {
                System.out.println("Error: " + sqle);
            }
            %>
        </div>
        <br><a href="./index.jsp" class="linkRef" id="botonRegreso">Acceder</a> 
    </body>
    
</html>
