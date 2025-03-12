<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Mega City Cab</title>
    <link rel="stylesheet" href="css/register.css">
    <script>
        function validateForm() {
            var name = document.forms["registerForm"]["name"].value;
            var email = document.forms["registerForm"]["email"].value;
            var contact = document.forms["registerForm"]["contact"].value;
            var password = document.forms["registerForm"]["password"].value;

            if (name == "" || email == "" || contact == "" || password == "") {
                document.getElementById("errorMessage").innerHTML = "All fields are required";
                return false;
            }
            return true;
        }

        function showSuccessMessage() {
            alert("Registration successful!");
        }
    </script>
</head>
<body>

    <div class="container">
        <h1><b>Mega City Cab Service</b></h1>
        <h2 style="text-align:left;"> Register</h2>
        <%
            String errorMessage = request.getParameter("error");
            if (errorMessage != null && errorMessage.equals("1")) {
        %>
            <p style="color: red;">There was an error during registration. Please try again.</p>
        <%
            }
        %>
        <form name="registerForm" action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <input type="text" name="name" placeholder="Enter Name"><br><br>
            <input type="email" name="email" placeholder="Enter Email"><br><br>
            <input type="text" name="contact" placeholder="Enter Contact Number"><br><br>
            <input type="password" name="password" placeholder="Enter Password"><br><br>
            <button type="submit">Register</button>
        </form>
        <p id="errorMessage" style="color: red;"></p>
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

        // Check if registration was successful
        String success = request.getParameter("success");
        if (success != null && success.equals("1")) {
    %>
            <script>
                showSuccessMessage();
                window.location.href = "login.jsp"; // Redirect to login page after showing the success message
            </script>
    <%
        }
    %>

</body>
</html>