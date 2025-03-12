<%@ page import="java.sql.*" %>
<%@ page import="com.megacitycab.util.DBConnection" %>
<%@ page session="true" %>
<%
    // Fetch Admin Info from Session
    String adminName = (String) session.getAttribute("adminName");
    String adminEmail = (String) session.getAttribute("adminEmail");
    String adminContact = (String) session.getAttribute("adminContact");

    Connection conn = DBConnection.getConnection();
    ResultSet rs = null;
    try {
        Statement stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM inquiries ORDER BY created_at DESC");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Inquiries</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/viewInquiries.css">
    <link rel="stylesheet" href="css/admin.css.css">
</head>
<body>
    

        <!-- Main Content -->
        <main class="dashboard-content">
            
            <h2> <b>All Inquiries</b></h2>
            <div class="table-container">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Email</th>
                            <th>Message</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int index = 1;
                           while (rs != null && rs.next()) { %>
                            <tr>
                                <td><%= index++ %></td>
                                <td><%= rs.getString("customer_email") %></td>
                                <td><%= rs.getString("message") %></td>
                                <td><%= rs.getTimestamp("created_at") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    try {
        if (conn != null) conn.close();
        if (rs != null) rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>