    package com.megacitycab.dao;

import com.megacitycab.util.DBConnection;
import com.megacitycab.model.User;
import com.megacitycab.util.PasswordUtil;  // Import PasswordUtil class
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

  public static boolean registerUser(User user) {
    String sql = "INSERT INTO user (name, email, contact, password_hash, role) VALUES (?, ?, ?, ?, ?)";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, user.getName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getContact());
        stmt.setString(4, user.getPasswordHash());
        stmt.setString(5, user.getRole());

        int rowsInserted = stmt.executeUpdate();
        return rowsInserted > 0;

    } catch (SQLException e) {
        System.err.println("Error during user registration: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}
    // Method to fetch user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM user WHERE email = ?";
        User user = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Get stored hashed password
                String storedPasswordHash = rs.getString("password_hash");

                // Hash the provided password to compare with the stored password hash
                String hashedPassword = PasswordUtil.hashPassword(password);

                // Check if the hashed passwords match
                if (storedPasswordHash.equals(hashedPassword)) {
                    user = new User();
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setContact(rs.getString("contact"));
                    user.setPasswordHash(storedPasswordHash); // Set the stored hash
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return user;
    }
    
    
    
   

    public boolean addAdmin(String name, String email, String contact, String password) {
        String query = "INSERT INTO user (name, email, contact, password, role) VALUES (?, ?, ?, ?, 'admin')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, contact);
            ps.setString(4, password);  // You should hash the password before storing it
            
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAdmin(int adminId) {
        String query = "DELETE FROM user WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, adminId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllAdmins() {
        List<User> adminList = new ArrayList<>();
        String query = "SELECT * FROM user WHERE role='admin'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User admin = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("contact")
                );
                adminList.add(admin);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return adminList;
    }
    
    
          // Fetch all customers
    public List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();
        String query = "SELECT * FROM user WHERE role = 'customer'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("contact"),
                    rs.getString("password_hash"),
                    rs.getString("role")
                );
                customers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Delete a customer by user_id
    public boolean deleteCustomer(int userId) {
        String query = "DELETE FROM user WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
