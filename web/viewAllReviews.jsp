<%@ page import="java.sql.*" %>
<%@ page import="com.megacitycab.util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>

<%
    // Check if admin is logged in
   

    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab"; // Ensure the port is correct (3306 is default for MySQL)
    String dbUser = "root";
    String dbPassword = "";

    // Declare variables outside the try block
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Query to fetch all reviews
        String sql = "SELECT * FROM reviews ORDER BY review_date DESC";
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Reviews</title>
    <link rel="stylesheet" href="css/viewAllReviews.css"> <!-- Ensure this CSS file exists -->
</head>
<body>
    <div class="container">
        <h2>All Reviews</h2>
        <% if (request.getParameter("deleteSuccess") != null) { %>
            <div class="success-message">Review deleted successfully!</div>
        <% } %>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Customer Email</th>
                    <th>Booking ID</th>
                    <th>Rating</th>
                    <th>Review</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% int index = 1;
                   while (rs != null && rs.next()) { %>
                    <tr>
                        <td><%= index++ %></td>
                        <td><%= rs.getString("customer_email") %></td>
                        <td><%= rs.getInt("booking_id") %></td>
                        <td><%= rs.getInt("rating") %> Stars</td>
                        <td><%= rs.getString("review_text") %></td>
                        <td><%= rs.getTimestamp("review_date") %></td>
                        <td>
                            <form action="DeleteReviewServlet" method="post" style="display:inline;">
                                <input type="hidden" name="reviewId" value="<%= rs.getInt("review_id") %>">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
<%
    // Close database resources
    try {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (conn != null) conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>