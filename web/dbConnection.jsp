<%@ page import="java.sql.Connection" %>
<%@ page import="com.megacitycab.util.DBConnection" %>

<%
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        if (conn != null) {
            out.println("<!-- Database Connection Successful -->"); // Hidden in HTML source
        } else {
            out.println("<!-- Database Connection Failed -->");
        }
    } catch (Exception e) {
        out.println("<!-- Database Connection Error: " + e.getMessage() + " -->");
        e.printStackTrace();
    }
%>
