package Bank_Application;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProfile")
public class DeleteOperation extends HttpServlet {
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

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

            String deleteQuery = "DELETE FROM bank WHERE accno = ?";
            ps = con.prepareStatement(deleteQuery);
            ps.setString(1, accno);

            int deletedRows = ps.executeUpdate();
            if (deletedRows > 0) {
                // invalidate session after deleting the profile
                session.invalidate();
                req.setAttribute("message", "Profile deleted successfully.");
                req.getRequestDispatcher("DeleteSuccess.jsp").forward(req, resp);  // redirect to login page after successful deletion
            } else {
                req.setAttribute("error", "Failed to delete profile.");
                req.getRequestDispatcher("DeleteProfile.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("DeleteProfile.jsp").forward(req, resp);
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
