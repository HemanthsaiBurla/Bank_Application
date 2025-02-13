<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

      body {
    font-family: 'Arial', sans-serif;
    background-image: url('images/321.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    text-align: center;
    position: relative;
    margin: 0;
}

/* Adding 5px blur effect */
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
    background-repeat: no-repeat;
    filter: blur(5px); /* Apply blur effect */
    z-index: -1; /* Send it behind content */
}

/* Container styling */
.container {
    background: rgba(0, 0, 0, 0.75);
    border-radius: 12px;
    padding: 50px 20px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
    max-width: 1000px;
    margin: auto;
    position: relative;
    z-index: 1; /* Ensure it appears above the blurred background */
}


        h1 {
            font-size: 3rem;
            color: white; /* Blue for headings */
            animation: bounceIn 2s ease forwards;
        }
        h4{
        color:white;
        }

        h3 {
            font-size: 1.8rem;
            margin: 20px 0;
            color: white; /* Blue for subheadings */
            animation: bounceIn 2s ease forwards 1s;
        }

        .buttons-container {
            margin-top: 50px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center; /* Aligns buttons horizontally */
            gap: 15px; /* Adds space between buttons */
        }

        a {
            text-decoration: none;
        }

        button {
            background-color: #28a745; /* Green default */
            color: white;
            padding: 15px 35px;
            border-radius: 25px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.4s ease;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        /* Red buttons for Delete and Transfer Money */
        button.delete, button.transfer {
            background-color: red; /* Red for important actions */
        }

        button:hover {
            background-color: blue; 
            transform: scale(1.1);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        button.delete:hover, button.transfer:hover {
            background-color: orange; 
        }

        button:active {
            transform: scale(1);
        }

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            60% {
                opacity: 1;
                transform: translateY(10px);
            }
            100% {
                transform: translateY(0);
            }
        }

    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to HemanthBank</h1>
        <h3>Plan Today for a Richer Tomorrow.!</h3>
        <h4>We Make Your Wallet Fat, Not You!</h4>

        <div class="buttons-container">
            <a href="Update.jsp"><button>Update Profile</button></a>
            <a href="Delete.jsp"><button class="delete">Delete Profile</button></a>
            <a href="Profile.jsp"><button>My Profile</button></a>
            <a href="CheckBalance.jsp"><button>Check Balance</button></a>
            <a href="TransferMoney.jsp"><button class="transfer">Transfer Money</button></a>
            <a href="ShowTransactions"><button>All Transactions</button></a>
            <a href="ViewCredits.jsp"><button>View Credits</button></a>
            <a href="ViewDebts.jsp"><button>View Debits</button></a>
            <a href="Logout.jsp"><button>Logout</button></a>
        </div>
    </div>
</body>


</html>
