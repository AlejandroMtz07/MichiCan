<%-- 
    Document   : administradorSesion
    Created on : 18 may 2024, 14:06:15
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
        <title>¿O durando en el trabajo?</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyAdministrador">
        <h1>Bienvenido administrador</h1>
        <div id="informacion">
            <%
                //Valor para la validación de remitente 
                String remitente = request.getHeader("referer");
                //Validación del remitente
                if (remitente == null || (!remitente.contains("http://localhost:8080/MichiCan/"))) {
                    response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
                }
                //Valores ingresados por el usuario
                String usuario = request.getParameter("nombreUsuario");
                String contrasena = request.getParameter("contraUsuario");
                //Creación de la consulta para ingreso en modo administrador a la base de datos
                try {
                    try {
                        Class.forName("org.postgresql.Driver");
                    } catch (ClassNotFoundException ex) {
                        System.out.println("Error al registrar el driver de PostgreSQL: " + ex);
                    }
                    Connection connection;
                    // Conectamos con la base de datos
                    connection = DriverManager.getConnection("jdbc:postgresql://localhost/MichiCanDB", usuario, contrasena);
                    boolean valid = connection.isValid(50000);
                    PreparedStatement clientes = connection.prepareStatement("select * from cliente;");
                    PreparedStatement mascotas = connection.prepareStatement("select * from mascota;");
                    PreparedStatement bitacora = connection.prepareStatement("select * from bitacora");
                    PreparedStatement servicios = connection.prepareStatement("select * from servicio");
                    PreparedStatement veterinarios = connection.prepareStatement("select * from veterinario");
                    
                    ResultSet resultado = clientes.executeQuery();
                    ResultSet resultado2 = mascotas.executeQuery();
                    ResultSet resultado3 = bitacora.executeQuery();
                    ResultSet resultado4 = servicios.executeQuery();
                    ResultSet resultado5 = veterinarios.executeQuery();
                    
                    out.println("<h3>Usuarios:</h3>");
                    out.println("<table>"); // Inicio tabla de usuarios registrados
                    out.println("<tr>");
                    out.println("<th>ID_Usuario</th>");
                    out.println("<th>Nombre</th>");
                    out.println("<th>Apellido</th>");
                    out.println("<th>Contraseña</th>");
                    out.println("<th>Teléfono</th>");
                    out.println("<th>Sexo</th>");
                    out.println("<th>Correo</th>");
                    out.println("</tr>"); 
                    while (resultado.next()) {
                        out.println("<tr>");
                        out.println("<td>" + resultado.getString(1)+"</td>");
                        out.println("<td>"+ resultado.getString(2)+"</td>");
                        out.println("<td>"+resultado.getString(4)+"</td>");
                        out.println("<td>" + resultado.getString(3)+"</td>");
                        out.println("<td>" + resultado.getString(5) + "</td>");
                        out.println("<td>" + resultado.getString(6) + "</td>");
                        out.println("<td>"+ resultado.getString(7) + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("<h3>Mascotas:</h3>");
                    out.println("<table>");//Inicio de la tabla de mascotas registradas
                    out.println("<tr>");
                    out.println("<th>ID_Mascota</th>");
                    out.println("<th>Nombre</th>");
                    out.println("<th>Especie</th>");
                    out.println("<th>Raza</th>");
                    out.println("<th>Fecha Nacimiento</th>");
                    out.println("<th>Dueño</th>");
                    out.println("</tr>");
                    while (resultado2.next()) {
                        out.println("<tr>");
                        out.println("<td>" + resultado2.getString(1)+"</td>");
                        out.println("<td>" + resultado2.getString(2)+"</td>");
                        out.println("<td> " + resultado2.getString(3)+"</td>");
                        out.println("<td> " + resultado2.getString(4)+"</td>");
                        out.println("<td>" + resultado2.getString(5)+"</td>");
                        out.println("<td>" + resultado2.getString(6)+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("<h3>Bitacora</h3>");
                    out.println("<table>");//Inicio de la tabla bitácora
                    out.println("<tr>");
                    out.println("<th>ID_Bitacora</th>");
                    out.println("<th>Fecha y hora</th>");
                    out.println("<th>Tabla cambiada</th>");
                    out.println("<th>Acción realizada</th>");
                    out.println("</tr>");
                    while(resultado3.next()){
                        out.println("<tr>");
                        out.println("<td>"+resultado3.getString(1)+"</td>");
                        out.println("<td>"+resultado3.getString(2)+"</td>");
                        out.println("<td>"+resultado3.getString(3)+"</td>");
                        out.println("<td>"+resultado3.getString(4)+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("<h3>Servicios</h3>");
                    out.println("<table>");
                    out.println("<tr>");
                    out.println("<th>ID_servicio</th>");
                    out.println("<th>Nombre servicio</th>");
                    out.println("<th>Descripción</th>");
                    out.println("<th>Costo</th>");
                    out.println("</tr>");
                    while(resultado4.next()){
                        out.println("<tr>");
                        out.println("<td>"+resultado4.getString(1)+"</td>");
                        out.println("<td>"+resultado4.getString(2)+"</td>");
                        out.println("<td>"+resultado4.getString(3)+"</td>");
                        out.println("<td>"+resultado4.getString(4)+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                    out.println("<h3>Veterinarios</h3>");
                    out.println("<table>");
                    out.println("<tr>");
                    out.println("<th>ID_Veterinario</th>");
                    out.println("<th>Nombre</th>");
                    out.println("<th>Apellido</th>");
                    out.println("<th>Telefono</th>");
                    out.println("<th>Especialidad</th>");
                    out.println("<th>Hora de entrada</th>");
                    out.println("<th>Hora de salida</th>");
                    out.println("</tr>");
                    while(resultado5.next()){
                        out.println("<tr>");
                        out.println("<td>"+resultado5.getString(1)+"</td>");
                        out.println("<td>"+resultado5.getString(2)+"</td>");
                        out.println("<td>"+resultado5.getString(3)+"</td>");
                        out.println("<td>"+resultado5.getString(4)+"</td>");
                        out.println("<td>"+resultado5.getString(5)+"</td>");
                        out.println("<td>"+resultado5.getString(6)+"</td>");
                        out.println("<td>"+resultado5.getString(7)+"</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (java.sql.SQLException sqle) {
                    System.out.println("Error: " + sqle);
                    response.sendRedirect("./index.jsp");
                }
            %>
        </div>
        <!-- Form para hacer bajas de mascotas o de clientes -->
        <form action="bajasClientesOMascotas.jsp" id="cambios">
            <h3>Eliminar cliente</h3>
            <br>*No se puede eliminar clientes si tienen mascotas registradas*<br>
            Borrar cliente<input type="number" name="id_cliente" id="Cliente" onchange="validarIngreso()" placeholder="ID_Cliente">
            <h3>Eliminar mascota</h3>
            *Toma en cuenta la estructura de la BD antes de borrar algun elemento*<br>
            Borrar mascota<input type="number" name="id_mascota" id="Mascota" onchange="validarIngreso()" placeholder="ID_Mascota"><br>
            <br><input type="submit" value="Borrar" class="botonesSig" id="botonBajas" disabled="true">
        </form>
        <br>
        <!-- Form para agregar servicios para los clientes -->
        <form action="agregarServicios.jsp">
            <h3>Agregar servicios</h3>
            *Toma en cuenta la estructura antes de hacer algun cambio*<br>
            Nombre: <input type="text" placeholder="Vacunas" name="nombreServicio" id="nomS" required="" oninput="validarCaracteresServicio(value);"><br>
            Descripcion: <input type="text" placeholder="Aplicacion de vacunas" name="descripcionServ" id="desS" required=""><br>
            Costo: <input type="number" placeholder="120" name="costoServicio" id="cosS" required=""><br>
            <p id="mensajeSer"></p>
            <input type="submit" value="Agregar" class="botonesSig" id="botonCambio">
        </form>
        <!-- Form para agregar veterinarios dentro de la veterinaria -->
        <form action="altaVeterinarios.jsp">
            <h3>Agregar veterinarios</h3>
            *Toma en cuenta la estructura de la base de datos antes de hacer cambios*<br>
            Ingresa el nombre: <input type="text" placeholder="Alejandro" name="nombreVet" required="" oninput="validarCaracteres(value);"><br>
            Ingresa el apellido: <input type="text" placeholder="Martinez" name="apellidoVet" required="" oninput="validarCaracteres(value);"><br>
            Ingresa el telefono: <input type="number" placeholder="6681126496" name="telefonoVet" required=""><br>
            Ingresa la especialidad: <input type="text" placeholder="Dentista" name="especialidadVet" required=""><br>
            Ingresa la hora de entrada: <input type="time" name="horaEntrada" required=""><br>
            Ingresa la hora de salida: <input type="time" name="horaSalida" required=""><br>
            <p id="mensajeA"></p>
            <input type="submit" value="Agregar" class="botonesSig" id="btnAltas">
        </form>
        <form action="actualizarHorario.jsp">
            <h3>Cambiar horario de veterinario</h3>
            *Toma en cuenta la estructura de la base de datos antes de hacer cambios*
            Ingresa el ID del veterinario: <input type="number" name="idVet" required=""><br>
            Ingrese la nueva hora de entrada: <input type="time" name="nuevaEntrada" required=""><br>
            Ingrese la nueva hora de salida: <input type="time" name="nuevaSalida" required=""><br>
            <input type="submit" value="Cambiar" class="botonesSig" id="botonCambio">
        </form>
        <form action="bajaVeterinarios.jsp">
            <h3>Eliminar veterinario</h3>
            *Tome en cuenta la estructura de la base de datos antes de hacer cambios*<br>
            Ingrese el ID del veterinario: <input type="number" name="ID_Vet" placeholder="ID_Veterinario" required=""><br>
            <input type="submit" value="Eliminar" class="botonesSig">
        </form>
        <br><a href="./index.jsp" class="linkRef">Volver a inicio</a><br>
        <br>
    </body>
    <script>
            function validarIngreso(){
                let idCliente = document.getElementById('Cliente');
                let idMascota = document.getElementById('Mascota');
                let botonCambios = document.getElementById('botonBajas');
                let clienteValor = idCliente.value !== '';
                let mascotaValor = idMascota.value !== '';
                
                if (clienteValor ^ mascotaValor) {
                     botonCambios.disabled = false;
                }else{
                    botonCambios.disabled = true;
                    alert("Ingresa solo un valor");
                    idCliente.value='';
                    idMascota.value='';
                }
            }
            function validarCaracteres(input){
                //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
                let caracteres = /^[a-zA-Z ]+$/;
                let mensaje1 = document.getElementById("mensajeA");
                if(caracteres.test(input)){
                    mensaje1.innerHTML="";
                    enableButton();
                }else{
                    mensaje1.innerHTML="El valor ingresado es invalido";
                    disableButton();
                }
            }
            function enableButton() {
                const submitButton = document.getElementById("btnAltas");
                submitButton.disabled = false;
            }

            function disableButton() {
                const submitButton = document.getElementById("btnAltas");
                submitButton.disabled = true;
            }
            function validarCaracteresServicio(input){
                //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
                let caracteres = /^[a-zA-Z ]+$/;
                let mensaje1 = document.getElementById("mensajeSer");
                if(caracteres.test(input)){
                    mensaje1.innerHTML="";
                    enableButtonS();
                }else{
                    mensaje1.innerHTML="El valor ingresado es invalido";
                    disableButtonS();
                }
            }
            function enableButtonS() {
                const submitButton = document.getElementById("botonCambio");
                submitButton.disabled = false;
            }

            function disableButtonS() {
                const submitButton = document.getElementById("botonCambio");
                submitButton.disabled = true;
            }
    </script>
</html>
