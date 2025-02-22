package Bank_Application;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Login")
public class LoginOperation extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accno = req.getParameter("accno");
        String pass = req.getParameter("pass");

        Connection con = null;
        PreparedStatement psAccCheck = null;
        PreparedStatement psPassCheck = null;
        ResultSet rs = null;

        try {
            // database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

            // query to check account number
            String accCheckQuery = "SELECT * FROM bank WHERE accno = ?";
            psAccCheck = con.prepareStatement(accCheckQuery);
            psAccCheck.setString(1, accno);
            rs = psAccCheck.executeQuery();

            if (rs.next()) {
                // account number exists, check the password
                String storedPass = rs.getString("pass");
                if (storedPass.equals(pass)) {
                    // Successful login, create a session
                    HttpSession session = req.getSession();
                    session.setAttribute("accno", accno); // save accno for CRUD operations
                    resp.sendRedirect("Dashboard.jsp"); // redirect to dashboard or home page
                } else {
                    // Password is wrong
                    req.setAttribute("error", "Password is wrong");
                    req.getRequestDispatcher("Login.jsp").forward(req, resp);
                }
            } else {
                // account number is wrong
                req.setAttribute("error", "Account number and password are wrong");
                req.getRequestDispatcher("Login.jsp").forward(req, resp);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred. Please try again later.");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
        } finally {
            try {
                if (rs != null) rs.close();
                if (psAccCheck != null) psAccCheck.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
