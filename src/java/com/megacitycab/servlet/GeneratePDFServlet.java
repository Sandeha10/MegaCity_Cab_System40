package com.megacitycab.servlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/GeneratePDFServlet")
public class GeneratePDFServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerEmail = request.getParameter("customerEmail");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Fetch the latest bill for the customer
            String sql = "SELECT * FROM bills WHERE customer_email = ? ORDER BY bill_id DESC LIMIT 1";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, customerEmail);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Create a PDF document
                Document document = new Document();
                OutputStream out = response.getOutputStream();

                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=\"bill.pdf\"");

                PdfWriter.getInstance(document, out);
                document.open();

                // Add bill details to the PDF
                document.add(new Paragraph("Bill No: " + rs.getString("bill_no")));
                document.add(new Paragraph("Customer Name: " + rs.getString("customer_name")));
                document.add(new Paragraph("Customer NIC: " + rs.getString("customer_nic")));
                document.add(new Paragraph("Customer Email: " + rs.getString("customer_email")));
                document.add(new Paragraph("Pickup Location: " + rs.getString("pickup_location")));
                document.add(new Paragraph("Drop Location: " + rs.getString("drop_location")));
                document.add(new Paragraph("Vehicle Name: " + rs.getString("vehicle_name")));
                document.add(new Paragraph("Fare: Rs. " + rs.getDouble("fare")));
                document.add(new Paragraph("Date: " + rs.getString("bill_date")));

                document.close();
                out.close();
            }

            rs.close();
            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewMyBooking.jsp?error=1");
        }
    }
}