package com.megacitycab.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/initDB")  // This will map the servlet to /initDB
public class DatabaseConnectionServlet extends HttpServlet {
    public void init() throws ServletException {
        // Database connection parameters
        String dbUrl = "jdbc:mysql://localhost:3306/megacitycab";
        String dbUser = "root";
        String dbPassword = "password";

        try {
            // Create a connection to the database
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            // Set the connection as an attribute in the ServletContext
            getServletContext().setAttribute("DBConnection", conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
