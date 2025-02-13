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
    PreparedStatement psDebit = null;
    ResultSet rsDebit = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hemanthbank", "root", "root");

        // Fetch Debit transactions (money sent)
        String debitQuery = "SELECT receiver_accno, amount, transaction_type, transaction_date FROM transactions WHERE sender_accno = ? AND transaction_status = 'Debit' ORDER BY transaction_date DESC";
        psDebit = con.prepareStatement(debitQuery);
        psDebit.setString(1, accno);
        rsDebit = psDebit.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Debit Transaction History</title>
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
}        h2 { color: white;
            text-align:center;
           }
        table { width: 60%; margin: auto; border-collapse: collapse; background: white; border-radius: 10px; box-shadow: 0px 0px 10px gray; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #28a745; color: white; }
        .debit { color: red; font-weight: bold; }
    </style>
</head>
<body>

    <h2>Your Debit Transaction History</h2>
    
    <a href="Dashboard.jsp">
    <button style="background-color: #28a745; border-radius: 13px; color: white; 
                   font-size: 20px; padding: 10px 15px; position: fixed; 
                   top: 50%; left: 10px; transform: translateY(-50%);">
        Back to Dashboard
    </button>
</a>

    <h2 style="color:yellow;">Debits (Money Sent)</h2>
    <table>
        <tr>
            <th>Receiver Account</th>
            <th>Amount</th>
            <th>Payment Type</th>
            <th>Date</th>
        </tr>
        <% while (rsDebit.next()) { %>
        <tr>
            <td><%= rsDebit.getString("receiver_accno") %></td>
            <td class="debit">- ₹<%= rsDebit.getDouble("amount") %></td>
            <td><%= rsDebit.getString("transaction_type") %></td>
            <td><%= rsDebit.getTimestamp("transaction_date") %></td>
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
            if (rsDebit != null) rsDebit.close();
            if (psDebit != null) psDebit.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
