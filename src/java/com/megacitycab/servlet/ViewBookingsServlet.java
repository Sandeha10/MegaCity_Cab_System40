package com.megacitycab.servlet;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.Booking;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookings();

        // Debug: Print the number of bookings fetched
        System.out.println("✅ Number of bookings fetched: " + bookings.size());

        // Set the bookings list as a request attribute
        request.setAttribute("bookings", bookings);

        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewavailable.jsp");
        dispatcher.forward(request, response);
    }
}