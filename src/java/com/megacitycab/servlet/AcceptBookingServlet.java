package com.megacitycab.servlet;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AcceptBookingServlet")
public class AcceptBookingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking != null) {
        

            // Redirect back to the bookings page
            response.sendRedirect("availablebookings.jsp");
        } else {
            response.getWriter().println("Booking not found.");
        }
    }
}