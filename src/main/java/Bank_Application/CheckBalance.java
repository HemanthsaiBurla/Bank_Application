package Bank_Application;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CheckBalance")
public class CheckBalance extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String accno = (String) session.getAttribute("accno");

        if (accno == null) {
            req.setAttribute("error", "Session expired. Please log in again.");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
            return;
        }

        String pass = req.getParameter("pass"); // get password from,, form
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

            // query to fetch password and balance
            String query = "SELECT pass, balance FROM bank WHERE accno = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, accno);
            rs = ps.executeQuery();

            if (rs.next()) {
                String storedPass = rs.getString("pass");
                if (storedPass.equals(pass)) {
                    // correct password; retrieve balance
                    String balance = rs.getString("balance");
                    req.setAttribute("balance", balance); // pass balance to JSP
                    req.getRequestDispatcher("CheckBalance.jsp").forward(req, resp);
                } else {
                    // incorrect password
                    req.setAttribute("error", "Invalid password. Please try again.");
                    req.getRequestDispatcher("CheckBalance.jsp").forward(req, resp);
                }
            } else {
                // account number not found (unexpected since its in the session)
                req.setAttribute("error", "Account details not found.");
                req.getRequestDispatcher("CheckBalance.jsp").forward(req, resp);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred. Please try again later.");
            req.getRequestDispatcher("CheckBalance.jsp").forward(req, resp);
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
