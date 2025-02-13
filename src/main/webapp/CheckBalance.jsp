<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Check Balance</title>
    <style>
        /* Ensure full height of the page */
       html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}

body { 
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    background-image: url('images/checkbal2.jpg');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    color: #050505;
    min-height: 100vh;
}


        
        .container {
            background: #ffffff;
            border-radius: 12px;
            padding: 40px 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
            position: relative;
        }

        h1 {
            color: blue;
            margin-bottom: 20px;
        }

        form {
            margin: 20px 0;
        }

        input[type="password"], button {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            background-color: #28a745;
            color: white;
            font-weight: bold;
            border-radius: 10px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            margin: 15px 0;
        }

        .success {
            color: green;
            margin: 15px 0;
        }

        /* Styling the 'Back to Dashboard' link to look like a button */
        .back-btn {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 10px;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Check Balance</h1>
        <%
            // Retrieve error and balance attributes from the request scope
            String error = (String) request.getAttribute("error");
            String balance = (String) request.getAttribute("balance");

            if (error != null) {
        %>
                <div><h2 class="error"><%= error %></h2></div>
        <%
            }
            if (balance != null) {
        %>
                <div><h1 class="success">Your balance is: ₹<%= balance %></h1></div>
        <%
            }
        %>
        <form action="CheckBalance" method="post">
            <input type="password" name="pass" placeholder="Enter your password" required />
            <button type="submit">Check Balance</button>
        </form>
        <a href="Dashboard.jsp" class="back-btn">Back to Dashboard</a>
    </div>
</body>
</html>
