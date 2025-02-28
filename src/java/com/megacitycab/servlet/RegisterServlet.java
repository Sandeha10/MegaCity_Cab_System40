package com.megacitycab.servlet;

import com.megacitycab.dao.UserDAO;
import com.megacitycab.model.User;
import com.megacitycab.util.PasswordUtil;  // Import PasswordUtil class
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
        User user = new User(name, email, contact, hashedPassword, "customer");

        // Register the user
        if (UserDAO.registerUser(user)) {
            response.sendRedirect("login.jsp?success=1");
        } else {
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
