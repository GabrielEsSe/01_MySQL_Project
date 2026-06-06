<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String boleta = request.getParameter("boleta");
            session.setAttribute("boleta", boleta);
        %>
        <a href="menu_cambios.html" target="todos">Actualizar</a>
    </body>
</html>
