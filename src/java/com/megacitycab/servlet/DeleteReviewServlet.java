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

@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));

        String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "DELETE FROM reviews WHERE review_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, reviewId);
            pst.executeUpdate();

            pst.close();
            conn.close();

            response.sendRedirect("viewAllReviews.jsp?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}