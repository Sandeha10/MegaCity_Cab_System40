package com.megacitycab.servlet;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import com.megacitycab.util.PasswordUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");

        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(password);

        // Create a new User object
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setContact(contact);
        user.setPasswordHash(hashedPassword); // Use setPasswordHash instead of setPassword
        user.setRole("customer"); // Set default role to "customer"

        // Register the user
        if (UserDAO.registerUser(user)) {
            response.sendRedirect("register.jsp?success=1");
        } else {
            response.sendRedirect("register.jsp?error=1");
        }
    }
}