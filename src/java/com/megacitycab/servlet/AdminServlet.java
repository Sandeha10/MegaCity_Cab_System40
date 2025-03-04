package com.megacitycab.servlet;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String contact = request.getParameter("contact");
            String password = request.getParameter("password"); // Hash password before storing
            
            UserDAO userDAO = new UserDAO();
            boolean isAdded = userDAO.addAdmin(name, email, contact, password);

            if (isAdded) {
                response.sendRedirect("admin-Dashboard.jsp?success=AdminAdded");
            } else {
                response.sendRedirect("admin-Dashboard.jsp?error=FailedToAdd");
            }
        } 
        
        else if ("delete".equals(action)) {
            int adminId = Integer.parseInt(request.getParameter("adminId"));
            UserDAO userDAO = new UserDAO();
            boolean isDeleted = userDAO.deleteAdmin(adminId);

            if (isDeleted) {
                response.sendRedirect("adminDashboard.jsp?success=AdminDeleted");
            } else {
                response.sendRedirect("adminDashboard.jsp?error=FailedToDelete");
            }
        }
    }

    // Fetch total counts for dashboard
    public static int getTotalBookings() {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM bookings");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public static int getTotalCustomers() {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE role='customer'");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public static int getTotalDrivers() {
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM drivers");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
