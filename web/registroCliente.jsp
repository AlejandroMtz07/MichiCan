<%-- 
    Document   : login
    Created on : 15 may 2024, 20:12:50
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css">
        <link rel="icon" href="./img/favicon.png">
    </head>
    <%
        //Valor para la validación de remitente 
        String remitente = request.getHeader("referer");
        //Validación del remitente
        if(remitente==null||(!remitente.contains("http://localhost:8080/MichiCan/"))){
            response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
        }
    %>
    <body class="bodys" id="bodyRegistro">
            <h1>Ingresa tus datos:</h1>
            <form action="bienvenido.jsp" id="formRegistro">
                Ingresa tu nombre: <br><input type="text" required="" name="nombreUsuario" placeholder="Ej.Juanito" oninput="validarCaracteresNombre(value);">
                <p id="mensajeN" class="mensajeRegistro"></p>
                Ingresa tu apellido: <br><input type="text" required="" name="apellidoUsuario" placeholder="Ej.Martinez" oninput="validarCaracteresApellido(value)"><br>
                <p id="mensajeA" class="mensajeRegistro"></p>
                Ingresa tu sexo: <br><select name="sexoUsuario" required="required">
                    <option>Hombre</option>
                    <option>Mujer</option>
                    <option>Otro</option>
                </select><br>
                <br>Ingresa tu teléfono: <br><input type="text" required="" name="telefono" placeholder="Ej.66810000000" minlength="10" maxlength="10"><br>
                Ingresa tu correo: <br><input type="email" required="" name="correo" placeholder="Ej.user@gmail.com"><br>
                <br>Crea una contraseña: <br><input type="password" required="" name="contrasenia" placeholder="Ej.ju4n2307" oninput="validarCaracteresContrasenia(value)"><br>
                <p id="mensaje5" class="mensajeRegistro"></p>
                <input type="submit" value="Siguiente" class="botonesSig" id="btnRegistro" disabled="disabled"> 
                <%
                    String faltaAlgo = request.getParameter("Mensaje");
                    if (faltaAlgo != null)
                        out.println("<p class=mensajes" + ">" + faltaAlgo.replace("-", " ") + "</p>");
                %>
            </form>
            <br><a href="./index.jsp" class="linkRef">Regresar</a>
    </body>
    <script>
        function validarCaracteresNombre(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres = /^[a-zA-Z ]+$/;
            let mensaje1 = document.getElementById("mensajeN");
            if(caracteres.test(input)){
                mensaje1.innerHTML="";
                enableButton();
            }else{
                mensaje1.innerHTML="El valor ingresado es invalido";
                disableButton();
            }
        }
        function validarCaracteresApellido(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres = /^[a-zA-Z ]+$/;
            let mensaje1 = document.getElementById("mensajeA");
            let boton = document.getElementById("btnRegistro");
            if(caracteres.test(input)){
                mensaje1.innerHTML="";
                enableButton();
            }else{
                mensaje1.innerHTML="El valor ingresado es invalido";
                disableButton();
            }
        }
        function validarCaracteresContrasenia(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres =/^[a-zA-Z0-9]+$/;
            let mensaje1 = document.getElementById("mensaje5");
            let boton = document.getElementById("btnRegistro");
            if(caracteres.test(input)){
                mensaje1.innerHTML="";
                enableButton();
            }else{
                mensaje1.innerHTML="El valor ingresado es invalido";
                disableButton();
            }
        }
        function validarTelefono(telefono) {
            const longitud = telefono.length === 10;
            const regex = /^\d+$/;
            const areAllDigits = regex.test(telefono);
            const mensaje = document.getElementById("mensajeT");
            if (longitud && areAllDigits) {
              mensaje.textContent = "";
              enableButton();
            } else {
              mensaje.textContent = "El número de teléfono debe tener 10 dígitos";
              disableButton();
            }
        }
        function enableButton() {
            const submitButton = document.getElementById("btnRegistro");
            submitButton.disabled = false;
        }

        function disableButton() {
            const submitButton = document.getElementById("btnRegistro");
            submitButton.disabled = true;
        }
    </script>
</html>
