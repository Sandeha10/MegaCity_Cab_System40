<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.megacitycab.model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    User loggedInUser = (sessionObj != null) ? (User) sessionObj.getAttribute("loggedInUser") : null;

    if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Mega City Cab</title>

    <!-- Bootstrap & FontAwesome -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Left Sidebar -->
        <nav class="sidebar">
            <h4 class="sidebar-title">Mega City Cab</h4>
            <ul class="nav flex-column">
                <li><a href="#" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-taxi"></i> Manage Bookings</a></li>
                <li><a href="#"><i class="fas fa-car"></i> Manage Vehicles</a></li>
                <li><a href="#"><i class="fas fa-user-tie"></i> Manage Drivers</a></li>
                <li><a href="#"><i class="fas fa-file-alt"></i> Reports</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <h2>Welcome, <%= loggedInUser.getName() %></h2>
            <p class="text-muted">Admin Panel</p>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <h5><i class="fas fa-book"></i> Bookings</h5>
                        <p>120 Completed</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <h5><i class="fas fa-car"></i> Vehicles</h5>
                        <p>20 Available</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <h5><i class="fas fa-user"></i> Customers</h5>
                        <p>35 Registered</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Sidebar (Admin Profile) -->
        <aside class="right-sidebar">
            <button class="toggle-btn" onclick="toggleProfile()"><i class="fas fa-user-circle"></i></button>
            <div class="profile-container" id="profile-container">
                <img src="../images/admin_avatar.png" alt="Admin Avatar" class="profile-pic">
                <h5><%= loggedInUser.getName() %></h5>
                <p>Administrator</p>
                <form action="adminLogout" method="post">
                    <button type="submit" class="btn btn-danger">Logout</button>
                </form>
            </div>
        </aside>
    </div>
    
    <script>
        function toggleProfile() {
            document.getElementById("profile-container").classList.toggle("active");
        }
    </script>
</body>
</html>
