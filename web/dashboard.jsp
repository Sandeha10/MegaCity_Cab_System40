<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.megacitycab.model.User" %>

<%
//    // Retrieve logged-in user from session
//    HttpSession sessionObj = request.getSession(false);
//    User loggedInUser = (sessionObj != null) ? (User) sessionObj.getAttribute("loggedInUser") : null;
//
//    // Redirect to login if user is not logged in or not an admin
//    if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
//        response.sendRedirect("../login.jsp"); // Redirect to login page
//        return;
//    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Mega City Cab</title>
    <link rel="stylesheet" href="../styles/admin.css">
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <h2>Mega City Cab</h2>
            <ul>
                <li><a href="dashboard.jsp">🏠 Dashboard</a></li>
                <li><a href="manage-users.jsp">👥 Manage Users</a></li>
                <li><a href="manage-bookings.jsp">📅 Bookings</a></li>
                <li><a href="manage-vehicles.jsp">🚖 Vehicles</a></li>
                <li><a href="reports.jsp">📊 Reports</a></li>
            </ul>
        </nav>

        <div class="main-content">
            <h1>Welcome, <%= loggedInUser.getName() %> 👋</h1>
            <div class="stats">
                <div class="stat-box">📅 Total Bookings: 100</div>
                <div class="stat-box">🚖 Available Vehicles: 20</div>
                <div class="stat-box">👥 Registered Customers: 50</div>
            </div>
        </div>

        <div class="admin-profile">
            <img src="../images/admin-avatar.png" alt="Admin Avatar">
            <h3><%= loggedInUser.getName() %></h3>
            <p>Role: Admin</p>
            <form action="../AdminLogoutServlet" method="post">
                <button type="submit" class="logout-btn">🚪 Logout</button>
            </form>
        </div>
    </div>
</body>
</html>
