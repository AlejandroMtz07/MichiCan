<%-- 
    Document   : primera
    Created on : 15 may 2024, 19:21:48
    Author     : aleja
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    </head>
    <%
        //Obtener fecha
        HttpSession sesion = request.getSession();
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");
        String fecha = df.format(date);
        //Valor para validación de remitente
        String remitente = request.getHeader("referer");
        //Validación del remitente
        if (remitente == null || (!remitente.contains("http://localhost:8080/MichiCan/"))) {
            response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
        }
        //Valores para inicio de sesion
        String id = request.getParameter("ID");
        int idC = Integer.parseInt(id);
        String contrasenia = request.getParameter("contra");
        //Instancia de sesion para implementación de cookies
        
        //Creación de cookies
        
        sesion.setAttribute("ID", id);
        sesion.setAttribute("contra", contrasenia);
        //Creación de la consulta para la base de datos para ingreso de usuario
        String nombre = "";
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
            PreparedStatement materias = connection.prepareStatement("select (Nombre) from Cliente where (ID_Cliente,Contraseña)=(?,?);");
            materias.setInt(1, idC);
            materias.setString(2, contrasenia);
            ResultSet resultado = materias.executeQuery();
            if (resultado.next()) {
                nombre = (resultado.getString(1));
            } else {
                response.sendRedirect("http://localhost:8080/MichiCan/index.jsp?Mensaje=Usuario-no-registrado-o-contrasena-incorrecta.");
            }
        } catch (java.sql.SQLException sqle) {
            System.out.println("Error: " + sqle);
        }
        
    %>
    <body class="bodys" id="bodyLogin">
        <h1 id="mensajeInicio">Bienvenido de nuevo: <%out.println(nombre+".");%></h1>
        <div id="mascotasUsuario">
            <h3>Estas son tus mascotas:</h3>
            <%
                List<String> ids = new ArrayList();
                List<String> cumples = new ArrayList();
                String botonHistorial = "";
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
                    PreparedStatement materias = connection.prepareStatement("select *from Mascota where ID_Cliente=?;");
                    materias.setInt(1, idC);
                    ResultSet resultado = materias.executeQuery();
                    while (resultado.next()) {
                        out.println("<br>ID de la mascota: " + resultado.getString(1));
                        ids.add(resultado.getString(1));
                        out.println("<br>   Nombre: " + resultado.getString(2));
                        out.println("<br>Especie: " + resultado.getString(3));
                        out.println("<br>Raza: " + resultado.getString(4));
                        out.println("<br>Fecha de nacimiento: " + resultado.getString(5).replace("-", "/") + "<br>");
                        cumples.add(resultado.getString(5).replace("-", "/"));
                    }
                } catch (java.sql.SQLException sqle) {
                    System.out.println("Error: " + sqle);
                }
                if (ids.isEmpty()) {
                    out.println("<p style=color:blue><strong>*Debes de agregar mascotas primero para ver tu historial y agendar citas.*</strong></p>");
                } else {
                    botonHistorial = "<br><button class=botonesSig id=botonM>Historiales</button>";
                }
                out.print(botonHistorial+"&nbsp;&nbsp;<button class=botonesSig onclick=downloadPDF();>Descargar</button><br>");
            %>
            <br>
            <div id="formServicio" hidden>
                <br>Aqui dentro encontrarás el historial de los tratamientos de tu mascota a lo largo de su estadía en MichiCan:<br>
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
                        out.println("<h3>Historial</h3>");
                        out.println("<table>");
                        out.println("<tr>");
                        out.println("<th>ID_Servicio</th>");
                        out.println("<th>Fecha</th>");
                        out.println("<th>Servicio</th>");
                        out.println("<th>Descripcion</th>");
                        out.println("<th>ID_Mascota</th>");
                        out.println("</tr>");
                        for(String idM : ids){
                            int idMas = Integer.parseInt(idM);
                            PreparedStatement materias = connection.prepareStatement("select *from Historial where ID_Mascota=?;");
                            materias.setInt(1, idMas);
                            ResultSet resultado = materias.executeQuery();
                            while (resultado.next()) {
                            out.println("<tr>");
                            out.println("<td>"+resultado.getString(1)+"</td>");
                            out.println("<td>"+resultado.getString(2)+"</td>");
                            out.println("<td>"+resultado.getString(3)+"</td>");
                            out.println("<td>"+resultado.getString(4)+"</td>");
                            out.println("<td>"+resultado.getString(5)+"</td>");
                            out.println("</tr>");
                        }
                        }
                        
                        out.println("</table>");
                    } catch (java.sql.SQLException sqle) {
                        System.out.println("Error: " + sqle); 
                    }
                %>
                
            </div>
            
                <%
                    for (String fechaS : cumples) {
                        if (fechaS.equals(fecha)) {
                            out.println("<p id=felicitacion>¡Felicitamos a tu mascotita por ser su cumpleaños!<br>"
                            + "Presenta una captura de este mensaje para recibir un regalo en la veterinaria."+fecha+"</p>");
                        }
                    }
                %>
        </div>
        <a href="Salir" class="linkRef">Cerrar sesion</a>&nbsp;&nbsp;
        <a href="./registroMascota.jsp" class="linkRef">Registra tu mascota</a>&nbsp;&nbsp;
        <button class="botonesSig" id="btnHorarios">Horarios</button>&nbsp;&nbsp;
        <div id="horarios" hidden>
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
                    PreparedStatement materias = connection.prepareStatement("select *from Veterinario");
                    ResultSet resultado = materias.executeQuery();
                    out.println("<h3>Horarios</h3>");
                    out.println("<table>");
                    out.println("<tr>");
                    out.println("<th>Nombre</th>");
                    out.println("<th>Teléfono</th>");
                    out.println("<th>Especialidad</th>");
                    out.println("<th>Horario entrada</th>");
                    out.println("<th>Horario salida</th>");
                    out.println("</tr>");
                    while (resultado.next()) {
                        out.println("<tr>");
                        out.println("<td>" + resultado.getString(2) + "</td>");
                        out.println("<td>" + resultado.getString(4) + "</td>");
                        out.println("<td>" + resultado.getString(5) + "</td>");
                        out.println("<td>" + resultado.getString(6) + " a.m.</td>");
                        out.println("<td>" + resultado.getString(7) + " p.m.</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (java.sql.SQLException sqle) {
                    System.out.println("Error: " + sqle);
                }
            %>
        </div>
        <br>
        <br>
    </body>
    <script>
        function mostrarFormHistorial(){
            const form = document.getElementById('formServicio');
            const botonM = document.getElementById('botonM');
            if(form.hidden){
                form.removeAttribute('hidden');
                botonM.textContent='Ocultar';
            }else{
                form.setAttribute('hidden','');
                botonM.textContent='Historiales';
            }
        }
        function mostrarFormHorarios(){
            const form = document.getElementById('horarios');
            const botonM = document.getElementById('btnHorarios');
            if(form.hidden){
                form.removeAttribute('hidden');
                botonM.textContent='Horarios';
            }else{
                form.setAttribute('hidden','');
                botonM.textContent='Horarios';
            }
        }
        const botonH = document.getElementById('botonM');
        botonH.addEventListener('click', mostrarFormHistorial);
        
        const botonHorarios = document.getElementById('btnHorarios');
        botonHorarios.addEventListener('click', mostrarFormHorarios);
        async function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const historial = document.getElementById('formServicio');

            // Capturar el contenido del ticket como una imagen
            const canvas = await html2canvas(historial);
            const imgData = canvas.toDataURL('image/png');

            // Calcular las dimensiones del PDF basadas en el contenido del ticket
            const pdfWidth = historial.offsetWidth;
            const pdfHeight = historial.offsetHeight;

            // Crear un nuevo documento PDF
            const pdf = new jsPDF({
                orientation: 'portrait',
                unit: 'px',
                format: [pdfWidth + 90, pdfHeight + 200] // Aumentamos un poco la altura para asegurar que quepa todo el contenido
            });
            // Agregar la imagen del ticket al PDF
            pdf.addImage(imgData, 'PNG', 28, 7, pdfWidth, pdfHeight);

            // Descargar el PDF
            pdf.save('historial.pdf');
        }
    </script>
</html>
