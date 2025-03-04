package com.megacitycab.servlet;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate credentials
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmailAndPassword(email, password);

        if (user != null) {
            // Create session after successful login
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setAttribute("role", user.getRole()); // Save the user role in session
            session.setAttribute("customerEmail", user.getEmail()); // Save customer email in session

            // Redirect to respective dashboard
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.sendRedirect("customer-dashboard.jsp");
            }
        } else {
            // If authentication fails, redirect back to login page
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    }
}
