package Bank_Application;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ShowTransactions")
public class ShowTransactionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String userAccno = (String) session.getAttribute("accno");

        if (userAccno == null) {
            req.setAttribute("error", "Session expired. Please log in again.");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

            // fetch transactions for the logged-in user (both sent and received)
            String query = "SELECT sender_accno, receiver_accno, amount, transaction_type, transaction_date, transaction_status FROM transactions WHERE sender_accno = ? OR receiver_accno = ? ORDER BY transaction_date DESC";
            ps = con.prepareStatement(query);
            ps.setString(1, userAccno);
            ps.setString(2, userAccno);

            rs = ps.executeQuery();

            // store the transactions in a list
            List<Transaction> transactions = new ArrayList<>();
            while (rs.next()) {
                Transaction txn = new Transaction(
                    rs.getString("sender_accno"),
                    rs.getString("receiver_accno"),
                    rs.getDouble("amount"),
                    rs.getString("transaction_type"),
                    rs.getTimestamp("transaction_date"),
                    rs.getString("transaction_status")
                );
                transactions.add(txn);
            }

            
            
            System.out.println(transactions);
            // set the transactions list in the request attribute
            req.setAttribute("transactions", transactions);

            // forward to the JSP page to display the transactions
            req.getRequestDispatcher("ShowTransactions.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("ErrorPage.jsp").forward(req, resp);
        } finally {
            try {
                if (con != null) con.close();
                if (ps != null) ps.close();
                if (rs != null) rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
