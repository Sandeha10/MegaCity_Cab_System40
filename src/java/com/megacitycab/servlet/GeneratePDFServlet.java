package com.megacitycab.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/GeneratePDFServlet")
public class GeneratePDFServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerEmail = request.getParameter("customerEmail");

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=booking_summary.pdf");
        
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM bookings WHERE customer_email = ? ORDER BY booking_id DESC LIMIT 1");
            pst.setString(1, customerEmail);
            ResultSet rs = pst.executeQuery();

            Document document = new Document();
            OutputStream out = response.getOutputStream();
            PdfWriter.getInstance(document, out);
            document.open();

            document.add((Element) new Paragraph("Mega City Cab Service - Booking Summary"));
            document.add((Element) new Paragraph("------------------------------------------------"));
            
            if (rs.next()) {
                document.add((Element) new Paragraph("Name: " + rs.getString("name")));
                document.add((Element) new Paragraph("NIC: " + rs.getString("nic")));
                document.add((Element) new Paragraph("Address: " + rs.getString("address")));
                document.add((Element) new Paragraph("Contact: " + rs.getString("contact")));
                document.add((Element) new Paragraph("Pickup: " + rs.getString("pickup_location")));
                document.add((Element) new Paragraph("Drop: " + rs.getString("drop_location")));
                document.add((Element) new Paragraph("Vehicle: " + rs.getString("vehicle_type")));
                document.add((Element) new Paragraph("Distance: " + rs.getDouble("distance") + " km"));
                document.add((Element) new Paragraph("Fare: Rs. " + rs.getDouble("fare")));
                document.add((Element) new Paragraph("Date: " + rs.getString("booking_date")));
            }

            document.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static class Paragraph {

        public Paragraph(String string) {
        }
    }
}
