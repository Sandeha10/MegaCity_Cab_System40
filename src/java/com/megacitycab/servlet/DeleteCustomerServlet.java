package com.megacitycab.servlet;

import com.megacitycab.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        UserDAO userDAO = new UserDAO();
        boolean isDeleted = userDAO.deleteCustomer(userId);

        if (isDeleted) {
            response.sendRedirect("viewCustomers.jsp?success=CustomerDeleted");
        } else {
            response.sendRedirect("viewCustomers.jsp?error=FailedToDelete");
        }
    }
}