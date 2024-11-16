<%-- 
    Document   : veterinarioLogin
    Created on : 24 may 2024, 16:15:22
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
        <title>Veterinario</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <%
        String remitente = request.getHeader("referer");
        if (remitente == null || (!remitente.contains("http://localhost:8080/MichiCan/"))) {
            response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
        }
        String idVet = request.getParameter("IDVet");
        int id=Integer.parseInt(idVet);
        String nombreVet = request.getParameter("NombreVet");
        String nombre="";
        String apellidoVet = request.getParameter("ApellidoVet");
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
            PreparedStatement materias = connection.prepareStatement("select (Nombre) from Veterinario where (ID_Veterinario,Nombre,Apellido)=(?,?,?);");
            materias.setInt(1,id);
            materias.setString(2, nombreVet);
            materias.setString(3, apellidoVet);
            ResultSet resultado = materias.executeQuery();
            if (resultado.next()) {
                nombre = (resultado.getString(1));
            } else {
                response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
            }
        } catch (java.sql.SQLException sqle) {
            System.out.println("Error: " + sqle);
        }
    %>
    <body id="bodyLoginVet">
        <h1>Bienvenido veterinario: <%out.println(nombre);%></h1>
        <div id="infoVeterinario">
        <%
            String servicio="";
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
                PreparedStatement servicios = connection.prepareStatement("select * from servicio;");
                PreparedStatement mascotas = connection.prepareStatement("select * from Mascota;");
                ResultSet resultado = servicios.executeQuery();
                ResultSet resultado2 = mascotas.executeQuery();
                out.println("<h3>Servicios</h3>");
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>Numero de servicio</th>");
                out.println("<th>Nombre</th>");
                out.println("<th>Descripcion</th>");
                out.println("<th>Costo</th>");
                out.println("</tr>");
                while(resultado.next()){
                    out.println("<tr>");
                    out.println("<td>"+resultado.getString(1)+"</td>");
                    out.println("<td>"+resultado.getString(2)+"</td>");
                    out.println("<td>"+resultado.getString(3)+"</td>");
                    out.println("<td>"+resultado.getString(4)+"</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                out.println("<h3>Mascotas</h3>");
                out.println("<table>");
                out.println("<tr>");
                out.println("<th>ID_Mascota</th>");
                out.println("<th>Nombre</th>");
                out.println("<th>Especie</th>");
                out.println("<th>Raza</th>");
                out.println("<th>Fecha de nacimiento</th>");
                out.println("<th>Dueño</th>");
                out.println("</tr>");
                while(resultado2.next()){
                    out.println("<tr>");
                    out.println("<td>"+resultado2.getString(1)+"</td>");
                    out.println("<td>"+resultado2.getString(2)+"</td>");
                    servicio=resultado2.getString(2);
                    out.println("<td>"+resultado2.getString(3)+"</td>");
                    out.println("<td>"+resultado2.getString(4)+"</td>");
                    out.println("<td>"+resultado2.getString(5)+"</td>");
                    out.println("<td>"+resultado2.getString(6)+"</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch (java.sql.SQLException sqle) {
                System.out.println("Error: " + sqle);
            }
        %>
        </div>
        <form action="agregarHistorial.jsp" onsubmit="return validarFecha()">
            <h3>Agregar al historial</h3>
            <label for="fechaH">Fecha de servicio: <br></label><input type="date" name="fechaHistorial" required="" id="fechaH"><br>
            Ingrese el servicio:<br><br><select name="descHistorial" id="selectServicios">
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
                        PreparedStatement historial = connection.prepareStatement("Select * from servicio;");
                        ResultSet resultado = historial.executeQuery();
                        while (resultado.next()) {
                            out.println("<option>" + resultado.getString(2) + "</option>");
                        }
                    } catch (java.sql.SQLException sqle) {
                        out.println(sqle);
                    }
                %>
            </select><br>
            <br>Descripcion del servicio dado: <br><input type="text" name="trataHistorial" required="" placeholder="Descripción"><br>
            Ingrese el ID de la mascota:<br><input type="number" name="idM" required="" placeholder="ID_Mascota"><br>
            <input type="submit" value="Agregar" class="botonesSig">
        </form>
            <form action="consultaHistoriales.jsp">
            <h3>Consultar historiales</h3>
            Ingrese el ID de la mascota: <br><input type="number" name="IDMascota" required="" placeholder="ID_Mascota">
            <br><input type="submit" value="Historial" class="botonesSig">
        </form>
        <br><a href="./index.jsp" class="linkRef">Regresar a inicio</a>
    </body>
    <script>
        function validarFecha(){
            const fechaInput = document.getElementById("fechaH");
            const fechaSeleccionada = new Date(fechaInput.value);
            const fechaActual = new Date();
            fechaActual.setHours(0,0,0,0);
            if(fechaSeleccionada>fechaActual){
                alert("La fecha no puede ser mayor al día de hoy");
                fechaInput.value="";
                return false;
            }
        }
    </script>
</html>
