<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.megacitycab.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Vehicles</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/viewvehicle.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Vehicle Details</h1>
        <div class="row">
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    conn = DBConnection.getConnection();
                    String sql = "SELECT * FROM vehicles";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int vehicleId = rs.getInt("vehicle_id");
                        String vehicleType = rs.getString("vehicle_type");
                        String vehiclePic = rs.getString("vehicle_pic");
                        String vehicleName = rs.getString("vehicle_name");
                        String vehicleColor = rs.getString("vehicle_color");
                        int passengerCapacity = rs.getInt("passenger_capacity");
                        double chargePerKm = rs.getDouble("charge_per_km");
                        int driverId = rs.getInt("driver_id");
            %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    
                    <img src="${pageContext.request.contextPath}/<%= vehiclePic %>" class="card-img-top" alt="Vehicle Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= vehicleName %></h5>
                        <p class="card-text">
                            <strong>Type:</strong> <%= vehicleType %><br>
                            <strong>Color:</strong> <%= vehicleColor %><br>
                            <strong>Capacity:</strong> <%= passengerCapacity %> passengers<br>
                            <strong>Charge per KM:</strong> $<%= chargePerKm %><br>
                            <strong>Driver ID:</strong> <%= driverId %>
                        </p>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>