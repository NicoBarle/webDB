<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Giudice Eliminato</title>
    </head>
    <body>
     <% 
     if(request.getParameter("nome").isEmpty() || request.getParameter("cognome").isEmpty()){
      %>
       <h1>Non hai inserito nessun giudice</h1>
      <%
        return;
      } 
            
            String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=barletta.nicolas;user=barletta.nicolas;password=xxx123#";
            
            try {

            // l'istruzione seguente è fondamentale altrimenti non viene caricato il driver

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Load SQL Server JDBC driver and establish connection.
            Connection connection = DriverManager.getConnection(connectionUrl);

            //inserimento di un nuovo giudice
            String cognome = request.getParameter("cognome");
            String sql = "SELECT COUNT(GiudiceID) AS Numero FROM Giudice WHERE Cognome = ?";
            PreparedStatement prepStmt = connection.prepareStatement(sql);
            prepStmt.setString(1, cognome);
            ResultSet rs = prepStmt.executeQuery();
            int numero = 0;
            while (rs.next()) {
                numero = rs.getInt("Numero");
            }
            rs.close();
            if (numero == 0) {
                %>
                <p>Ci sono stati dei problemi, riprova</p>
                <%
            } else {
                String sql1 = "DELETE FROM Giudice WHERE cognome = ? ";
                PreparedStatement prepStmt1 = connection.prepareStatement(sql1);
                prepStmt1.setString(1, cognome);
                prepStmt1.executeUpdate();
                %>
                <p>Giudice eliminato</p>
                <%

            }
            connection.close();
        } catch (Exception e) {
            %>
            <p>Errore</p>
            <%
        }
        
        %>
    </body>
</html>