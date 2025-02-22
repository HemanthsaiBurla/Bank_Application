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
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <title>Update Profile</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
   body {
    font-family: 'Roboto', sans-serif;
    background-image: url('images/updateP.jpg');
    background-repeat: no-repeat;
    background-size: cover; /* Ensures the image covers the entire viewport */
    background-position: center; /* Centers the image */
    height: 100vh;
    width: 100%;
    
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    margin: 0;
    position: relative;
}

/* Adding 5px blur effect */
body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('images/updateP.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    filter: blur(5px); /* Apply blur effect */
    z-index: -1; /* Ensure it stays behind the content */
}

/* Container styling */
.container {
    background: white;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    max-width: 500px;
    width: 100%;
    position: relative;
    z-index: 1; /* Keeps it above the blurred background */
}


h1 {
    color: blue; /* Facebook blue */
    margin-bottom: 20px;
    font-size: 1.8rem;
}

label {
    font-size: 0.9rem;
    color: #606770; /* Lighter text for labels */
    display: block;
    margin-top: 15px;
}

input[type="text"], input[type="email"], input[type="password"] {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccd0d5; /* Light gray border */
    border-radius: 6px; /* Rounded corners */
    margin-top: 5px;
    font-size: 1rem;
    background: #f5f6f7; /* Subtle background */
    color: #1c1e21; /* Dark text color */
}

input:focus {
    outline: none;
    border-color: #4267B2; /* Highlight color */
    box-shadow: 0 0 3px #4267B2;
}

button {
    width: 100%;
    background-color: #4267B2; /* Facebook blue */
    color: white;
    padding: 12px;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s;
}

button:hover {
    background-color: #365899; /* Darker blue */
    transform: translateY(-2px);
}

button:active {
    transform: translateY(0);
}

.back-button {
    background-color: #42b72a; /* Green for secondary action */
    margin-top: 20px;
}

a {
    text-decoration: none;
    font-size: 0.9rem;
    color: #4267B2;
}

                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Update Profile</h1>
                    <form action="UpdateProfile" method="post">
                        <label for="name">Name:</label>
                        <input type="text" name="name" value="<%= rs.getString("name") %>" required><br>

                        <label for="email">Email:</label>
                        <input type="email" name="email" value="<%= rs.getString("email") %>" required><br>

                        <label for="password">Password:</label>
                        <input type="password" name="password" value="<%= rs.getString("pass") %>" required><br>

                        <label for="phno">Phone Number:</label>
                        <input type="text" name="phno" value="<%= rs.getString("phno") %>" required><br>

                        <label for="address">Address:</label>
                        <input type="text" name="address" value="<%= rs.getString("address") %>" required><br>

                        <label for="balance">Balance:</label>
                        <input type="text" name="balance" value="<%= rs.getString("balance") %>" required><br><br>

                        <button type="submit">Update</button>
                    </form>
                    <a href="Dashboard.jsp"><button class="back-button">Back to Dashboard</button></a>
                </div>
            </body>
            </html>
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
