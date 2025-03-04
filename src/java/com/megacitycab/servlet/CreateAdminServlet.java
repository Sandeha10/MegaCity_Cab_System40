package com.megacitycab.servlet;

import com.megacitycab.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateAdminServlet")
public class CreateAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password"); // Should be hashed in real app
        String role = request.getParameter("role");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO user (name, email, contact, password_hash, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, contact);
            ps.setString(4, password);
            ps.setString(5, role);
            ps.executeUpdate();
            response.sendRedirect("adminDashboard.jsp?msg=Admin Created Successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
