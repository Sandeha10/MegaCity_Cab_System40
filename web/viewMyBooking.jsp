<%@ page import="java.sql.*, java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<%
    // Get logged-in customer email
    String customerEmail = (String) session.getAttribute("customerEmail");

    if (customerEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    String name = "", nic = "", address = "", contact = "", pickup = "", drop = "", vehicle = "", date = "";
    double distance = 0, fare = 0;
    int bookingId = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        String sql = "SELECT * FROM bookings WHERE customer_email = ? ORDER BY booking_id DESC LIMIT 1";
        pst = conn.prepareStatement(sql);
        pst.setString(1, customerEmail);
        rs = pst.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            nic = rs.getString("nic");
            address = rs.getString("address");
            contact = rs.getString("contact");
            pickup = rs.getString("pickup_location");
            drop = rs.getString("drop_location");
            vehicle = rs.getString("vehicle_type");
            distance = rs.getDouble("distance");
            fare = rs.getDouble("fare");
            date = rs.getString("booking_date");
            bookingId = rs.getInt("booking_id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Booking</title>
    <link rel="stylesheet" href="css/viewMyBooking.css">
</head>
<body>
    <div class="container">
        <h2>Booking Summary</h2>
        <div class="bill">
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>NIC:</strong> <%= nic %></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Contact:</strong> <%= contact %></p>
            <p><strong>Pickup Location:</strong> <%= pickup %></p>
            <p><strong>Drop Location:</strong> <%= drop %></p>
            <p><strong>Vehicle Type:</strong> <%= vehicle %></p>
            <p><strong>Distance:</strong> <%= distance %> km</p>
            <p><strong>Fare:</strong> Rs. <%= String.format("%.2f", fare) %></p>
            <p><strong>Date:</strong> <%= date %></p>
        </div>
        <form action="GeneratePDFServlet" method="post">
            <input type="hidden" name="customerEmail" value="<%= customerEmail %>">
            <button type="submit" class="btn-download">Download PDF</button>
        </form>

        <!-- Review and Rating Section -->
        <div class="review-section">
            <h2>Leave a Review</h2>
            <form action="SubmitReviewServlet" method="post">
                <input type="hidden" name="customerEmail" value="<%= customerEmail %>">
                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                <div class="form-group">
                    <label for="rating">Rating:</label>
                    <select name="rating" id="rating" required>
                        <option value="1">1 Star</option>
                        <option value="2">2 Stars</option>
                        <option value="3">3 Stars</option>
                        <option value="4">4 Stars</option>
                        <option value="5">5 Stars</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="review">Review:</label>
                    <textarea name="review" id="review" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn-submit">Submit Review</button>
            </form>
        </div>

        <!-- Display Existing Reviews -->
        <div class="reviews-list">
            <h2>Customer Reviews</h2>
            <table>
                <thead>
                    <tr>
                        <th>Rating</th>
                        <th>Review</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                            String reviewSql = "SELECT * FROM reviews WHERE booking_id = ? ORDER BY review_date DESC";
                            pst = conn.prepareStatement(reviewSql);
                            pst.setInt(1, bookingId);
                            rs = pst.executeQuery();

                            while (rs.next()) {
                                int rating = rs.getInt("rating");
                                String reviewText = rs.getString("review_text");
                                String reviewDate = rs.getString("review_date");
                    %>
                                <tr>
                                    <td><%= rating %> Stars</td>
                                    <td><%= reviewText %></td>
                                    <td><%= reviewDate %></td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>