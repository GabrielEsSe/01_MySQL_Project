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
                alert("Datos Actualizados Correctamente");
                return false;
            }
        </script>
    </head>
    <body>
        <%
            String boleta = (String) session.getAttribute("boleta");
            String nombre = request.getParameter("nombre");
            String especialidad = request.getParameter("especialidad");
            String idiomas_I = request.getParameter("idioma_uno");
            String idiomas_F = request.getParameter("idioma_dos");
            String idiomas_A = request.getParameter("idioma_tres");
            String turno = request.getParameter("turno");
            String beca = request.getParameter("beca");
            
            Connection con = null;
            Statement sta = null;
            
            if(boleta == null){
                out.println("No existe boleta en sesión");
                return;
            }
            
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://" + "localhost/base_uno?autoReconnect=true&useSSL=false", "root", "n0m3l0");
            } catch(SQLException error){
                out.print(error.toString());
                error.printStackTrace();
            }
            sta = con.createStatement();
            sta.executeUpdate("UPDATE registros SET "
                    + "nombre = '"+nombre+"', especialidad = '"+especialidad+"', turno = '"+turno+"', beca = '"+beca+"' WHERE boleta = '"+boleta+"'");
            sta.executeUpdate("DELETE FROM T_R_I WHERE id_boleta = '"+boleta+"'");
            if(idiomas_I != null){
                sta.executeUpdate("INSERT INTO T_R_I VALUES ('"+boleta+"', '"+idiomas_I+"')");
            }
            if(idiomas_F != null){
                sta.executeUpdate("INSERT INTO T_R_I VALUES ('"+boleta+"', '"+idiomas_F+"')");
            }
            if(idiomas_A != null){
                sta.executeUpdate("INSERT INTO T_R_I VALUES ('"+boleta+"', '"+idiomas_A+"')");
            }
            out.println("<script> mensaje(); </script>");
            con.close();
            sta.close();
        %>
        <a href="index.html" target="todos">regresar</a>
    </body>
</html>
