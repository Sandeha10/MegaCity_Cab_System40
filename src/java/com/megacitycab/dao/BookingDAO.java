package com.megacitycab.dao;

import com.megacitycab.model.Booking;
import com.megacitycab.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

        
    public List<Booking> getAllBookings() {
    List<Booking> bookings = new ArrayList<>();
    String query = "SELECT * FROM bookings";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {
        
        System.out.println("✅ Executing query: " + query); // Debug log

        while (rs.next()) {
            Booking booking = new Booking(
               rs.getInt("booking_id"), rs.getString("customer_name"), rs.getString("nic"),
                rs.getString("address"), rs.getString("contact_number"), rs.getString("pickup_location"),
                rs.getString("drop_location"), rs.getDouble("distance"), rs.getString("vehicle_type"),
                rs.getString("vehicle_name"), rs.getDouble("fare"), rs.getString ("booking_date"));
            bookings.add(booking);
            System.out.println("✅ Fetched booking: " + booking.getCustomerName()); // Debug log
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("❌ Error fetching bookings: " + e.getMessage()); // Debug log
    }
    return bookings;

    
}

    // Retrieve bookings by customer email
    public List<Booking> getBookingsByCustomer(String email) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE customer_email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(rs.getInt("booking_id"), rs.getString("customer_name"), rs.getString("nic"), rs.getString("address"), rs.getString("contact_number"), rs.getString("pickup_location"), rs.getString("drop_location"), rs.getDouble("distance"), rs.getString("vehicle_type"), rs.getString("vehicle_name"), rs.getDouble("fare"), rs.getTimestamp("booking_date"), rs.getString("booking_date"), rs.getString("email"));
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setNic(rs.getString("nic"));
                booking.setAddress(rs.getString("address"));
                booking.setContactNumber(rs.getString("contact_number"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setDistance(rs.getDouble("distance"));
                booking.setVehicleType(rs.getString("vehicle_type"));
                booking.setVehicleName(rs.getString("vehicle_name"));
                booking.setFare(rs.getDouble("fare"));
                booking.setBookingDate(rs.getString ("booking_date"));
                bookings.add(booking);
            }

            // Debugging: Print how many bookings were found
            System.out.println("✅ Bookings found for email " + email + ": " + bookings.size());

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("❌ Error in getBookingsByCustomer(): " + e.getMessage());
        }
        return bookings;
    }
    
            public Booking getBookingById(int bookingId) {
        Booking booking = null;
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                booking = new Booking(
                    rs.getInt("booking_id"), rs.getString("customer_name"), rs.getString("nic"),
                    rs.getString("address"), rs.getString("contact_number"), rs.getString("pickup_location"),
                    rs.getString("drop_location"), rs.getDouble("distance"), rs.getString("vehicle_type"),
                    rs.getString("vehicle_name"), rs.getDouble("fare"), rs.getTimestamp("booking_date"),
                    rs.getString("booking_date"), rs.getString("email")    
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booking;
    }
            
               public boolean updateBooking(int bookingId, String customerName, String nic, String contactNumber, String pickupLocation, String dropLocation, String vehicleType, double fare) {
        String query = "UPDATE bookings SET customer_name = ?, nic = ?, contact_number = ?, pickup_location = ?, drop_location = ?, vehicle_type = ?, fare = ? WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, customerName);
            stmt.setString(2, nic);
            stmt.setString(3, contactNumber);
            stmt.setString(4, pickupLocation);
            stmt.setString(5, dropLocation);
            stmt.setString(6, vehicleType);
            stmt.setDouble(7, fare);
            stmt.setInt(8, bookingId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
             public boolean deleteBooking(int bookingId) {
         String query = "DELETE FROM bookings WHERE booking_id = ?";
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement stmt = conn.prepareStatement(query)) {
             stmt.setInt(1, bookingId);
             int rowsDeleted = stmt.executeUpdate();
             return rowsDeleted > 0;
         } catch (SQLException e) {
             e.printStackTrace();
             return false;
         }
    }
    
    
    
}
