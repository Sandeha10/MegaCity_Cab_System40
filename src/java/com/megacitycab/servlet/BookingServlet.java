package com.megacitycab.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.megacitycab.util.DBConnection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get form data
        String customerName = request.getParameter("customer_name");
        String nic = request.getParameter("nic");
        String address = request.getParameter("address");
        String contactNumber = request.getParameter("contact_number");
        String pickupLocation = request.getParameter("pickup_location");
        String dropLocation = request.getParameter("drop_location");
        String distance = request.getParameter("distance");
        String vehicleType = request.getParameter("vehicle_type");
        String vehicleName = request.getParameter("vehicle_name");
        String fare = request.getParameter("fare");

        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO bookings (customer_name, nic, address, contact_number, pickup_location, drop_location, distance, vehicle_type, vehicle_name, fare) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            
            pst.setString(1, customerName);
            pst.setString(2, nic);
            pst.setString(3, address);
            pst.setString(4, contactNumber);
            pst.setString(5, pickupLocation);
            pst.setString(6, dropLocation);
            pst.setDouble(7, Double.parseDouble(distance));
            pst.setString(8, vehicleType);
            pst.setString(9, vehicleName);
            pst.setDouble(10, Double.parseDouble(fare));
            
            int result = pst.executeUpdate();
            
            if (result > 0) {
                out.println("<script>alert('Booking Successful!'); window.location='makeBooking.jsp';</script>");
            } else {
                out.println("<script>alert('Booking Failed! Try Again.'); window.location='makeBooking.jsp';</script>");
            }
            
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error occurred: " + e.getMessage() + "'); window.location='makeBooking.jsp';</script>");
        }
    }
}
