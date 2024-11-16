<%-- 
    Document   : cerrarSesion
    Created on : 4 jun 2024, 08:41:05
    Author     : aleja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String salirS = request.getParameter("salir");
            if(salirS!=null){
                request.getSession().invalidate();
                response.sendRedirect("http://localhost:8080/MichiCan/index.jsp");
            }
        %>
    </body>
</html>
