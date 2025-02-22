<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession sessionUser = request.getSession(false);
    String accno = (String) sessionUser.getAttribute("accno");

    if (accno == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement psCredit = null;
    ResultSet rsCredit = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hemanthbank", "root", "root");

        // Fetch Credit transactions (money received)
        String creditQuery = "SELECT sender_accno, amount, transaction_type, transaction_date FROM transactions WHERE receiver_accno = ? AND transaction_status = 'Debit' ORDER BY transaction_date DESC";
        psCredit = con.prepareStatement(creditQuery);
        psCredit.setString(1, accno);
        rsCredit = psCredit.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Credit Transaction History</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    min-height: 100vh; /* Ensures body expands with content */
    background-image: url('images/checkbal2.jpg');
    background-repeat: no-repeat;
    background-size: cover; /* Ensures it covers the entire screen */
    background-position: center;
    background-attachment: scroll; /* Moves with scroll */
}
        h2 { color: white; 
        text-align:center;
        }
        table { width: 60%; margin: auto; border-collapse: collapse; background: white; border-radius: 10px; box-shadow: 0px 0px 10px gray; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #28a745; color: white; }
        .credit { color: green; font-weight: bold; }
         
    </style>
</head>
<body>

    <h2>Your Credit Transaction History</h2>

<a href="Dashboard.jsp">
    <button style="background-color: #28a745; border-radius: 13px; color: white; 
                   font-size: 20px; padding: 10px 15px; position: fixed; 
                   top: 50%; left: 10px; transform: translateY(-50%);">
        Back to Dashboard
    </button>
</a>

    

    <h2 style="color:yellow;">Credits (Money Received)</h2>
    <table>
        <tr>
            <th>Sender Account</th>
            <th>Amount</th>
            <th>Payment Type</th>
            <th>Date</th>
        </tr>
        <% while (rsCredit.next()) { %>
        <tr>
            <td><%= rsCredit.getString("sender_accno") %></td>
            <td class="credit">+ ₹<%= rsCredit.getDouble("amount") %></td>
            <td><%= rsCredit.getString("transaction_type") %></td>
            <td><%= rsCredit.getTimestamp("transaction_date") %></td>
        </tr>
        <% } %>
        
        
    </table>
    

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rsCredit != null) rsCredit.close();
            if (psCredit != null) psCredit.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
