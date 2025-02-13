package Bank_Application;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateProfile")
public class UpdateOperation extends HttpServlet {
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

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        String phno = req.getParameter("phno");
        String address = req.getParameter("address");
        String balance = req.getParameter("balance");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

            String updateQuery = "UPDATE bank SET name = ?, email = ?, pass = ?, phno = ?, address = ?, balance = ? WHERE accno = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, phno);
            ps.setString(5, address);
            ps.setString(6, balance);
            ps.setString(7, accno);

            int updatedRows = ps.executeUpdate();
            if (updatedRows > 0) {
                req.setAttribute("message", "Profile updated successfully!");
                req.getRequestDispatcher("UpdateSuccess.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Failed to update profile.");
                req.getRequestDispatcher("UpdateProfile.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("UpdateProfile.jsp").forward(req, resp);
        } finally {
            try {
                if (con != null) con.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
