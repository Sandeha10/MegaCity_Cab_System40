package com.megacitycab.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.megacitycab.util.DBConnection;

@WebServlet("/VehicleServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class VehicleServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads"; // Directory to store uploaded files

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addCar".equals(action)) {
            addVehicle(request, response, "car");
        } else if ("addVan".equals(action)) {
            addVehicle(request, response, "van");
        } else if ("edit".equals(action)) {
            editVehicle(request, response);
        } else if ("delete".equals(action)) {
            deleteVehicle(request, response);
        } else {
            response.sendRedirect("vehicleManagement.jsp?error=Invalid action");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Handle delete action if it comes as a GET request
        if ("delete".equals(action)) {
            deleteVehicle(request, response);
        } else {
            response.sendRedirect("vehicleManagement.jsp?error=Invalid action");
        }
    }

    private void addVehicle(HttpServletRequest request, HttpServletResponse response, String vehicleType) throws IOException, ServletException {
        // Get form data
        String vehicleName = request.getParameter(vehicleType + "Name");
        String vehicleColor = request.getParameter(vehicleType + "Color");
        int passengerCapacity = Integer.parseInt(request.getParameter(vehicleType + "Passengers"));
        double chargePerKm = Double.parseDouble(request.getParameter(vehicleType + "Charge"));
        int driverId = Integer.parseInt(request.getParameter(vehicleType + "Driver"));

        // Handle file upload
        Part filePart = request.getPart(vehicleType + "Pic");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the file
        String filePath = uploadPath + File.separator + fileName;
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Save vehicle details to the database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO vehicles (vehicle_type, vehicle_pic, vehicle_name, vehicle_color, passenger_capacity, charge_per_km, driver_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vehicleType);
            pstmt.setString(2, fileName); // Save only the file name
            pstmt.setString(3, vehicleName);
            pstmt.setString(4, vehicleColor);
            pstmt.setInt(5, passengerCapacity);
            pstmt.setDouble(6, chargePerKm);
            pstmt.setInt(7, driverId);
            pstmt.executeUpdate();
            response.sendRedirect("vehicleManagement.jsp?success=Vehicle added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vehicleManagement.jsp?error=Failed to add vehicle");
        }
    }

    private void editVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        String vehicleType = request.getParameter("vehicleType");
        String vehicleName = request.getParameter("vehicleName");
        String vehicleColor = request.getParameter("vehicleColor");
        int passengerCapacity = Integer.parseInt(request.getParameter("passengerCapacity"));
        double chargePerKm = Double.parseDouble(request.getParameter("chargePerKm"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        // Handle file upload (if a new file is uploaded)
        Part filePart = request.getPart("vehiclePic");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        // Create upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the file (if a new file is uploaded)
        String filePath = uploadPath + File.separator + fileName;
        if (fileName != null && !fileName.isEmpty()) {
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, new File(filePath).toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
        }

        // Update vehicle details in the database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE vehicles SET vehicle_type = ?, vehicle_pic = ?, vehicle_name = ?, vehicle_color = ?, passenger_capacity = ?, charge_per_km = ?, driver_id = ? WHERE vehicle_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vehicleType);
            pstmt.setString(2, fileName.isEmpty() ? request.getParameter("currentPic") : fileName);
            pstmt.setString(3, vehicleName);
            pstmt.setString(4, vehicleColor);
            pstmt.setInt(5, passengerCapacity);
            pstmt.setDouble(6, chargePerKm);
            pstmt.setInt(7, driverId);
            pstmt.setInt(8, vehicleId);
            pstmt.executeUpdate();
            response.sendRedirect("vehicleManagement.jsp?success=Vehicle updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vehicleManagement.jsp?error=Failed to update vehicle");
        }
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, vehicleId);
            pstmt.executeUpdate();
            response.sendRedirect("vehicleManagement.jsp?success=Vehicle deleted successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vehicleManagement.jsp?error=Failed to delete vehicle");
        }
    }
}