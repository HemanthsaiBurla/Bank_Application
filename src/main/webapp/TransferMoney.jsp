<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    session = request.getSession(false);
    String accno = (String) session.getAttribute("accno");

    if (accno == null) {
        out.println("<h2 style='color:red;'>Session expired. Please log in again.</h2>");
        out.println("<a href='Login.jsp'>Go to Login Page</a>");
        return;
    }

    // error message for wrong password
    String error = request.getParameter("error");
    String errorr = request.getParameter("errorr");
%>

<form action="TransferMoneyOperation" method="post">
    <h1>Transfer Money</h1>
    <label for="amount">Amount to Transfer:</label>
    <input type="number" name="amount" required><br><br>

    <label for="receiver_accno">Receiver's Account Number:</label>
    <input type="text" name="receiver_accno" required><br><br>

    <% if (errorr != null) { %>
        <p style="color:red;"><%= errorr %></p>
    <% } %>

    <label for="payment_type">Select Payment Type:</label>
    <select name="payment_type" required>
        <option value="Cash">Cash</option>
        <option value="UPI">UPI</option>
        <option value="Card">Card</option>
    </select><br><br>

    <label for="pin">Enter PIN:</label>
    <input type="password" name="pin" required><br><br>

    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <button type="submit">Transfer</button><br><br>
    <button type="button" onclick="window.location.href='Dashboard.jsp'">Back to Dashboard</button>
</form>

<br>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    height: 100%;
    margin: 0;
    padding: 0;	
    overflow: hidden; /* Hide scrollbar */
    display: flex;
    justify-content: center;
    align-items: center;
background-image: url('images/transfer.jpg');
    background-repeat: no-repeat;    background-size: cover;
    background-position: center;
    position: relative;
}



h1 {
    text-align: center;
    color: #007BFF;
    font-size: 2.5em;
    margin-top: 20px;
}

form {
    width: 100%; /* Adjust width to fit on smaller screens */
    max-width: 500px; /* Max width for larger screens */
    margin: 50px auto;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 30px;
    border-radius: 10px;
    position: relative;
    z-index: 1; /* Keeps form above blurred background */
}

label {
    font-size: 1em;
    font-weight: bold;
}

input[type="number"],
input[type="text"],
input[type="password"],
select {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    width: 100%;
    padding: 10px 15px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1em;
    margin-top: 10px;
}

button:hover {
    background-color: #218838;
}

button:last-child {
    background-color: #007BFF;
}

button:last-child:hover {
    background-color: #0056b3;
}

form button {
    width: 100%;
    margin-top: 10px;
}
</style>
