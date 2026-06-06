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
                alert("registro dado de alta");
                return false;
            }
        </script>
    </head>
    <body>
        <%
            String boleta = request.getParameter("boleta");
            String nombre = request.getParameter("nombre");
            String especialidad = request.getParameter("especialidad");
            String[] idiomas = request.getParameterValues("idioma");
            String turno = request.getParameter("turno");
            String beca = request.getParameter("beca");
            
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
            sta.executeUpdate("INSERT INTO registros VALUES ('"+boleta+"', '"+nombre+"', '"+especialidad+"', '"+turno+"', '"+beca+"')");
            if(idiomas != null){
                for(String idioma : idiomas){
                    sta.executeUpdate(
                            "INSERT INTO T_R_I VALUES ('"+boleta+"', '"+idioma+"')");
                }
            }
            out.println("<script> mensaje(); </script>");
            con.close();
            sta.close();
        %>
        <a href="index.html" target="todos">regresar</a>
    </body>
</html>
