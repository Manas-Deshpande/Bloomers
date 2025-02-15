<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
</head>
<body>
<%
    String n = request.getParameter("f_name");
    String l = request.getParameter("l_name");
    String e = request.getParameter("email");
    String p = request.getParameter("password");
    

    if (!p.equals(p)) {
        out.println("<script>");
        out.println("window.alert('Passwords do not match!');");
        out.println("window.history.back();");  
        out.println("</script>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers", "root", "");

            PreparedStatement checkUser = con.prepareStatement("SELECT * FROM register WHERE email = ?");
            checkUser.setString(1, e);
           
            ResultSet rs = checkUser.executeQuery();

            if (rs.next())
            {
                // If username or email already exists, show an error message
                out.println("<script>");
                out.println("window.alert('Username or Email already exists!');");
                out.println("window.history.back();");  // Redirect back to the registration page
                out.println("</script>");
            }
            else 
            {
                // If username and email are unique, proceed with insertion
                PreparedStatement ps = con.prepareStatement("insert into register  (f_name, l_name, email,  password) values (?, ?, ?, ? )");
                ps.setString(1, n);
                ps.setString(2, l);
                ps.setString(3, e);
                ps.setString(4, p);
               

                int i = ps.executeUpdate();
                if (i != 0)
                {
                    out.println("<script>");
                    out.println("window.alert('Registered Successfully!!')");
                    out.println("window.location.href='login.html';");
                    out.println("</script>");
                }
            }
        } catch (Exception ex) 
        {
            out.println("Error: " + ex.getMessage());
        }
    }
%>
</body>
</html>