package com.megacitycab.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminLogout")
public class AdminLogoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session and invalidate it
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();  // Invalidate the session
        }

        // Redirect to the login page after logout
        response.sendRedirect("login.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Call doPost method for GET requests as well
        doPost(request, response);
    }
}
