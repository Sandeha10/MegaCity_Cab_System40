<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    // Database Connection
    String url = "jdbc:mysql://localhost:3306/megacitycab";
    String user = "root";  // Change if needed
    String pass = "";  // Change if needed
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    // Get logged-in customer email from session
    String customerEmail = (String) session.getAttribute("customerEmail");
    String customerName = "";
    String contactNumber = "";

    if (customerEmail != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);

            // Fetch Customer Details
            String query = "SELECT name, contact FROM users WHERE email=?";
            ps = con.prepareStatement(query);
            ps.setString(1, customerEmail);
            rs = ps.executeQuery();

            if (rs.next()) {
                customerName = rs.getString("name");
                contactNumber = rs.getString("contact");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="css/customerdashboard.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

    <!-- Sidebar -->
    <div id="sidebar" class="sidebar">
        <button class="toggle-btn" onclick="toggleSidebar()">=</button>
        <div class="sidebar-content">
            <h3>Welcome, <%= customerName %>!</h3>
            <p><strong>Email:</strong> <%= customerEmail %></p>
            <p><strong>Contact:</strong> <%= contactNumber %></p>
            <h4>Send Inquiry</h4>
            <form action="SendMessageServlet" method="post">
                <textarea name="message" placeholder="Type your message..." required></textarea>
                <button type="submit">Send</button>
            </form>
            <form action="LogoutServlet" method="POST">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>

    <!-- Dashboard Content --> 
    <div class="dashboard">
        <h1>Customer Dashboard</h1>
        <div class="card-container">
            <div class="card" onclick="location.href='makeBooking.jsp'">
                <h3>Make a Booking</h3>
            </div>
            <div class="card" onclick="location.href='viewVehicles.jsp'">
                <h3>View Vehicles</h3>
            </div>
            <div class="card" onclick="location.href='viewMyBooking.jsp'">
                <h3>View My Booking</h3>
            </div>
        </div>
    </div>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("active");
    }
</script>

</body>
</html>
