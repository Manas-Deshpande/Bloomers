<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback</title>
</head>
<body>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String feedback = request.getParameter("feedback");
    String rating = request.getParameter("rating");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        if (name != null && email != null && feedback != null && rating != null) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers", "root", "");

            String query = "INSERT INTO feedback (name, email, feedback, rating) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, feedback);
            ps.setString(4, rating);

            int i = ps.executeUpdate();

            if (i != 0) {
                out.println("<script>");
                out.println("window.alert('Record Inserted Successfully, Thank you for your feedback!');");
                out.println("window.location.href='index.html';");
                out.println("</script>");
            }
        } else {
            out.println("<script>");
            out.println("window.alert('Please provide all the required details!');");
            out.println("window.location.href='feedback.html';");
            out.println("</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("window.alert('An error occurred. Please try again later.');");
        out.println("window.location.href='feedback.html';");
        out.println("</script>");
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
