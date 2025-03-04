<%@ page import="java.util.List" %>
<%@ page import="com.megacitycab.model.Booking" %>
<%@ page import="com.megacitycab.dao.BookingDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Bookings</title>
    <link rel="stylesheet" href="css/availablebookings.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Available Bookings</h2>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Customer Name</th>
                    <th>NIC</th>
                    <th>Contact</th>
                    <th>Pickup</th>
                    <th>Drop</th>
                    <th>Vehicle</th>
                    <th>Fare</th>
                    <th>Booking Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BookingDAO bookingDAO = new BookingDAO();
                    List<Booking> bookings = bookingDAO.getAllBookings();
                    for (Booking booking : bookings) {
                %>
                <tr>
                    <td><%= booking.getCustomerName() %></td>
                    <td><%= booking.getNic() %></td>
                    <td><%= booking.getContactNumber() %></td>
                    <td><%= booking.getPickupLocation() %></td>
                    <td><%= booking.getDropLocation() %></td>
                    <td><%= booking.getVehicleType() + " - " + booking.getVehicleName() %></td>
                    <td><%= booking.getFare() %></td>
                    <td><%= booking.getBookingDate() %></td>
                    <td>
                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%= booking.getBookingId() %>">Edit</button>
                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= booking.getBookingId() %>">Delete</button>
                        <button class="btn btn-success btn-sm" onclick="acceptBooking(<%= booking.getBookingId() %>, '<%= booking.getCustomerName() %>')">Accept</button>
                    </td>
                </tr>

                <!-- Edit Modal for Each Booking -->
                <div class="modal fade" id="editModal<%= booking.getBookingId() %>" tabindex="-1" aria-labelledby="editModalLabel<%= booking.getBookingId() %>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel<%= booking.getBookingId() %>">Edit Booking</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="UpdateBookingServlet" method="post">
                                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                    <div class="mb-3">
                                        <label for="customerName" class="form-label">Customer Name</label>
                                        <input type="text" class="form-control" id="customerName" name="customerName" value="<%= booking.getCustomerName() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="nic" class="form-label">NIC</label>
                                        <input type="text" class="form-control" id="nic" name="nic" value="<%= booking.getNic() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="contactNumber" class="form-label">Contact Number</label>
                                        <input type="text" class="form-control" id="contactNumber" name="contactNumber" value="<%= booking.getContactNumber() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="pickupLocation" class="form-label">Pickup Location</label>
                                        <input type="text" class="form-control" id="pickupLocation" name="pickupLocation" value="<%= booking.getPickupLocation() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="dropLocation" class="form-label">Drop Location</label>
                                        <input type="text" class="form-control" id="dropLocation" name="dropLocation" value="<%= booking.getDropLocation() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="vehicleType" class="form-label">Vehicle Type</label>
                                        <input type="text" class="form-control" id="vehicleType" name="vehicleType" value="<%= booking.getVehicleType() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="fare" class="form-label">Fare</label>
                                        <input type="number" class="form-control" id="fare" name="fare" value="<%= booking.getFare() %>" required>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete Modal for Each Booking -->
                <div class="modal fade" id="deleteModal<%= booking.getBookingId() %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= booking.getBookingId() %>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteModalLabel<%= booking.getBookingId() %>">Delete Booking</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete this booking for <strong><%= booking.getCustomerName() %></strong>?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <a href="DeleteBookingServlet?id=<%= booking.getBookingId() %>" class="btn btn-danger">Delete</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function acceptBooking(id, name) {
            if (confirm("Confirm booking for " + name + "?")) {
                window.location.href = 'AcceptBookingServlet?id=' + id;
            }
        }
    </script>
</body>
</html>