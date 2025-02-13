<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('images/delete.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            color: #050505;
            min-height: 100vh;
            overflow: hidden; /* Hide unwanted scroll */
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
            overflow: auto; /* Ensures content fits inside */
        }

        button {
            padding: 10px 15px;
            color: white;
            background-color: #dc3545;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.2em;
        }

        button:hover {
            background-color: #c82333;
        }

        h1 {
            color: blue;
        }

        .back-link {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            font-size: 1.1em;
            color: #007bff;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Are you sure you want to logout?</h1>
        <form action="Logout" method="post">
            <button type="submit">Logout</button>
        </form>
        <br>
        <a href="Dashboard.jsp" class="back-link">Back to Dashboard?</a>
    </div>
</body>
</html>
