package com.megacitycab.servlet;

import com.megacitycab.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        BookingDAO bookingDAO = new BookingDAO();
        boolean deleted = bookingDAO.deleteBooking(bookingId);

        if (deleted) {
            response.sendRedirect("viewavailables.jsp");
        } else {
            response.getWriter().println("Failed to delete booking.");
        }
    }
}