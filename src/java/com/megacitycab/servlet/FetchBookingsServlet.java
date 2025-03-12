package com.megacitycab.servlet;

import com.megacitycab.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/FetchBookingsServlet")
public class FetchBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Booking> bookings = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM bookings";
            try (PreparedStatement pst = conn.prepareStatement(sql)) {
                try (ResultSet rs = pst.executeQuery()) {
                    while (rs.next()) {
                        Booking booking = new Booking();
                        booking.setBookingId(rs.getInt("booking_id"));
                        booking.setCustomerName(rs.getString("customer_name"));
                        booking.setNic(rs.getString("nic"));
                        booking.setPickupLocation(rs.getString("pickup_location"));
                        booking.setDropLocation(rs.getString("drop_location"));
                        booking.setVehicleName(rs.getString("vehicle_name"));
                        booking.setFare(rs.getDouble("fare"));
                        booking.setBookingDate(rs.getString("booking_date"));
                        bookings.add(booking);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

       

        // Set the response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

       
    }
}

class Booking {
    private int bookingId;
    private String customerName;
    private String nic;
    private String pickupLocation;
    private String dropLocation;
    private String vehicleName;
    private double fare;
    private String bookingDate;

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }

    public String getDropLocation() { return dropLocation; }
    public void setDropLocation(String dropLocation) { this.dropLocation = dropLocation; }

    public String getVehicleName() { return vehicleName; }
    public void setVehicleName(String vehicleName) { this.vehicleName = vehicleName; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }

    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
}