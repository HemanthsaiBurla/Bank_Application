<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #050505;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('images/321.jpg');
            background-size: cover;
            background-position: center;
            filter: blur(5px); /* Apply 20% blur effect */
            z-index: -1; /* Keeps it behind the content */
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
            z-index: 1;
        }

        h2 {
            color: blue;
            margin-bottom: 20px;
            font-size: 2rem;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        label {
            display: block;
            font-size: 1.1rem;
            color: #333;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            background-color: #f5f5f5;
            margin-top: 8px;
        }

        button {
            background-color: #1877f2;
            color: white;
            padding: 14px;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
            border: none;
            width: 100%;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #166fe5;
        }

        .error {
            color: #f44336;
            font-size: 1rem;
            margin-top: 10px;
        }

        .new-user a {
            color: #1877f2;
            font-size: 1rem;
            text-decoration: none;
            margin-top: 20px;
            display: block;
        }

        .new-user a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Log in to HemanthBank</h2>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
        <form action="Login" method="POST">
            <div class="form-group">
                <label for="accno">Account Number</label>
                <input type="text" placeholder="Enter account number" id="accno" name="accno" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" placeholder="Password" id="password" name="pass" required>
            </div>
            <button type="submit">Log in</button>
        </form>
        <div class="new-user">
            <a href="Save.jsp">New account? Create one here</a>
        </div>
    </div>
</body>
</html>
