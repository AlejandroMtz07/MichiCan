<%-- 
    Document   : registroMascota
    Created on : 16 may 2024, 13:11:08
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registra a tu mascota</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css">
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyRegistroMascota" onsubmit="return validarFecha()"> 
        <h1>Registre a su mascotita</h1>
        <form id="formRegistroMascota" action="insertarMascota.jsp"> 
            Ingrese el nombre: <br><input type="text" placeholder="Ej.Canelo" name="nombreMascota" required="required" id="nombreMascota" oninput="validarCaracteresNombre(value);"><br>
            <p id="mensajeCaracteres1" class="mensajes"></p>
            Ingrese la especie: <br><input type="text" placeholder="Ej.Perro" name="especieMascota" required="required" id="especieMascota" oninput="validarCaracteresEspecie(value);"><br>
            <p id="mensajeCaracteres2" class="mensajes"></p>
            Ingrese la raza: <br><input type="text" placeholder="Ej.Labrador" name="razaMascota" required="required" id="razaMascota" oninput="validarCaracteresRaza(value);"><br>
            <p id="mensajeCaracteres3" class="mensajes"></p>
            <label for="nacimientoMascota">Fecha de nacimiento:</label><br><input type="date" name="nacimientoMascota" required="required" id="nacimientoMascota" min="1990-12-31" max="2024-12-31"><br>
            <input type="submit" value="¡Registrar!" class="botonesSig" id="btnSiguiente" disabled="disabled">
        </form>
        <br><a href="http://localhost:8080/MichiCan/primera.jsp?ID=${ID}&contra=${contra}" class="linkRef">Regresar</a>
    </body>
    <%
        //Valor para validación de remitente
        String remitente = request.getHeader("referer");
        //Validación del remitente
        if(remitente==null||(!remitente.contains("http://localhost:8080/MichiCan/"))){
            response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
        }
    %>
    <script>
        function validarCaracteresNombre(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres =/^[a-zA-Z0-9]+$/;
            let mensaje1 = document.getElementById("mensajeCaracteres1");
            let boton = document.getElementById("btnSiguiente");
            if(caracteres.test(input)){
                mensaje1.innerHTML="";
                boton.removeAttribute("disabled","");
            }else{
                mensaje1.innerHTML="El valor ingresado es invalido";
                boton.setAttribute("disabled","disabled");
            }
        }
        function validarCaracteresEspecie(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres =/^[a-zA-Z0-9]+$/;
            let mensaje1 = document.getElementById("mensajeCaracteres2");
            let boton = document.getElementById("btnSiguiente");
            if(caracteres.test(input)){
                mensaje1.innerHTML="";
                boton.removeAttribute("disabled","");
            }else{
                mensaje1.innerHTML="El valor ingresado es invalido";
                boton.setAttribute("disabled","disabled");
            }
        }
        function validarCaracteresRaza(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres =/^[a-zA-Z0-9]+$/;
            let mensaje1 = document.getElementById("mensajeCaracteres3");
            let boton = document.getElementById("btnSiguiente");
            if(caracteres.test(input)){
                mensaje1.innerHTML="";
                boton.removeAttribute("disabled","");
            }else{
                mensaje1.innerHTML="El valor ingresado es invalido";
                boton.setAttribute("disabled","disabled");
            }
        }
        function validarFecha(){
            const fechaInput = document.getElementById("nacimientoMascota");
            const fechaSeleccionada = new Date(fechaInput.value);
            const fechaActual = new Date();
            fechaActual.setHours(0,0,0,0);
            if(fechaSeleccionada>fechaActual){
                alert("La fecha no puede ser mayor al día de hoy");
                fechaInput.value="";
                return false;
            }
            return true;
        }
    </script>
</html>
