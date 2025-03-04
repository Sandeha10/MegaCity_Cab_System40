<%@ page import="java.util.List" %>
<%@ page import="com.megacitycab.model.User" %>
<%@ page import="com.megacitycab.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Customers</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/viewcustomers.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">All Customers</h2>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    UserDAO userDAO = new UserDAO();
                    List<User> customers = userDAO.getAllCustomers();
                    for (User customer : customers) {
                %>
                <tr>
                    <td><%= customer.getUserId() %></td>
                    <td><%= customer.getName() %></td>
                    <td><%= customer.getEmail() %></td>
                    <td><%= customer.getContact() %></td>
                    <td><%= customer.getRole() %></td>
                    <td>
                        <!-- Delete Button with Modal Trigger -->
                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal<%= customer.getUserId() %>">Delete</button>
                    </td>
                </tr>

                <!-- Delete Confirmation Modal for Each Customer -->
                <div class="modal fade" id="deleteModal<%= customer.getUserId() %>" tabindex="-1" aria-labelledby="deleteModalLabel<%= customer.getUserId() %>" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteModalLabel<%= customer.getUserId() %>">Delete Customer</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete the customer <strong><%= customer.getName() %></strong>?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <form action="DeleteCustomerServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="userId" value="<%= customer.getUserId() %>">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </tbody>
        </table>

        <!-- Success Message Popup -->
        <% if (request.getParameter("success") != null) { %>
            <div id="successMessage" class="alert alert-success text-center">
                Customer deleted successfully!
            </div>
        <% } %>

        <!-- Error Message Popup -->
        <% if (request.getParameter("error") != null) { %>
            <div id="errorMessage" class="alert alert-danger text-center">
                Failed to delete customer.
            </div>
        <% } %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Automatically hide success/error messages after 10 seconds
        setTimeout(function () {
            document.getElementById("successMessage")?.remove();
            document.getElementById("errorMessage")?.remove();
        }, 10000);
    </script>
</body>
</html>