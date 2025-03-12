package com.megacitycab.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String billNo = request.getParameter("billNo");
        String customerName = request.getParameter("customerName");
        String customerNic = request.getParameter("customerNic");
        String customerEmail = request.getParameter("customerEmail");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String vehicleName = request.getParameter("vehicleName");
        double fare = Double.parseDouble(request.getParameter("fare"));

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab";
        String dbUser = "root";
        String dbPassword = "";

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to insert data into the bills table
            String sql = "INSERT INTO bills (bill_no, customer_name, customer_nic, customer_email, pickup_location, drop_location, vehicle_name, fare) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);

            // Set parameters for the SQL query
            pst.setString(1, billNo);
            pst.setString(2, customerName);
            pst.setString(3, customerNic);
            pst.setString(4, customerEmail);
            pst.setString(5, pickupLocation);
            pst.setString(6, dropLocation);
            pst.setString(7, vehicleName);
            pst.setDouble(8, fare);

            // Execute the query
            int rowsInserted = pst.executeUpdate();

            // Close resources
            pst.close();
            conn.close();

            // Redirect to the admin-billing page with a success message
            response.sendRedirect("admin-billing.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();

            // Redirect to the admin-billing page with an error message
            response.sendRedirect("admin-billing.jsp?error=1");
        }
    }
}