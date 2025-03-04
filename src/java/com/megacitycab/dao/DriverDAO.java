package com.megacitycab.dao;

import com.megacitycab.model.Driver;
import com.megacitycab.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {

    // Add a new driver
    public boolean addDriver(Driver driver) {
        String query = "INSERT INTO drivers (driver_name, driver_nic, driver_dl_number, driver_address, driver_email, driver_contact) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, driver.getDriverName());
            stmt.setString(2, driver.getDriverNic());
            stmt.setString(3, driver.getDriverDlNumber());
            stmt.setString(4, driver.getDriverAddress());
            stmt.setString(5, driver.getDriverEmail());
            stmt.setString(6, driver.getDriverContact());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Fetch all drivers
    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT * FROM drivers";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Driver driver = new Driver(
                    rs.getInt("driver_id"),
                    rs.getString("driver_name"),
                    rs.getString("driver_nic"),
                    rs.getString("driver_dl_number"),
                    rs.getString("driver_address"),
                    rs.getString("driver_email"),
                    rs.getString("driver_contact")
                );
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }

    // Delete a driver by ID
    public boolean deleteDriver(int driverId) {
        String query = "DELETE FROM drivers WHERE driver_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, driverId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a driver
    public boolean updateDriver(Driver driver) {
        String query = "UPDATE drivers SET driver_name = ?, driver_nic = ?, driver_dl_number = ?, driver_address = ?, driver_email = ?, driver_contact = ? WHERE driver_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, driver.getDriverName());
            stmt.setString(2, driver.getDriverNic());
            stmt.setString(3, driver.getDriverDlNumber());
            stmt.setString(4, driver.getDriverAddress());
            stmt.setString(5, driver.getDriverEmail());
            stmt.setString(6, driver.getDriverContact());
            stmt.setInt(7, driver.getDriverId());
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}