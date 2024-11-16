<%-- 
    Document   : administrador
    Created on : 18 may 2024, 13:51:36
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>¿Trabajando duro?</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css"/>
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body class="bodys" id="bodyAdmin">
        <br><h1 id="h1Admin">Ingrese sus credenciales:</h1>
        <form action="loginAdministrador.jsp" id="formAdmin">
            <br>Ingresa tu usuario: <br><input type="text" name="nombreUsuario" required="required">
            <br>Ingresa tu contraseña de acceso:<br><input type="password" name="contraUsuario"required="required">
            <br><input type="submit" value="Ingresa" class="botonesSig">
        </form>
        <br><a href="./index.jsp" class="linkRef" id="botonRegreso">Volver</a> 
    </body>
</html>
