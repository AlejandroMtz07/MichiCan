<%-- 
    Document   : veterinarios
    Created on : 24 may 2024, 13:55:22
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Veterinario</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css">
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body id="bodyVeterinarios">
        <h1>Veterinario</h1>
        <div> 
        <form action="veterinarioLogin.jsp">
            Ingrese su llave de acceso: <input type="number" name="IDVet" required=""><br>
            Ingrese su nombre: <input type="text" name="NombreVet" required=""><br>
            Ingrese su apellido: <input type="text" name="ApellidoVet" required=""><br>
            <input type="submit" value="Ingresar" class="botonesSig">
        </form>
        </div>
    </body>
</html>
