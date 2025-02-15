<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
        String e,p;
        e=request.getParameter("email");
        p=request.getParameter("password");
        boolean recordFound = false;
        
        String E,P;
        E=null;
        P=null;
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	Connection con;
    	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloomers","root","");
    	Statement s1=con.createStatement();
    	ResultSet rs = s1.executeQuery("select * from register where email='"+e+"' AND password='"+p+"'");
    	
    	while(rs.next())
    	{
    		E=rs.getString("email");
    		P=rs.getString("password");
    		if(E.equals(e) && P.equals(p))
    		{
    			recordFound=true;
    			out.println("<script>");
    			out.println("window.alert(' Login Successful')");
    			out.println("window.location.href='index.html'");
    			out.println("</script>");
    			break;
    		}
    	}
    	if(!recordFound)
    	{
    		out.println("<script>");
			out.println("window.alert('Wrong UserId or Password')");
			out.println("</script>");
    	}
		
%>
</body>
</html>