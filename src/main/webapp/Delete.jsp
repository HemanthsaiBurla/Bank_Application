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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Profile</title>
    <style>
        /* General Styling */
        body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-image: url('images/delete.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    min-height: 100vh;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

/* Adding blur effect */
body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('images/delete.jpg');
    background-size: cover;
    background-position: center;
    filter: blur(5px); /* Apply blur effect */
    z-index: -1; /* Send it behind content */
}

        .container {
            background: white;
            border-radius: 8px;
            padding: 30px 40px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            max-width: 500px;
            text-align: center;
        }

        h1 {
            font-size: 2rem;
            color: #1877f2;
            margin-bottom: 0px;
        }

        p {
            font-size: 1rem;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            display: block;
            text-align: left;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 8px;
            color: black;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        button {
            background-color: #1877f2;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: 0.3s ease;
        }

        button:hover {
            background-color: #155db9;
        }

        .delete-button {
            background-color: #e41e1e;
        }

        .delete-button:hover {
            background-color: #b31414;
        }

        a {
            color: #1877f2;
            text-decoration: none;
            display: inline-block;
            margin-top: 10px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Delete Profile</h1>
        <form action="DeleteProfile" method="post">
          <marquee>  <h3>Are you sure you want to delete your profile?</h3></marquee>
            
            <label for="name">Name:</label>
            <input type="text" name="name" value="<%= rs.getString("name") %>" disabled>
            
            <label for="email">Email:</label>
            <input type="email" name="email" value="<%= rs.getString("email") %>" disabled>
            
            <label for="phno">Phone Number:</label>
            <input type="text" name="phno" value="<%= rs.getString("phno") %>" disabled>
            
            <label for="address">Address:</label>
            <input type="text" name="address" value="<%= rs.getString("address") %>" disabled>
            
            <label for="balance">Balance:</label>
            <input type="text" name="balance" value="<%= rs.getString("balance") %>" disabled>
            
            <button type="submit" class="delete-button">Delete</button><br><br>
            
         
        
        </form>
        <a href="Dashboard.jsp"><button class="back-button">Back to Dashboard</button></a>
            <a href="Update.jsp"><button class="back-button">Update profile</button></a>
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
