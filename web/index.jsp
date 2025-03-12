<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab Service</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/index.css">
</head>
<body>

    <!-- Main Content -->
    <div class="container-fluid hero-section">
        <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-6 text-center">
                <h1 class="display-4 fw-bold">Welcome to Mega City Cab Services</h1>
                <p class="lead">Your reliable cab service in the city!</p>
                <div class="buttons mt-4">
                    <a href="login.jsp" class="btn btn-primary btn-lg me-3">Login</a>
                    <a href="register.jsp" class="btn btn-success btn-lg">Register</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="container my-5">
        <h2 class="text-center mb-4">Customer Reviews</h2>
        <div class="row">
            <%
                // Database connection details
                String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab";
                String dbUser = "root";
                String dbPassword = "";

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

                    // Loop through the result set and display reviews
                    while (rs != null && rs.next()) {
                        String customerEmail = rs.getString("customer_email");
                        String reviewText = rs.getString("review_text");
                        int rating = rs.getInt("rating");
                        Timestamp reviewDate = rs.getTimestamp("review_date");
            %>
                        <div class="col-md-4 mb-4">
                            <div class="card review-card">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="fas fa-user"></i> <%= customerEmail %></h5>
                                    <p class="card-text"><i class="fas fa-comment"></i> <%= reviewText %></p>
                                    <p class="card-text">
                                        <i class="fas fa-star"></i> Rating: <%= rating %> Stars
                                    </p>
                                    <p class="card-text text-muted">
                                        <small><i class="fas fa-calendar-alt"></i> <%= reviewDate %></small>
                                    </p>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close database resources
                    try {
                        if (rs != null) rs.close();
                        if (pst != null) pst.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-dark text-white mt-5">
        <div class="container py-5">
            <div class="row">
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <p><i class="fas fa-phone"></i> +94 41 312 6567</p>
                    <p><i class="fas fa-envelope"></i> info@megacitycab.com</p>
                    <p><i class="fas fa-map-marker-alt"></i> 123 Main Street, Matara, Sri Lanka</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Home</a></li>
                        <li><a href="#" class="text-white">About Us</a></li>
                        <li><a href="#" class="text-white">Services</a></li>
                        <li><a href="#" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Follow Us</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white"><i class="fab fa-facebook"></i> Facebook</a></li>
                        <li><a href="#" class="text-white"><i class="fab fa-twitter"></i> Twitter</a></li>
                        <li><a href="#" class="text-white"><i class="fab fa-instagram"></i> Instagram</a></li>
                        <li><a href="#" class="text-white"><i class="fab fa-linkedin"></i> LinkedIn</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="text-center py-3" style="background-color: rgba(0, 0, 0, 0.2);">
            &copy; 2025 Mega City Cab Service. All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap JS and Font Awesome -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>