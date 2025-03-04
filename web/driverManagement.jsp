<%@ page import="java.sql.*" %>
<%@ page import="com.megacitycab.util.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
    // Fetch Admin Info from Session
    String adminName = (String) session.getAttribute("adminName");

    // Database Connection
    Connection conn = DBConnection.getConnection();
    List<String[]> drivers = new ArrayList<>();

    // Fetch Drivers
    try {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM drivers");
        while (rs.next()) {
            String[] driver = {
                rs.getString("driver_id"),
                rs.getString("driver_name"),
                rs.getString("driver_nic"),
                rs.getString("driver_dl_number"),
                rs.getString("driver_address"),
                rs.getString("driver_email"),
                rs.getString("driver_contact")
            };
            drivers.add(driver);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Display Success Message
    String successMessage = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/drivermanagement.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center my-4">Driver Management</h1>

        <!-- Success Message -->
        <% if (successMessage != null) { %>
            <div class="alert alert-success text-center">
                <%= successMessage %>
            </div>
        <% } %>

        <div class="row">
            <div class="col-md-6">
                <button class="btn btn-primary" onclick="openDriverForm()">Add New Driver</button>
            </div>
            <div class="col-md-6">
                <button class="btn btn-success" onclick="viewDrivers()">View Drivers</button>
            </div>
        </div>

        <!-- Add Driver Form (Popup) -->
        <div id="driverFormPopup" class="popup">
            <div class="popup-content">
                <h2>Add New Driver</h2>
                <form action="DriverServlet" method="POST">
                    <input type="hidden" name="action" value="add">
                    <input type="text" name="driverName" placeholder="Driver Name" required>
                    <input type="text" name="driverNIC" placeholder="Driver NIC (12 digits)" maxlength="12" required>
                    <input type="text" name="driverDL" placeholder="Driver DL Number" required>
                    <input type="text" name="driverAddress" placeholder="Driver Address" required>
                    <input type="email" name="driverEmail" placeholder="Driver Email" required>
                    <input type="text" name="driverContact" placeholder="Driver Contact Number" required>
                    <button type="submit" class="btn btn-primary">Register Driver</button>
                    <button type="button" class="btn btn-secondary" onclick="closeDriverForm()">Close</button>
                </form>
            </div>
        </div>

        <!-- Edit Driver Form (Popup) -->
        <div id="editDriverFormPopup" class="popup">
            <div class="popup-content">
                <h2>Edit Driver</h2>
                <form action="DriverServlet" method="POST">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="driverId" id="editDriverId">
                    <input type="text" name="driverName" id="editDriverName" placeholder="Driver Name" required>
                    <input type="text" name="driverNIC" id="editDriverNIC" placeholder="Driver NIC (12 digits)" maxlength="12" required>
                    <input type="text" name="driverDL" id="editDriverDL" placeholder="Driver DL Number" required>
                    <input type="text" name="driverAddress" id="editDriverAddress" placeholder="Driver Address" required>
                    <input type="email" name="driverEmail" id="editDriverEmail" placeholder="Driver Email" required>
                    <input type="text" name="driverContact" id="editDriverContact" placeholder="Driver Contact Number" required>
                    <button type="submit" class="btn btn-primary">Update Driver</button>
                    <button type="button" class="btn btn-secondary" onclick="closeEditDriverForm()">Close</button>
                </form>
            </div>
        </div>

        <!-- View Drivers Section -->
        <div id="driversList" class="mt-4">
            <h2>Registered Drivers</h2>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>NIC</th>
                        <th>DL Number</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] driver : drivers) { %>
                        <tr>
                            <td><%= driver[0] %></td>
                            <td><%= driver[1] %></td>
                            <td><%= driver[2] %></td>
                            <td><%= driver[3] %></td>
                            <td><%= driver[4] %></td>
                            <td><%= driver[5] %></td>
                            <td><%= driver[6] %></td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="openEditDriverForm('<%= driver[0] %>', '<%= driver[1] %>', '<%= driver[2] %>', '<%= driver[3] %>', '<%= driver[4] %>', '<%= driver[5] %>', '<%= driver[6] %>')">Edit</button>
                                <form action="DriverServlet" method="POST" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="driverId" value="<%= driver[0] %>">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this driver?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Open Add Driver Form
        function openDriverForm() {
            document.getElementById("driverFormPopup").style.display = "block";
        }

        // Close Add Driver Form
        function closeDriverForm() {
            document.getElementById("driverFormPopup").style.display = "none";
        }

        // Open Edit Driver Form
        function openEditDriverForm(driverId, driverName, driverNIC, driverDL, driverAddress, driverEmail, driverContact) {
            document.getElementById("editDriverId").value = driverId;
            document.getElementById("editDriverName").value = driverName;
            document.getElementById("editDriverNIC").value = driverNIC;
            document.getElementById("editDriverDL").value = driverDL;
            document.getElementById("editDriverAddress").value = driverAddress;
            document.getElementById("editDriverEmail").value = driverEmail;
            document.getElementById("editDriverContact").value = driverContact;
            document.getElementById("editDriverFormPopup").style.display = "block";
        }

        // Close Edit Driver Form
        function closeEditDriverForm() {
            document.getElementById("editDriverFormPopup").style.display = "none";
        }

        // View Drivers
        function viewDrivers() {
            document.getElementById("driversList").style.display = "block";
        }
    </script>
</body>
</html>