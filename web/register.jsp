<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %> <!-- Corrected import -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Mega City Cab</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="container">
        <h2>Create Your Account</h2>
        <!-- Check if there's an error message in the URL -->
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null && errorMessage.equals("1")) {
        %>
            <p style="color: red;">There was an error during registration. Please try again.</p>
        <%
            }
        %>
        <form action="RegisterServlet" method="post">
            <input type="text" name="name" placeholder="Enter Name" required><br><br>
            <input type="email" name="email" placeholder="Enter Email" required><br><br>
            <input type="text" name="contact" placeholder="Enter Contact Number" required><br><br>
            <input type="password" name="password" placeholder="Enter Password" required><br><br>
            <button type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

    <%
        // Check if the user is already logged in (session exists)
        if (session != null && session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("role"); // Get the role from session (admin or user)
            if (role != null && role.equals("admin")) {
                response.sendRedirect("admin/dashboard.jsp"); // Redirect to admin dashboard if already logged in as admin
            } else {
                response.sendRedirect("user/dashboard.jsp"); // Redirect to user dashboard if already logged in as user
            }
        }
    %>

</body>
</html> 
