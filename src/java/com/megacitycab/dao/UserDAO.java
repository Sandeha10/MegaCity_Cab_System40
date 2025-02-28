package com.megacitycab.dao;

import com.megacitycab.util.DBConnection;
import com.megacitycab.model.User;
import com.megacitycab.util.PasswordUtil;  // Import PasswordUtil class
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
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
}
