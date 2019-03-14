<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import = "java.io.*,java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>REGISTRAZIONE</title>
    </head>
    <body>
     <% 
            
            try {
                
            String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=barletta.nicolas;user=barletta.nicolas;password=xxx123#";

            // l'istruzione seguente è fondamentale altrimenti non viene caricato il driver

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Load SQL Server JDBC driver and establish connection.
            Connection connection = DriverManager.getConnection(connectionUrl);

            //inserimento di un nuovo giudice
            int utenti = 0;
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String sql = "SELECT COUNT(ID) as Utenti FROM Utente WHERE Username = ? AND Pw = ?";
            PreparedStatement prepStmt = connection.prepareStatement(sql);
            prepStmt.setString(1, username);
            prepStmt.setString(2, password);
            ResultSet rs = prepStmt.executeQuery();
            while(rs.next()){
                utenti = rs.getInt("utenti");
            } 
            rs.close();
            if(utenti == 0){ %>
            <h1>Username o password non corretti, ritenta</h1> <%
            } else {
                response.sendRedirect("../html/home.html");
                }
            connection.close();
            } catch(Exception e){
                out.println(e);
            } %>
    </body>
</html>