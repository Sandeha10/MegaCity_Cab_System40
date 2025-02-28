<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="dbConnection.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make a Booking</title>
    <link rel="stylesheet" href="css/customerbooking.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Make a Booking</h2>
    <div class="booking-form">
        <form id="bookingForm" action="BookingServlet" method="post">
            
            <!-- Customer Name -->
            <label>Full Name:</label>
            <input type="text" name="customer_name" class="form-control" required>

            <!-- NIC -->
            <label>NIC:</label>
            <input type="text" name="nic" id="nic" class="form-control" required>
            <small class="text-danger" id="nicError"></small>

            <!-- Address -->
            <label>Address:</label>
            <input type="text" name="address" class="form-control" required>

            <!-- Contact Number -->
            <label>Contact Number:</label>
            <input type="text" name="contact_number" id="contact" class="form-control" required>
            <small class="text-danger" id="contactError"></small>

            <!-- Pickup Location -->
            <label>Pickup Location:</label>
            <select name="pickup_location" id="pickup" class="form-control" required>
                <option value="">Select Pickup Location</option>
                <option value="Matara">Matara</option>
                <option value="Weligama">Weligama</option>
                <option value="Galle">Galle</option>
            </select>

            <!-- Drop Location -->
            <label>Drop Location:</label>
            <select name="drop_location" id="drop" class="form-control" required>
                <option value="">Select Drop Location</option>
                <option value="Matara">Matara</option>
                <option value="Weligama">Weligama</option>
                <option value="Galle">Galle</option>
            </select>

            <!-- Distance -->
            <label>Distance (km):</label>
            <input type="text" name="distance" id="distance" class="form-control" readonly>

            <!-- Vehicle Type -->
            <label>Vehicle Type:</label>
            <select name="vehicle_type" id="vehicleType" class="form-control" required>
                <option value="">Select Vehicle Type</option>
                <option value="Car">Car</option>
                <option value="Van">Van</option>
            </select>

            <!-- Vehicle Name -->
            <label>Vehicle Name:</label>
            <select name="vehicle_name" id="vehicleName" class="form-control" required></select>

            <!-- Fare Calculation -->
            <label>Fare (Rs):</label>
            <input type="text" name="fare" id="fare" class="form-control" readonly>

            <button type="submit" class="btn btn-primary mt-3">Book Now</button>
        </form>
    </div>
</div>

<script src="booking.js"></script>
</body>
</html>
