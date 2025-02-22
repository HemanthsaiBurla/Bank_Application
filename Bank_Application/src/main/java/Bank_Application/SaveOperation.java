package Bank_Application;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/save")
public class SaveOperation extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    // Retrieve parameters from the request
	    String accno = req.getParameter("accno");
	    String name = req.getParameter("name");
	    String email = req.getParameter("email");
	    String pass = req.getParameter("pass");
	    String gender = req.getParameter("gender");
	    String phno = req.getParameter("phno");
	    String address = req.getParameter("address");
	    String balance = req.getParameter("balance");

	    Connection conn = null;
	    PreparedStatement ps = null;

	    try {
	        // load MySQL JDBC driver
	        Class.forName("com.mysql.cj.jdbc.Driver");

	        // connect to the MySQL server
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HemanthBank", "root", "root");

	        // check if the account number already exists
	        String checkSql = "SELECT ACCNO FROM bank WHERE ACCNO = ?";
	        ps = conn.prepareStatement(checkSql);
	        ps.setString(1, accno);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            // if the account number exists, send an error message to the JSP
	            req.setAttribute("errorMessage", "Account Number already exists. Please try a different one.");
	            RequestDispatcher ds = req.getRequestDispatcher("Save.jsp");
	            ds.forward(req, res);
	        } else {
	            // prepare SQL query to insert data
	            String insertSql = "INSERT INTO bank (ACCNO, NAME, EMAIL, PASS, GENDER, PHNO, ADDRESS, BALANCE) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	            ps = conn.prepareStatement(insertSql);
	            ps.setString(1, accno);
	            ps.setString(2, name);
	            ps.setString(3, email);
	            ps.setString(4, pass);
	            ps.setString(5, gender);
	            ps.setString(6, phno);
	            ps.setString(7, address);
	            ps.setString(8, balance);

	            // Execute insertion and redirect
	            if (ps.executeUpdate() > 0) {
	                System.out.println("Data inserted successfully...");
	                RequestDispatcher ds = req.getRequestDispatcher("Login.jsp");
	                ds.forward(req, res);
	            } else {
	                System.out.println("Failed to insert data...");
	                req.setAttribute("errorMessage", "Failed to register the user. Please try again.");
	                RequestDispatcher ds = req.getRequestDispatcher("Register.jsp");
	                ds.forward(req, res);
	            }
	        }
	    } catch (Exception e) {
	        System.out.println("Exception occurred: " + e.getMessage());
	        e.printStackTrace();
	        req.setAttribute("errorMessage", "An error occurred. Please try again later.");
	        RequestDispatcher ds = req.getRequestDispatcher("Register.jsp");
	        ds.include(req, res);
	    } finally {
	        // close resources
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
	    }
	}
}

