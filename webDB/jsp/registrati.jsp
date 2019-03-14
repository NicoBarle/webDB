<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*,java.text.*"%>
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
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            Statement stmt = connection.createStatement();
            String sql = "SELECT Max(ID) as MaxID FROM Utente";
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            int newID = rs.getInt("MaxID") + 1;
            String sql2 = "INSERT INTO Utente (ID, Nome, Cognome, Username, Email, Pw) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement prepStmt2 = connection.prepareStatement(sql2);
            prepStmt2.setInt(1, newID);
            prepStmt2.setString(2, nome); 
            prepStmt2.setString(3, cognome);
            prepStmt2.setString(4, username);
            prepStmt2.setString(5, email);
            prepStmt2.setString(6, password);
            prepStmt2.executeUpdate();
            %>
            <h1>SEI STATO REGISTRATO</h1>
            <p>Clicca <a href=/html/home.html>qui</a> per andare alla home</p>
            <%
            connection.close();
            } catch(Exception e){
                out.println(e);
            }
            %>
    </body>
</html>