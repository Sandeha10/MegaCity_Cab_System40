<%@ page import="java.util.*, com.megacitycab.dao.BookingDAO, com.megacitycab.model.Booking" %>
<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("customerEmail"); // Assuming email is stored in session after login.
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = (Connection) getServletContext().getAttribute("DBConnection");
    BookingDAO bookingDAO = new BookingDAO(conn);
    List<Booking> bookings = bookingDAO.getBookingsByCustomer(email);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Old Bookings</title>
    <link rel="stylesheet" href="css/customerbooking.css">
</head>
<body>
    <h2>My Old Bookings</h2>
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Customer Name</th>
            <th>Vehicle</th>
            <th>Fare</th>
            <th>Booking Date</th>
        </tr>
        <% if (bookings != null && !bookings.isEmpty()) { %>
            <% for (Booking booking : bookings) { %>
                <tr>
                    <td><%= booking.getBookingId() %></td>
                    <td><%= booking.getCustomerName() %></td>
                    <td><%= booking.getVehicleName() %></td>
                    <td>Rs. <%= booking.getFare() %></td>
                    <td><%= booking.getBookingDate() %></td>
                </tr>
            <% } %>
        <% } else { %>
            <tr><td colspan="5">No past bookings found.</td></tr>
        <% } %>
    </table>
</body>
</html>
