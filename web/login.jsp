<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %> <!-- Corrected import -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cab</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="container">
        <h2>Login to Your Account</h2>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Enter Email" required><br><br>
            <input type="password" name="password" placeholder="Enter Password" required><br><br>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>

    <%
        // Check if the user is already logged in (session exists)
        if (session != null && session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("role"); // Get the role from session (admin or user)
            if (role != null && role.equals("admin")) {
                response.sendRedirect("admin/dashboard.jsp"); // Redirect to admin dashboard if already logged in as admin
            } else {
                response.sendRedirect("customer-dashboard.jsp"); // Redirect to user dashboard if already logged in as user
            }
        }
    %>

</body>
</html> 
