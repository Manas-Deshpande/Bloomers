<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN LOGIN</title>
</head>
<body>
<%
    // Get the parameters from the request
    String u = request.getParameter("username");
    String p = request.getParameter("password");

    // Default admin credentials
    String U = "admin";
    String P = "admin123";

    // Null check for username and password to avoid NullPointerException
    if (u != null && p != null) {
        // Check if provided credentials match the default admin credentials
        if (u.equals(U) && p.equals(P)) {
            out.println("<script>");
            out.println("alert('Admin Login Successful!');");
            out.println("window.location.href = 'admin.html';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('Admin Login Unsuccessful');");
            out.println("window.location.href = 'adminlogin.html';");
            out.println("</script>");
        }
    } else {
        out.println("<script>");
        out.println("alert('Please provide both username and password');");
        out.println("window.location.href = 'adminlogin.html';");
        out.println("</script>");
    }
%>
</body>
</html>
