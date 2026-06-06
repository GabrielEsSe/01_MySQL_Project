<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Consultas</title>
    </head>
    <body>

        <h1 align="center">Consultas</h1>

        <%
            String boletaBuscar = request.getParameter("boleta");

            Connection con = null;
            Statement sta = null;
            ResultSet resultSet = null;

            try{

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost/base_uno?autoReconnect=true&useSSL=false",
                    "root",
                    "n0m3l0"
                );

                sta = con.createStatement();

                String sql = "SELECT * FROM registros WHERE boleta = '"+boletaBuscar+"'";

                resultSet = sta.executeQuery(sql);
        %>

        <table border="1" width="70%" cellpadding="5" cellspacing="0" align="center">

            <tr>
                <th>Boleta</th>
                <th>Nombre</th>
                <th>Especialidad</th>
                <th>Turno</th>
                <th>Beca</th>
            </tr>

            <%
                while(resultSet.next()){

                    String boleta = resultSet.getString("boleta");
                    String nombre = resultSet.getString("nombre");
                    String especialidad = resultSet.getString("especialidad");
                    String turno = resultSet.getString("turno");
                    String beca = resultSet.getString("beca");
            %>

            <tr>
                <td><%= boleta %></td>
                <td><%= nombre %></td>
                <td><%= especialidad %></td>
                <td><%= turno %></td>
                <td><%= beca %></td>
            </tr>

            <%
                }
            %>

        </table>

        <%
                resultSet.close();
                sta.close();
                con.close();

            } catch(Exception error){

                out.println(error.toString());
            }
        %>

        <br><br>

        <center>
            <a href="consultas.html">Regresar</a>
        </center>

    </body>
</html>