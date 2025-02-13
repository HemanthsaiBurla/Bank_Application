package Bank_Application;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewTransactions")
public class ViewTransactions extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String accno = (String) session.getAttribute("accno");

        if (accno == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        List<Transaction> transactions = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hemanthbank", "root", "root");
            
            String query = "SELECT sender_accno, receiver_accno, amount, transaction_type, transaction_date, transaction_status FROM transactions WHERE sender_accno = ? OR receiver_accno = ? ORDER BY transaction_date DESC";
            ps = con.prepareStatement(query);
            ps.setString(1, accno);
            ps.setString(2, accno);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                String sender = rs.getString("sender_accno");
                String receiver = rs.getString("receiver_accno");
                double amount = rs.getDouble("amount");
                String type = rs.getString("transaction_type");
                Timestamp date = rs.getTimestamp("transaction_date");
                String transactionStatus = rs.getString("transaction_status"); // ✅ Added

                transactions.add(new Transaction(sender, receiver, amount, type, date, transactionStatus));
            }
            
            req.setAttribute("transactions", transactions);
            req.getRequestDispatcher("ViewTransactions.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to retrieve transactions.");
            req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
