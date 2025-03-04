<%@ page import="java.sql.*" %>
<%@ page import="com.megacitycab.util.DBConnection" %>
<%@ page import="java.util.List, com.megacitycab.model.User" %>
<%@ page import="com.megacitycab.dao.UserDAO" %>
<%@ page session="true" %>
<%
    // Fetch Admin Info from Session
    String adminName = (String) session.getAttribute("adminName");
    String adminEmail = (String) session.getAttribute("adminEmail");
    String adminContact = (String) session.getAttribute("adminContact");

    Connection conn = DBConnection.getConnection();
    
    // Count Queries
    int totalBookings = 0, totalCustomers = 0, totalDrivers = 0;

    try {
        Statement stmt = conn.createStatement();
        
        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM bookings");
        if (rs1.next()) totalBookings = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM user WHERE role='customer'");
        if (rs2.next()) totalCustomers = rs2.getInt(1);

        ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM drivers");
        if (rs3.next()) totalDrivers = rs3.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="bootstrap.min.css">
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="admin-info">
                <h3><%= adminName %></h3>
                <p><%= adminEmail %></p>
                <p>? <%= adminContact %></p>
            </div>
            <nav>
                <ul>
                    <li><a href="viewavailables.jsp"> View Available Bookings</a></li>
                    <li><a href="viewCustomers.jsp">View All Customers</a></li>
                    <li><a href="driverManagement.jsp">Driver Management</a></li>
                    <li><a href="vehicleManagement.jsp"> Vehicle Management</a></li>
                    <button id="createAdminBtn" class="btn btn-gradient w-100 mt-2"> Create Admin</button>
                </ul>
            </nav>
            <form action="LogoutServlet" method="POST">
                <button type="submit" class="logout btn btn-danger w-100 mt-3">Logout</button>
            </form>
        </aside>

        <!-- Main Content -->
        <main class="dashboard-content">
            <h1> Mega City Cab Service</h1>
            <h2> Dashboard Overview</h2>
            <div class="card-container">
                <div class="card">
                    <h3>Total Bookings</h3>
                    <p><%= totalBookings %></p>
                </div>
                <div class="card">
                    <h3>Total Customers</h3>
                    <p><%= totalCustomers %></p>
                </div>
                <div class="card">
                    <h3>Total Drivers</h3>
                    <p><%= totalDrivers %></p>
                </div>
            </div>
        </main>
    </div>

    <!-- Create Admin Popup -->
    <div id="createAdminPopup" class="popup">
        <div class="popup-content">
            <h2>Create New Admin</h2>
            <form action="AdminServlet" method="post">
                <input type="text" name="name" placeholder="Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="text" name="contact" placeholder="Contact Number" required>
                <input type="password" name="password" placeholder="Password" required>
                <select name="role">
                    <option value="admin">Admin</option>
                    <option value="customer">Customer</option>
                </select>
                <button type="submit">Create Admin</button>
            </form>
            <button id="closePopup"> Close</button>
        </div>
    </div>

    <script src="create-admin.js"></script>
    
<%    
    UserDAO userDAO = new UserDAO();
    List<User> adminList = userDAO.getAllAdmins();
%>

<!-- Sidebar (Add Admin Button) -->
<button id="createAdminBtn" class="btn btn-primary w-100 mt-2">? Create Admin</button>

<!-- Admin Table -->
<h2 class="mt-4"> Admin List</h2>
<table class="table table-hover mt-3">
    <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Email</th>
            <th>Contact</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <% int index = 1;
           for (User admin : adminList) { %>
            <tr>
                <td><%= index++ %></td>
                <td><%= admin.getName() %></td>
                <td><%= admin.getEmail() %></td>
                <td><%= admin.getContact() %></td>
                <td>
                    <form action="AdminServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="adminId" value="<%= admin.getUserId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>

<!-- Admin Creation Form (Popup) -->
<div id="popup" class="popup">
    <div class="popup-content">
        <h2> Add New Admin</h2>
        <form action="AdminServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="text" name="contact" placeholder="Contact Number" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit"> Create Admin</button>
            <button type="button" id="closePopup" onclick="window.location.href='admin-dashboard.jsp'"> Cancel</button>
        </form>
    </div>
</div>

<script>
    document.getElementById("createAdminBtn").addEventListener("click", function () {
        document.getElementById("popup").style.display = "flex";
    });
    document.getElementById("closePopup").addEventListener("click", function () {
        document.getElementById("popup").style.display = "none";
    });
</script>
    
    
    
</body>
</html>



