package com.megacitycab.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerEmail = request.getParameter("customerEmail");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String review = request.getParameter("review");

        String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO reviews (customer_email, booking_id, rating, review_text) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, customerEmail);
            pst.setInt(2, bookingId);
            pst.setInt(3, rating);
            pst.setString(4, review);
            pst.executeUpdate();

            pst.close();
            conn.close();

            response.sendRedirect("viewMyBooking.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}