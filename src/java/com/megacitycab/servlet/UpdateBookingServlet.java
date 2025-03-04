package com.megacitycab.servlet;

import com.megacitycab.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String customerName = request.getParameter("customerName");
        String nic = request.getParameter("nic");
        String contactNumber = request.getParameter("contactNumber");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String vehicleType = request.getParameter("vehicleType");
        double fare = Double.parseDouble(request.getParameter("fare"));

        BookingDAO bookingDAO = new BookingDAO();
        boolean updated = bookingDAO.updateBooking(bookingId, customerName, nic, contactNumber, pickupLocation, dropLocation, vehicleType, fare);

        if (updated) {
            response.sendRedirect("viewavailables.jsp");
        } else {
            response.getWriter().println("Failed to update booking.");
        }
    }
}