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

    String query = "SELECT * FROM bank WHERE accno = ?";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

        ps = con.prepareStatement(query);
        ps.setString(1, accno);
        rs = ps.executeQuery();

        if (rs.next()) {
%>
            <div class="container">
                <!-- Circular photo here coming -->
                <div class="photo-container">
    <img src="images/ee.jpg" alt="User Photo">
</div>

                <!-- Circular photo ends here -->

                <h1>Welcome, <%= rs.getString("name") %>!</h1>
                <table class="profile-table">
                    <tr>
                        <th>Account Number</th>
                        <td><%= rs.getString("accno") %></td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td><%= rs.getString("name") %></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%= rs.getString("email") %></td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td><%= rs.getString("gender") %></td>
                    </tr>
                    <tr>
                        <th>Phone number</th>
                        <td><%= rs.getString("phno") %></td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td><%= rs.getString("address") %></td>
                    </tr>
                    <tr>
                        <th>Balance</th>
                        <td><%= rs.getString("balance") %></td>
                    </tr>
                </table>
                <!-- Buttons for actions -->
                <a href="Dashboard.jsp"><button class="back-button">Back to Dashboard</button></a>
                <a href="Update.jsp"><button class="back-button">Update Profile</button></a>
                <a href="Delete.jsp"><button class="delete-button">Delete Profile</button></a>
                <a href="TransferMoney.jsp"><button class="delete-button">Transfer Amount</button></a>
            </div>
<%
        } else {
            out.println("<h2 style='color:red;'>No profile found!</h2>");
        }
    } catch (Exception e) {
        out.println("<h2 style='color:red;'>Error occurred: " + e.getMessage() + "</h2>");
    } finally {
        if (con != null) con.close();
        if (ps != null) ps.close();
        if (rs != null) rs.close();
    }
%>

<style>
    body {
    font-family: Arial, sans-serif;
    background-image: url('images/basic.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-color: #f9f30f80; 
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    position: relative;
    margin: 0;
    padding: 0;
}

body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('images/basic.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    filter: blur(5px); /* Apply blur effect */
    z-index: -1; /* Ensure it stays behind content */
}

.container {
    width: 50%;
    margin: auto;
    padding: 20px;
    background-color: white;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-top: 30px;
    border-radius: 10px;
    text-align: center;
    position: relative;
    z-index: 1; /* Ensure it's above the blurred background */
}

.dark-container {
    background: rgba(0, 0, 0, 0.75);
    border-radius: 12px;
    padding: 50px 20px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
    max-width: 1000px;
    margin: auto;
    position: relative;
    z-index: 1; /* Keep it above the blur */
}


    .photo-container {
        margin: 20px auto;
        width: 150px;
        height: 150px;
        border-radius: 50%;
        overflow: hidden;
        border: 5px solid #007BFF;
    }

    .photo-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    h1 {
        color: blue;
        font-size: 2em;
        margin-bottom: 20px;
    }

    .profile-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        margin-bottom: 30px;
    }

    .profile-table th, .profile-table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }

    .profile-table th {
        background-color: #f8f8f8;
        color: black;
    }

    .profile-table td {
        background-color: #f9f9f9;
        color: #555;
    }

    .profile-table tr:nth-child(even) td {
        background-color: #f2f2f2;
    }

    button {
        padding: 10px 15px;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 1em;
    }

    .back-button {
        text-decoration: none;
        display: inline-block;
        margin-top: 20px;
        background-color: #28a745;
    }

    .back-button:hover {
        background-color: #218838;
    }

    .delete-button {
        background-color: #dc3545;
    }

    .delete-button:hover {
        background-color: #c82333;
    }
</style>
