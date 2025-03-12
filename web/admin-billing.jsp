<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Bill </title>
    <link rel="stylesheet" href="css/admin-billing.css">
</head>
<body>
    <div class="container">
        <h2><b>Generate Bill</b></h2>
        <div class="button-group">
            <button id="viewBookingsBtn">View Bookings</button>
            <button id="generateBillBtn">Generate Bill</button>
        </div>

        <!-- Bookings Table -->
        <div id="bookingsTable" class="table-container">
            <h3>All Bookings</h3>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer Name</th>
                        <th>NIC</th>
                        <th>Pickup Location</th>
                        <th>Drop Location</th>
                        <th>Vehicle Name</th>
                        <th>Fare (Rs)</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

                            String sql = "SELECT * FROM bookings";
                            pst = conn.prepareStatement(sql);
                            rs = pst.executeQuery();

                            while (rs.next()) {
                    %>
                                <tr>
                                    <td><%= rs.getInt("booking_id") %></td>
                                    <td><%= rs.getString("customer_name") %></td>
                                    <td><%= rs.getString("nic") %></td>
                                    <td><%= rs.getString("pickup_location") %></td>
                                    <td><%= rs.getString("drop_location") %></td>
                                    <td><%= rs.getString("vehicle_name") %></td>
                                    <td><%= rs.getDouble("fare") %></td>
                                    <td><%= rs.getString("booking_date") %></td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Generate Bill Popup -->
        <div id="generateBillModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Generate Bill</h2>
                <form id="billForm" action="GenerateBillServlet" method="post">
                    <div class="form-group">
                        <label for="billNo">Bill No:</label>
                        <input type="text" id="billNo" name="billNo" required>
                    </div>
                    <div class="form-group">
                        <label for="customerName">Customer Name:</label>
                        <select id="customerName" name="customerName" required>
                            <%
                                try {
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                                    String sql = "SELECT DISTINCT customer_name, nic FROM bookings";
                                    pst = conn.prepareStatement(sql);
                                    rs = pst.executeQuery();

                                    while (rs.next()) {
                            %>
                                        <option value="<%= rs.getString("customer_name") %>"><%= rs.getString("customer_name") %></option>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (pst != null) pst.close();
                                    if (conn != null) conn.close();
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="customerNic">Customer NIC:</label>
                        <select id="customerNic" name="customerNic" required>
                            <%
                                try {
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                                    String sql = "SELECT DISTINCT nic FROM bookings";
                                    pst = conn.prepareStatement(sql);
                                    rs = pst.executeQuery();

                                    while (rs.next()) {
                            %>
                                        <option value="<%= rs.getString("nic") %>"><%= rs.getString("nic") %></option>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) rs.close();
                                    if (pst != null) pst.close();
                                    if (conn != null) conn.close();
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="customerEmail">Customer Email:</label>
                        <input type="email" id="customerEmail" name="customerEmail" required>
                    </div>
                    <div class="form-group">
                        <label for="pickupLocation">Pickup Location:</label>
                        <input type="text" id="pickupLocation" name="pickupLocation" required>
                    </div>
                    <div class="form-group">
                        <label for="dropLocation">Drop Location:</label>
                        <input type="text" id="dropLocation" name="dropLocation" required>
                    </div>
                    <div class="form-group">
                        <label for="vehicleName">Vehicle Name:</label>
                        <input type="text" id="vehicleName" name="vehicleName" required>
                    </div>
                    <div class="form-group">
                        <label for="fare">Fare (Rs):</label>
                        <input type="number" id="fare" name="fare" required>
                    </div>
                    <button type="submit" class="btn-submit">Generate Bill</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // JavaScript to handle the modal
        const modal = document.getElementById("generateBillModal");
        const generateBillBtn = document.getElementById("generateBillBtn");
        const closeBtn = document.getElementsByClassName("close")[0];

        // Open the modal when the "Generate Bill" button is clicked
        generateBillBtn.onclick = function() {
            modal.style.display = "block";
        };

        // Close the modal when the close button is clicked
        closeBtn.onclick = function() {
            modal.style.display = "none";
        };

        // Close the modal when clicking outside of it
        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };

        // Handle form submission
        document.getElementById("billForm").addEventListener("submit", function(event) {
            // Allow the form to submit
            alert("Bill generated successfully!");
            modal.style.display = "none";
        });
    </script>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if (success != null && success.equals("1")) {
    %>
            <script>
                alert("Bill generated successfully!");
            </script>
    <%
        }

        if (error != null && error.equals("1")) {
    %>
            <script>
                alert("Error generating bill. Please try again.");
            </script>
    <%
        }
    %>
</body>
</html>