<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Campaign </title>
</head>
<body>

<%
String a,b,c,d,e,f,g;
a = request.getParameter("f_name");
b = request.getParameter("email");
c = request.getParameter("phone_no");
d = request.getParameter("venue");
e = request.getParameter("no_of_tress");
f = request.getParameter("calendar");
g = request.getParameter("message");

if (a == null || b == null || c == null || d == null || e == null || f == null || g == null ) {
    out.println("<script>alert('Please fill in all fields'); window.history.back();</script>");
} else {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers", "root", "");
        
        // Use parameterized query to avoid SQL injection
        String query = "INSERT INTO campaign (f_name, email, phone_no, venue, no_of_tress, calendar, message) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, a);
        ps.setString(2, b);
        ps.setString(3, c);
        ps.setString(4, d);
        ps.setString(5, e);
        ps.setString(6, f);
        ps.setString(7, g);
        

        int x = ps.executeUpdate();

        if (x != 0) {
            out.println("<script>");
            out.println("window.alert('Record Inserted Successfully, Thank you for enrolling!');");
            out.println("window.location.href='index.html';");
            out.println("</script>");
        }

        
        ps.close();
        con.close();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("<script>alert('Error processing your request. Please try again later.');</script>");
    }
}
%>
</body>
</html>
