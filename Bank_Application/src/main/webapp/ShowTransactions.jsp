<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
}


    .container {
        width: 65%;
        margin: auto;
        padding: 20px;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
        border-radius: 10px;
        text-align: center;
    }

    h2 {
        color: blue;
        font-size: 2em;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        margin-bottom: 30px;
    }

    table th, table td {
        border: 1px solid #ddd;
        padding: 12px;
        text-align: left;
    }

    table th {
        background-color: #f8f8f8;
        color: #333;
    }

    table td {
        background-color: #f9f9f9;
        color: #555;
    }

    table tr:nth-child(even) td {
        background-color: #f2f2f2;
    }

    button {
        padding: 10px 15px;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
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


<c:if test="${not empty error}">
    <div style="color: red;">
        <strong>${error}</strong>
    </div>
</c:if>

<div class="container">
<h2>Transaction History</h2>
<a href="Dashboard.jsp">
    <button style="background-color: #28a745; border-radius: 13px; color: white; 
                   font-size: 20px; padding: 10px 15px; position: fixed; 
                   top: 50%; left: 10px; transform: translateY(-50%);">
        Back to Dashboard
    </button>
</a>
    <table>
        <thead>
            <tr>
                <th>Sender Account(your's)</th>
                <th>Receiver Account</th>
                <th>Amount</th>
                <th>Transaction Type</th>
                <th>Transaction Date</th>
                <th>Transaction Status</th>
                
            </tr>
        </thead>
        <tbody>
            <c:forEach var="txn" items="${transactions}">
                <tr>
                    <td>${txn.senderAccno}</td>
                    <td>${txn.receiverAccno}</td>
                    <td><fmt:formatNumber value="${txn.amount}" type="currency" /></td>
                    <td>${txn.transactionType}</td>
                    <td><fmt:formatDate value="${txn.transactionDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td>${txn.transactionStatus}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="Dashboard.jsp"><button class="back-button">Back to Dashboard</button></a>
</div>
