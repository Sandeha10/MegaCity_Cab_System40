package com.megacitycab.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

@WebServlet("/downloadBill")  // Mapping the servlet to the "/downloadBill" URL pattern
public class DownloadBillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
        
        String query = "SELECT * FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Document document = new Document();
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                PdfWriter.getInstance(document, baos);
                document.open();

                // Add content to PDF
                document.add(new Paragraph("Booking Summary"));
                document.add(new Paragraph("Booking ID: " + rs.getInt("booking_id")));
                document.add(new Paragraph("Customer Name: " + rs.getString("customer_name")));
                document.add(new Paragraph("Vehicle: " + rs.getString("vehicle_name")));
                document.add(new Paragraph("Fare: Rs. " + rs.getDouble("fare")));
                document.add(new Paragraph("Booking Date: " + rs.getTimestamp("booking_date")));

                document.close();

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=booking_summary.pdf");
                response.getOutputStream().write(baos.toByteArray());
                response.flushBuffer();
            }
        } catch (SQLException | DocumentException e) {
            e.printStackTrace();
        }
    }
}
