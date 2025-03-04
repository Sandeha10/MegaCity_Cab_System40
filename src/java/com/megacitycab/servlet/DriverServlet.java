package com.megacitycab.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.megacitycab.util.DBConnection;

@WebServlet("/DriverServlet")
public class DriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendRedirect("driverManagement.jsp?error=Invalid action");
            return;
        }

        switch (action) {
            case "add":
                addDriver(request, response);
                break;
            case "edit":
                editDriver(request, response);
                break;
            case "delete":
                deleteDriver(request, response);
                break;
            default:
                response.sendRedirect("driverManagement.jsp?error=Invalid action");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Handle delete action if it comes as a GET request
        if ("delete".equals(action)) {
            deleteDriver(request, response);
        } else {
            response.sendRedirect("driverManagement.jsp?error=Invalid action");
        }
    }

    private void addDriver(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String driverName = request.getParameter("driverName");
        String driverNIC = request.getParameter("driverNIC");
        String driverDL = request.getParameter("driverDL");
        String driverAddress = request.getParameter("driverAddress");
        String driverEmail = request.getParameter("driverEmail");
        String driverContact = request.getParameter("driverContact");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO drivers (driver_name, driver_nic, driver_dl_number, driver_address, driver_email, driver_contact) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, driverName);
            pstmt.setString(2, driverNIC);
            pstmt.setString(3, driverDL);
            pstmt.setString(4, driverAddress);
            pstmt.setString(5, driverEmail);
            pstmt.setString(6, driverContact);
            pstmt.executeUpdate();
            response.sendRedirect("driverManagement.jsp?success=Driver added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("driverManagement.jsp?error=Failed to add driver");
        }
    }

    private void editDriver(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String driverName = request.getParameter("driverName");
        String driverNIC = request.getParameter("driverNIC");
        String driverDL = request.getParameter("driverDL");
        String driverAddress = request.getParameter("driverAddress");
        String driverEmail = request.getParameter("driverEmail");
        String driverContact = request.getParameter("driverContact");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE drivers SET driver_name = ?, driver_nic = ?, driver_dl_number = ?, driver_address = ?, driver_email = ?, driver_contact = ? WHERE driver_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, driverName);
            pstmt.setString(2, driverNIC);
            pstmt.setString(3, driverDL);
            pstmt.setString(4, driverAddress);
            pstmt.setString(5, driverEmail);
            pstmt.setString(6, driverContact);
            pstmt.setInt(7, driverId);
            pstmt.executeUpdate();
            response.sendRedirect("driverManagement.jsp?success=Driver updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("driverManagement.jsp?error=Failed to update driver");
        }
    }

    private void deleteDriver(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM drivers WHERE driver_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, driverId);
            pstmt.executeUpdate();
            response.sendRedirect("driverManagement.jsp?success=Driver deleted successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("driverManagement.jsp?error=Failed to delete driver");
        }
    }
}