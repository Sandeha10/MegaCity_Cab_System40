<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.megacitycab.model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    User loggedInUser = (sessionObj != null) ? (User) sessionObj.getAttribute("loggedInUser") : null;

    if (loggedInUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="../web/css/">
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= loggedInUser.getName() %>!</h2>
        <p>Email: <%= loggedInUser.getEmail() %></p>
        <p>Contact: <%= loggedInUser.getContact() %></p>
        <form action="../LogoutServlet" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
</body>
</html>
