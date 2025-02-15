<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    String e = request.getParameter("email");
    String p = request.getParameter("new_password");
    String re = request.getParameter("confirm_password");
    
    if (e == null || p == null || re == null || e.isEmpty() || p.isEmpty() || re.isEmpty()) {
        out.println("<script>");
        out.println("window.alert('All fields are required!');");
        out.println("window.history.back();");
        out.println("</script>");
    } else if (!p.equals(re)) {
        out.println("<script>");
        out.println("window.alert('new-password and confirm-password do not match');");
        out.println("window.history.back();");
        out.println("</script>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers", "root", "");
            String query = "UPDATE register SET password = ? WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, p);
            ps.setString(2, e);
            int i = ps.executeUpdate();
            
            if (i != 0) {
                out.println("<script>");
                out.println("window.alert('Password Changed Successfully');");
                out.println("window.location.href='login.html';");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("window.alert('Email not found or password not updated');");
                out.println("window.history.back();");
                out.println("</script>");
            }
        } catch (Exception ex) {
            out.println("Error: " + ex.getMessage());
        }
    }
%>
</body>
</html>