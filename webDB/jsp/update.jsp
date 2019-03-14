<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Aggiornamento data di nascita</title>
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
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String AnnoDiNascita = request.getParameter("AnnoDiNascita");
            String sql = "UPDATE Giudice SET AnnoDiNascita = ? WHERE Nome = ? AND Cognome = ?";
            PreparedStatement prepStmt = connection.prepareStatement(sql);
            prepStmt.setDate(1, java.sql.Date.valueOf(AnnoDiNascita)); 
            prepStmt.setString(2, nome);
            prepStmt.setString(3, cognome);
            prepStmt.executeUpdate();
            %>
            <h1>DATA CAMBIATA</h1>
            <%
            connection.close();
            } catch(Exception e){
                out.println(e);
            }
            %>
    </body>
</html>