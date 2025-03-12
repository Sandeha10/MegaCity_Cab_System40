<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mega City Cab</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        // Function to validate email format
        function validateEmail() {
            const email = document.getElementById("email").value;
            const emailError = document.getElementById("emailError");
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (email.trim() === "") {
                emailError.textContent = "Email is required";
                emailError.style.color = "red";
                return false;
            } else if (!emailRegex.test(email)) {
                emailError.textContent = "Invalid email format";
                emailError.style.color = "red";
                return false;
            } else {
                emailError.textContent = "";
                return true;
            }
        }

        // Function to validate the form before submission
        function validateForm() {
            const email = document.getElementById("email").value;
            const password = document.getElementById("password").value;
            const emailError = document.getElementById("emailError");
            const passwordError = document.getElementById("passwordError");

            // Reset error messages
            emailError.textContent = "";
            passwordError.textContent = "";

            // Check if email is empty
            if (email.trim() === "") {
                emailError.textContent = "Email is required";
                emailError.style.color = "red";
                return false;
            }

            // Check if password is empty
            if (password.trim() === "") {
                passwordError.textContent = "Password is required";
                passwordError.style.color = "red";
                return false;
            }

            // Validate email format
            if (!validateEmail()) {
                return false;
            }

            return true;
        }

        // Function to show pop-up message for email/password mismatch
        function showErrorPopup(message) {
            alert(message);
        }
    </script>
</head>
<body>

    <div class="container">
        <h1> <b>Mega City Cab Service</b> </h1>
        <h2 style="text-align:left;">Login </h2>
        <form action="LoginServlet" method="post" onsubmit="return validateForm()">
            <div>
                <input type="email" id="email" name="email" placeholder="Enter Email" oninput="validateEmail()">
                <span id="emailError" class="error-message"></span>
            </div>
            <br>
            <div>
                <input type="password" id="password" name="password" placeholder="Enter Password">
                <span id="passwordError" class="error-message"></span>
            </div>
            <br>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>

    <%
        // Check if the user is already logged in
        if (session != null && session.getAttribute("loggedInUser") != null) {
            String role = (String) session.getAttribute("role"); 
            if ("admin".equals(role)) {
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.sendRedirect("customer-dashboard.jsp");
            }
        }

        // Check for login error
        String error = request.getParameter("error");
        if (error != null && error.equals("Email/Password Mismatch")) {
    %>
            <script>
                showErrorPopup("Password is incorrect, please try again.");
            </script>
    <%
        }
    %>

</body>
</html>