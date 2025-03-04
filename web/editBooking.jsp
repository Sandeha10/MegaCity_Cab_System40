<%@ page import="com.megacitycab.dao.BookingDAO" %>
<%@ page import="com.megacitycab.model.Booking" %>
<%
    int bookingId = Integer.parseInt(request.getParameter("id"));
    BookingDAO bookingDAO = new BookingDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);
%>
<form action="UpdateBookingServlet" method="post">
    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
    Customer Name: <input type="text" name="customerName" value="<%= booking.getCustomerName() %>"><br>
    NIC: <input type="text" name="nic" value="<%= booking.getNic() %>"><br>
    Contact: <input type="text" name="contactNumber" value="<%= booking.getContactNumber() %>"><br>
    Pickup: <input type="text" name="pickupLocation" value="<%= booking.getPickupLocation() %>"><br>
    Drop: <input type="text" name="dropLocation" value="<%= booking.getDropLocation() %>"><br>
    Vehicle: <input type="text" name="vehicleType" value="<%= booking.getVehicleType() %>"><br>
    Fare: <input type="text" name="fare" value="<%= booking.getFare() %>"><br>
    <input type="submit" value="Update Booking">
</form>