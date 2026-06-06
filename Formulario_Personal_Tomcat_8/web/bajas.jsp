<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function mensaje(){
                alert("Alumno dado de baja correctamente");
                return false;
            }
        </script>
    </head>
    <body>
        <%
            String boleta = request.getParameter("boleta");
            
            Connection con = null;
            Statement sta = null;
            
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://" + "localhost/base_uno?autoReconnect=true&useSSL=false", "root", "n0m3l0");
            } catch(SQLException error){
                out.print(error.toString());
                error.printStackTrace();
            }
            sta = con.createStatement();
            sta.executeUpdate("DELETE FROM T_R_I WHERE id_boleta = ('"+boleta+"')");
            sta.executeUpdate("DELETE FROM registros WHERE boleta = ('"+boleta+"')");
            out.println("<script> mensaje(); </script>");
            con.close();
            sta.close();
        %>
        <a href="index.html" target="todos">regresar</a>
    </body>
</html>
