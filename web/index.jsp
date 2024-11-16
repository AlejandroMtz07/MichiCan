<%--
    Document   : index
    Created on : 15 may 2024, 19:14:44
    Author     : aleja
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MichiCan</title>
        <link rel="stylesheet" href="./MichiCanEstiloss.css">
        <link rel="icon" href="./img/favicon.png">
    </head>
    <body class="bodys" id="bodyInicio">
        <h1 id="cartelInicio">¡Bienvenido a MichiCan!</h1><br> 
        <form action="primera.jsp" id="formInicio">   
            <h3>Inicio de sesion</h3>
            Ingresa tu ID<br><input type="number" placeholder="Ej.1111" name="ID" required="reqquired" id="IDIngresada"><br>
            Ingresa tu contraseña<input type="password" placeholder="Ej.Ju4n2307" name="contra" required="" id="contraIngresada" oninput="validarCaracteres(value);"><br>
            <p id="mensajeCaracteres"></p>
            <input type="submit" value="Siguiente" class="botonesSig" id="btnSiguiente" disabled="disabled" oninput="validarCaracteres(value);">
            <p class="mensajes">¿Aún no tienes una cuenta? <a href="registroCliente.jsp">Registrate.</a></p>
            <%
                String faltaAlgo = request.getParameter("Mensaje");
                if (faltaAlgo != null){
                    out.println("<script>alert('"+faltaAlgo+"')</script>");
                }
            %>
        </form>
        <h2>Nuestros servicios</h2>
        <div id="divServicios"> 
            <button class="btnServicios" id="img1">Esterilización</button>
            <button class="btnServicios" id="img2">Vacunación</button>
            <button class="btnServicios" id="img3">Internación</button>
            <button class="btnServicios" id="img4">Baños</button>
            <button class="btnServicios" id="img5">Cortes de pelo</button>
            <button class="btnServicios" id="img6">Corte de uñas</button>
            <button class="btnServicios" id="img7">Cirugía</button>
            <button class="btnServicios" id="img8">Radiografías</button>  
        </div>
        <div id="divImagenes">
            <img src="./img/esterilizacion.jpg" width="300px" height="300px" id="ima1" hidden/>
            <img src="./img/vacuna.jpg" width="300px" height="300px" id="ima2" hidden/>
            <img src="./img/internacion.jpg" width="300px" height="300px" id="ima3" hidden/>
            <img src="./img/banio.jpg" width="300px" height="300px" id="ima4" hidden/>
            <img src="./img/cortePelo.jpg" width="300px" height="300px" id="ima5" hidden/>
            <img src="./img/corteUnias.jpg" width="300px" height="300px" id="ima6" hidden/>
            <img src="./img/cirugia.jpg" width="300px" height="300px" id="ima7" hidden/>
            <img src="./img/rayosx.jpg" width="300px" height="300px" id="ima8" hidden/>
        </div>
        <h2>Donde nos ubicamos</h2>
        <br>
        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2491.60004028791!2d-108.9764843580481!3d25.79840343011065!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x86ba2f4a274d561b%3A0x5b99f7fbf3674e8!2sInstituto%20Tecnol%C3%B3gico%20de%20Los%20Mochis.%20Departamento%20de%20Mantenimiento%20y%20Equipo!5e0!3m2!1ses!2smx!4v1716154397436!5m2!1ses!2smx" 
            width="600" height="450" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">      
        </iframe>
        <footer>
            <p>¡Contáctanos!</p>
            <a class="botonFooter" href="https://wa.me/+526681628419" target="_blank">WhatsApp</a><br>
            <br><a class="botonFooter" href="https://www.facebook.com/profile.php?id=100069358025762" target="_blank">Facebook</a>
        </footer> 
    </body>
    <script>
        function mostrarAlerta(){
            let ale = document.getElementById("alerta");
            if(!ale.equals("")){
                alert("usuario no registrado");
            }
        }
        function validarCaracteres(input){
            //Agregar los caracteres permitidos y condicionarlos cuando se ingrese algún valor dentro de los input 
            let caracteres =/^[a-zA-Z0-9]+$/;
            let mensaje = document.getElementById("mensajeCaracteres");
            let boton = document.getElementById("btnSiguiente");
            if(caracteres.test(input)){
                mensaje.innerHTML="";
                boton.removeAttribute("disabled","");
            }else{
                mensaje.innerHTML="El valor ingresado es invalido";
                boton.setAttribute("disabled","disabled");
            }
        }
        function mostrarImagen(idImagen) {
            const imagen = document.getElementById(idImagen);
            imagen.removeAttribute('hidden');
            const imagenes = document.querySelectorAll('#divImagenes img');
            imagenes.forEach(function(img) {
            if (img.id !== idImagen) {
              img.setAttribute('hidden', '');
            }
          });
        }
        const boton1 = document.getElementById('img1');
        boton1.addEventListener('click', function() { mostrarImagen('ima1'); });
        const boton2 = document.getElementById('img2');
        boton2.addEventListener('click', function() { mostrarImagen('ima2'); });
        const boton3 = document.getElementById('img3');
        boton3.addEventListener('click', function() { mostrarImagen('ima3'); });
        const boton4 = document.getElementById('img4');
        boton4.addEventListener('click', function() { mostrarImagen('ima4'); });
        const boton5 = document.getElementById('img5');
        boton5.addEventListener('click', function() { mostrarImagen('ima5'); });
        const boton6 = document.getElementById('img6');
        boton6.addEventListener('click', function() { mostrarImagen('ima6'); });
        const boton7 = document.getElementById('img7');
        boton7.addEventListener('click', function() { mostrarImagen('ima7'); });
        const boton8 = document.getElementById('img8');
        boton8.addEventListener('click', function() { mostrarImagen('ima8'); });
        
    </script>
</html>
