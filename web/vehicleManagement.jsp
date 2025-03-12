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
    List<String[]> vehicles = new ArrayList<>();

    // Fetch Drivers
    try {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM drivers");
        while (rs.next()) {
            String[] driver = {
                rs.getString("driver_id"),
                rs.getString("driver_name")
            };
            drivers.add(driver);
        }

        // Fetch Vehicles
        ResultSet rsVehicles = stmt.executeQuery("SELECT * FROM vehicles");
        while (rsVehicles.next()) {
            String[] vehicle = {
                rsVehicles.getString("vehicle_id"),
                rsVehicles.getString("vehicle_type"),
                rsVehicles.getString("vehicle_pic"),
                rsVehicles.getString("vehicle_name"),
                rsVehicles.getString("vehicle_color"),
                rsVehicles.getString("passenger_capacity"),
                rsVehicles.getString("charge_per_km"),
                rsVehicles.getString("driver_id")
            };
            vehicles.add(vehicle);
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
    <title>Vehicle Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/vehiclemanagement.css">
</head>
<body>
    <div class="container">
        <h1 class="text-center my-4">Vehicle Management</h1>

        <!-- Success Message Popup -->
        <% if (successMessage != null) { %>
            <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="successModalLabel">Success</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <%= successMessage %>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>

        <!-- Management Button -->
        <div class="text-center mb-4">
            <button class="btn btn-info" onclick="viewVehicles()">Manage Vehicles</button>
        </div>

        <!-- Car Section -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h2>Car Management</h2>
            </div>
            <div class="card-body">
                <form action="VehicleServlet" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="addCar">
                    <div class="mb-3">
                        <label for="carPic" class="form-label">Car Picture</label>
                        <input type="file" class="form-control" id="carPic" name="carPic" required>
                    </div>
                    <div class="mb-3">
                        <label for="carName" class="form-label">Car Name</label>
                        <input type="text" class="form-control" id="carName" name="carName" required>
                    </div>
                    <div class="mb-3">
                        <label for="carColor" class="form-label">Car Color</label>
                        <input type="text" class="form-control" id="carColor" name="carColor" required>
                    </div>
                    <div class="mb-3">
                        <label for="carPassengers" class="form-label">Passenger Capacity</label>
                        <input type="number" class="form-control" id="carPassengers" name="carPassengers" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="carCharge" class="form-label">Charge per Km (Rs)</label>
                        <input type="number" step="0.01" class="form-control" id="carCharge" name="carCharge" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="carDriver" class="form-label">Assign Driver</label>
                        <select class="form-select" id="carDriver" name="carDriver" required>
                            <option value="">Select Driver</option>
                            <% for (String[] driver : drivers) { %>
                                <option value="<%= driver[0] %>"><%= driver[1] %></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Add Car</button>
                </form>
            </div>
        </div>

        <!-- Van Section -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white">
                <h2>Van Management</h2>
            </div>
            <div class="card-body">
                <form action="VehicleServlet" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="addVan">
                    <div class="mb-3">
                        <label for="vanPic" class="form-label">Van Picture</label>
                        <input type="file" class="form-control" id="vanPic" name="vanPic" required>
                    </div>
                    <div class="mb-3">
                        <label for="vanName" class="form-label">Van Name</label>
                        <input type="text" class="form-control" id="vanName" name="vanName" required>
                    </div>
                    <div class="mb-3">
                        <label for="vanColor" class="form-label">Van Color</label>
                        <input type="text" class="form-control" id="vanColor" name="vanColor" required>
                    </div>
                    <div class="mb-3">
                        <label for="vanPassengers" class="form-label">Passenger Capacity</label>
                        <input type="number" class="form-control" id="vanPassengers" name="vanPassengers" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="vanCharge" class="form-label">Charge per Km (Rs)</label>
                        <input type="number" step="0.01" class="form-control" id="vanCharge" name="vanCharge" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="vanDriver" class="form-label">Assign Driver</label>
                        <select class="form-select" id="vanDriver" name="vanDriver" required>
                            <option value="">Select Driver</option>
                            <% for (String[] driver : drivers) { %>
                                <option value="<%= driver[0] %>"><%= driver[1] %></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-success">Add Van</button>
                </form>
            </div>
        </div>

        <!-- Vehicle List Section -->
        <div id="vehicleList" class="mt-4" style="display: none;">
            <h2>Vehicle List</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Picture</th>
                        <th>Name</th>
                        <th>Color</th>
                        <th>Passengers</th>
                        <th>Charge per Km</th>
                        <th>Driver ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String[] vehicle : vehicles) { %>
                        <tr>
                            <td><%= vehicle[0] %></td>
                            <td><%= vehicle[1] %></td>
                            <td><img src="uploads/<%= vehicle[2] %>" alt="Vehicle Pic" width="100"></td>
                            <td><%= vehicle[3] %></td>
                            <td><%= vehicle[4] %></td>
                            <td><%= vehicle[5] %></td>
                            <td><%= vehicle[6] %></td>
                            <td><%= vehicle[7] %></td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="openEditVehicleForm('<%= vehicle[0] %>', '<%= vehicle[1] %>', '<%= vehicle[2] %>', '<%= vehicle[3] %>', '<%= vehicle[4] %>', '<%= vehicle[5] %>', '<%= vehicle[6] %>', '<%= vehicle[7] %>')">Edit</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteVehicle('<%= vehicle[0] %>')">Delete</button>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Edit Vehicle Popup -->
    <div id="editVehiclePopup" class="modal fade" tabindex="-1" aria-labelledby="editVehiclePopupLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editVehiclePopupLabel">Edit Vehicle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="VehicleServlet" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="vehicleId" id="editVehicleId">
                        <input type="hidden" name="currentPic" id="editCurrentPic">
                        <div class="mb-3">
                            <label for="editVehicleType" class="form-label">Vehicle Type</label>
                            <select class="form-select" id="editVehicleType" name="vehicleType" required>
                                <option value="car">Car</option>
                                <option value="van">Van</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editVehiclePic" class="form-label">Vehicle Picture</label>
                            <input type="file" class="form-control" id="editVehiclePic" name="vehiclePic">
                        </div>
                        <div class="mb-3">
                            <label for="editVehicleName" class="form-label">Vehicle Name</label>
                            <input type="text" class="form-control" id="editVehicleName" name="vehicleName" required>
                        </div>
                        <div class="mb-3">
                            <label for="editVehicleColor" class="form-label">Vehicle Color</label>
                            <input type="text" class="form-control" id="editVehicleColor" name="vehicleColor" required>
                        </div>
                        <div class="mb-3">
                            <label for="editVehiclePassengers" class="form-label">Passenger Capacity</label>
                            <input type="number" class="form-control" id="editVehiclePassengers" name="passengerCapacity" min="1" required>
                        </div>
                        <div class="mb-3">
                            <label for="editVehicleCharge" class="form-label">Charge per Km (Rs)</label>
                            <input type="number" step="0.01" class="form-control" id="editVehicleCharge" name="chargePerKm" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label for="editVehicleDriver" class="form-label">Assign Driver</label>
                            <select class="form-select" id="editVehicleDriver" name="driverId" required>
                                <option value="">Select Driver</option>
                                <% for (String[] driver : drivers) { %>
                                    <option value="<%= driver[0] %>"><%= driver[1] %></option>
                                <% } %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Update Vehicle</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Show Success Modal -->
    <script>
        <% if (successMessage != null) { %>
            document.addEventListener("DOMContentLoaded", function() {
                var successModal = new bootstrap.Modal(document.getElementById('successModal'));
                successModal.show();
            });
        <% } %>
    </script>

    <!-- Show Vehicle List -->
    <script>
        function viewVehicles() {
            document.getElementById("vehicleList").style.display = "block";
        }
    </script>

    <!-- Open Edit Vehicle Form -->
    <script>
        function openEditVehicleForm(vehicleId, vehicleType, vehiclePic, vehicleName, vehicleColor, passengerCapacity, chargePerKm, driverId) {
            document.getElementById("editVehicleId").value = vehicleId;
            document.getElementById("editVehicleType").value = vehicleType;
            document.getElementById("editCurrentPic").value = vehiclePic;
            document.getElementById("editVehicleName").value = vehicleName;
            document.getElementById("editVehicleColor").value = vehicleColor;
            document.getElementById("editVehiclePassengers").value = passengerCapacity;
            document.getElementById("editVehicleCharge").value = chargePerKm;
            document.getElementById("editVehicleDriver").value = driverId;

            var editVehiclePopup = new bootstrap.Modal(document.getElementById('editVehiclePopup'));
            editVehiclePopup.show();
        }
    </script>

    <!-- Delete Vehicle -->
    <script>
        function deleteVehicle(vehicleId) {
            if (confirm("Are you sure you want to delete this vehicle?")) {
                // Create a form dynamically
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "VehicleServlet";

                // Add action parameter
                const actionInput = document.createElement("input");
                actionInput.type = "hidden";
                actionInput.name = "action";
                actionInput.value = "delete";
                form.appendChild(actionInput);

                // Add vehicleId parameter
                const vehicleIdInput = document.createElement("input");
                vehicleIdInput.type = "hidden";
                vehicleIdInput.name = "vehicleId";
                vehicleIdInput.value = vehicleId;
                form.appendChild(vehicleIdInput);

                // Append the form to the body and submit it
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>

    <!-- Validate Form -->
    <script>
        function validateForm() {
            // Validate Passenger Capacity
            const carPassengers = document.getElementById("carPassengers");
            const vanPassengers = document.getElementById("vanPassengers");

//            if (carPassengers && carPassengers.value <= 0) {
//                alert("Passenger Capacity must be greater than 0.");
//                return false;
//            }
//
//            if (vanPassengers && vanPassengers.value <= 0) {
//                alert("Passenger Capacity must be greater than 0.");
//                return false;
//            }

            // Validate Charge per Km
            const carCharge = document.getElementById("carCharge");
            const vanCharge = document.getElementById("vanCharge");

            if (carCharge && carCharge.value < 0) {
                alert("Charge per Km cannot be negative.");
                return false;
            }

            if (vanCharge && vanCharge.value < 0) {
                alert("Charge per Km cannot be negative.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>