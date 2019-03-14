<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Giudice Inserito</title>
    </head>
    <body>
     <% 
     if(request.getParameter("nome").isEmpty() || request.getParameter("cognome").isEmpty()){
      %>
       <h1>Non hai inserito nessun giudice</h1>
      <%
        return;
      } 
      %>

      <h1>Elenco dei giudici aggiornato <%= request.getParameter("nome") %> <%= request.getParameter("cognome") %></h1>
        <% 
            
            String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=barletta.nicolas;user=barletta.nicolas;password=xxx123#";
            
            try {

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            Connection connection = DriverManager.getConnection(connectionUrl);
            
            String nome = request.getParameter("nome");
            
            String cognome = request.getParameter("cognome");
            
            String luogo = request.getParameter("luogo");
            
            
            // selezione dell'ultimo ID
            
            Statement stmt1 = connection.createStatement();
            
            String sqlId = "Select Max(GiudiceID) as MaxId from Giudice";
            
            ResultSet rs1 = stmt1.executeQuery(sqlId);
            
            rs1.next();
            
            // calcolo nuovo ID
            
            int newId = rs1.getInt("MaxId") + 1;
            
            // inserimento del nuovo giudice
            
            String sql2 = "INSERT INTO Giudice (GiudiceID, Nome, Cognome, LuogoDiNascita) VALUES (?, ?, ?, ?)";
            
            PreparedStatement prepStmt = connection.prepareStatement(sql2);
            
            prepStmt.setInt(1, newId);
            
            prepStmt.setString(2, nome);
            
            prepStmt.setString(3, cognome);
            
            prepStmt.setString(4, luogo);
            
            prepStmt.executeUpdate();
            
            %>
            
            <p>Giudice inserito</p>
            
            <%
            
            connection.close();
            
        } catch (Exception e) {

            %>
            
            <p>Ci sono stati dei problemi, riprova</p>
            
            <%
            
        }
        
        %>
    </body>
</html>