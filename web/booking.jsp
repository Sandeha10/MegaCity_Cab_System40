<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride - Mega City Cab</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Book Your Ride</h2>
        <form action="BookingServlet" method="post">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" name="name" id="name" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" name="address" id="address" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="nic">NIC (12 digits)</label>
                <input type="text" name="nic" id="nic" class="form-control" maxlength="12" required>
                <span id="nicError" class="error-message" style="display:none;">NIC must be 12 digits.</span>
            </div>

            <div class="form-group">
                <label for="contact">Telephone Number</label>
                <input type="tel" name="contact" id="contact" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="pickupLocation">Pickup Location</label>
                <input type="text" name="pickupLocation" id="pickupLocation" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="dropLocation">Drop Location</label>
                <input type="text" name="dropLocation" id="dropLocation" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="date">Date</label>
                <input type="date" name="date" id="date" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="time">Time</label>
                <input type="time" name="time" id="time" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="vehicleType">Vehicle Type</label>
                <select name="vehicleType" id="vehicleType" class="form-control" required>
                    <option value="car">Car</option>
                    <option value="van">Van</option>
                </select>
            </div>

            <div class="form-group" id="vehicleDetails" style="display:none;">
                <label for="vehicleModel">Vehicle Model</label>
                <select name="vehicleModel" id="vehicleModel" class="form-control">
                    <!-- Vehicle models will be populated dynamically based on vehicle type -->
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Submit Booking</button>
        </form>
    </div>

    <script src="js/booking.js"></script>
</body>
</html>
