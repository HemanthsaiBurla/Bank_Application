<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <style>
        body {
    font-family: 'Arial', sans-serif;
    background-image: url('images/321.jpg');
    background-repeat: no-repeat;
    background-size: cover; 
    background-position: center;
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}
 /* Adding 20% blur effect on the background */
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
    width: 100%;
    max-width: 600px;
    background-color: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    position: relative;
    z-index: 2; /* Ensure container stays above the blurred background */
    height: auto;
}
        

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: blue;
        }

        /* Form styling for horizontal layout */
        form {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        label {
            width: 40%;
            font-size: 1rem;
            color: #333;
            margin-right: 10px;
            text-align: left;
        }

        input, select {
            width: 55%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            color: #333;
            background-color: #f5f5f5;
        }

        button {
            background-color: #1877f2;
            color: white;
            padding: 12px;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button:hover {
            background-color: #166fe5;
        }

        .error-message {
            color: #f44336;
            font-weight: bold;
            margin-top: 10px;
            text-align: center;
        }

        /* Ensures the link appears inside the container */
        a {
            text-align: center;
            color: #1877f2;
            font-size: 0.9rem;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 15px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>User Registration</h1>
        <!-- Display error message if it exists -->
        <% String errorMessage = (String) request.getAttribute("errorMessage"); 
           if (errorMessage != null) { %>
            <div class="error-message"><%= errorMessage %></div>
        <% } %>
        <form action="save" method="POST">
            <div class="form-group">
                <label for="accno">Account Number</label>
                <input type="text" id="accno" name="accno" placeholder="Enter your account number" required>
            </div>
            
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email address" required>
            </div>
            
            <div class="form-group">
                <label for="pass">Password</label>
                <input type="password" id="pass" name="pass" placeholder="Enter a secure password" required>
            </div>
            
            <div class="form-group">
                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="phno">Phone Number</label>
                <input type="text" id="phno" name="phno" placeholder="Enter your phone number" required>
            </div>
            
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Enter your address" required>
            </div>
            
            <div class="form-group">
                <label for="balance">Initial Balance</label>
                <input type="text" id="balance" name="balance" placeholder="Enter your initial balance" required>
            </div>
            
            <button type="submit">Register</button><br>
            <a href="Login.jsp">Already have an account?</a>
        </form>
    </div>
</body>

</html>
