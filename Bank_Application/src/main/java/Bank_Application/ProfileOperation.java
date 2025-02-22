package Bank_Application;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/FetchProfile")
public class ProfileOperation extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String accno = (String) session.getAttribute("accno");

        if (accno == null) {
            req.setAttribute("error", "Session expired. Please log in again.");
            req.getRequestDispatcher("Login.jsp").forward(req, resp);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
        	//establishing connection between .java and db.
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

            String query = "SELECT * FROM bank WHERE accno = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, accno);
            rs = ps.executeQuery();

            if (rs.next()) {
                req.setAttribute("profile", rs);
                req.getRequestDispatcher("Profile.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Profile not found!");
                req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("Dashboard.jsp").forward(req, resp);
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
