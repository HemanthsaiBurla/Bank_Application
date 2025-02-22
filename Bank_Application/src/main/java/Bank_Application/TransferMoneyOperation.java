package Bank_Application;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TransferMoneyOperation")
public class TransferMoneyOperation extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String senderAccno = (String) session.getAttribute("accno");

        if (senderAccno == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        String amountStr = req.getParameter("amount");
        String receiverAccno = req.getParameter("receiver_accno");
        String enteredPin = req.getParameter("pin");
        String paymentType = req.getParameter("payment_type"); 

        if (amountStr == null || receiverAccno == null || enteredPin == null || paymentType == null) {
            resp.sendRedirect("TransferMoney.jsp?error=Invalid input. Please fill all fields.");
            return;
        }

        double transferAmount = Double.parseDouble(amountStr);
        Connection con = null;
        PreparedStatement ps = null, psInsertTransaction = null;
        ResultSet rs = null;

        try {
            // establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hemanthbank", "root", "root");

            // **Validate the PIN and get sender's balance**
            String senderQuery = "SELECT pass, balance FROM bank WHERE accno = ?";
            ps = con.prepareStatement(senderQuery);
            ps.setString(1, senderAccno);
            rs = ps.executeQuery();

            if (!rs.next()) {
                req.setAttribute("error", "Sender account details not found.");
                req.getRequestDispatcher("TransferMoney.jsp?error=Sender account details not found.").forward(req, resp);
                return;
            }

            String storedPass = rs.getString("pass");
            double senderBalance = rs.getDouble("balance");

            if (!storedPass.equals(enteredPin)) {
                req.getRequestDispatcher("TransferMoney.jsp?error=Incorrect PIN. Please try again.").forward(req, resp);
                return;
            }

            // **Validate if receiver account exists**
            String receiverQuery = "SELECT accno FROM bank WHERE accno = ?";
            ps = con.prepareStatement(receiverQuery);
            ps.setString(1, receiverAccno);
            rs = ps.executeQuery();

            if (!rs.next()) {
                req.getRequestDispatcher("TransferMoney.jsp?errorr=Receiver account not found in our Bank records.").forward(req, resp);
                return;
            }

            // **Check sufficient balance**
            if (senderBalance < transferAmount) {
                req.getRequestDispatcher("TransferMoney.jsp?error=Insufficient balance.").forward(req, resp);
                return;
            }

            // **Deduct amount from sender**
            String deductQuery = "UPDATE bank SET balance = balance - ? WHERE accno = ?";
            ps = con.prepareStatement(deductQuery);
            ps.setDouble(1, transferAmount);
            ps.setString(2, senderAccno);
            ps.executeUpdate();

            // **Add amount to receiver**
            String addQuery = "UPDATE bank SET balance = balance + ? WHERE accno = ?";
            ps = con.prepareStatement(addQuery);
            ps.setDouble(1, transferAmount);
            ps.setString(2, receiverAccno);
            ps.executeUpdate();

            // Insert DEBIT transaction for sender
            String insertDebitTransactionQuery = "INSERT INTO transactions (sender_accno, receiver_accno, amount, transaction_type, transaction_status, transaction_date) VALUES (?, ?, ?, ?, ?, ?)";
            psInsertTransaction = con.prepareStatement(insertDebitTransactionQuery);
            psInsertTransaction.setString(1, senderAccno);
            psInsertTransaction.setString(2, receiverAccno);
            psInsertTransaction.setDouble(3, transferAmount);
            psInsertTransaction.setString(4, paymentType); 
            psInsertTransaction.setString(5, "Debit"); 
            psInsertTransaction.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            psInsertTransaction.executeUpdate();

            //insert CREDIT transaction for receiver
            String insertCreditTransactionQuery = "INSERT INTO transactions (sender_accno, receiver_accno, amount, transaction_type, transaction_status, transaction_date) VALUES (?, ?, ?, ?, ?, ?)";
            psInsertTransaction = con.prepareStatement(insertCreditTransactionQuery);
            psInsertTransaction.setString(1, receiverAccno);
            psInsertTransaction.setString(2, senderAccno);
            psInsertTransaction.setDouble(3, transferAmount);
            psInsertTransaction.setString(4, paymentType); 
            psInsertTransaction.setString(5, "Credit"); 
            psInsertTransaction.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now()));
            psInsertTransaction.executeUpdate();

            //Redirect with success message
            resp.sendRedirect("TransferSuccess.jsp?message=Transfer successful.");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            req.getRequestDispatcher("TransferMoney.jsp?error=An error occurred. Please try again.").forward(req, resp);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (psInsertTransaction != null) psInsertTransaction.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
