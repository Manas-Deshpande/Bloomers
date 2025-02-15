<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
</head>
<body>
<%
String a,b,c,d,e,f,g,h,i,j,k,l;
a = request.getParameter("firstname");
b = request.getParameter("email");
c = request.getParameter("address");
d = request.getParameter("city");
e = request.getParameter("state");
f = request.getParameter("zip");
g = request.getParameter("cardname");
h = request.getParameter("cardnumber");
i = request.getParameter("Amount");
j = request.getParameter("expmonth");
k = request.getParameter("expyear");
l = request.getParameter("cvv");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con;
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers","root","");
PreparedStatement ps = con.prepareStatement("insert into payment values('"+a+"','"+b+"','"+c+"','"+d+"','"+e+"','"+f+"','"+g+"','"+h+"','"+i+"','"+j+"','"+k+"','"+l+"')");
int  m =ps.executeUpdate();

if(m!=0)
{
	out.println("<script>");
	out.println("window.alert('Record Inserted Successfully , Thankyou for payment!!')");
	out.println("window.location.href='payment.html'");
	out.println("</script>");
}


%>

</body>
</html>