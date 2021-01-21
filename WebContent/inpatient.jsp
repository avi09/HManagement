<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="admin.MainServlet"%>
<%@page import="java.util.Map"%>
<%@ page  import="java.sql.*" import="databaseconnection.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>In patient home</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<!-- header -->
<center>
<h1> Hospital Management Services </h1>
<div class="topnav">
	<a href="home.jsp" class = "navicon" style="float: left;">Home</a>
    <a href="adminlogin.jsp" class = "navicon">Admin</a>
    <a href="inpatientlogin.jsp" class = "navicon">In Patient </a>
    <a href="outpatientlogin.jsp" class = "navicon">Out Patient</a> 
    <a href="labslogin.jsp" class = "navicon">Labs</a> 
    <a href="billslogin.jsp" class = "navicon">Bills</a> 
</div><br>
<h2>In Patient Home</h2>
<!-- /header -->

<% 
String id = request.getParameter("id");

MainServlet ms = new MainServlet();
ResultSet rs = ms.getData("select count(*) from inpatient where id = "+Integer.parseInt(id)+";");


try
{
	rs.next();
	if (rs.getInt("count(*)")==1)
	{
		session.setAttribute("bills", "true");
		out.println("Authenticated<br>");
	}
	else
	{
		response.getWriter().print("<html><body><form action='inpatientlogin.jsp' id = 'sb'></form>"
		+"<script>alert('Incorrect Credentials!'); document.getElementById('sb').submit(); </script>"
		+"</body></html>");
	}
	
	out.println("<h4>Basic Info</h4>");
	rs = ms.getData("select * from inpatient where id = " + id + ";");
	rs.next();
	int count = 0;
	ArrayList<String> iter = new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "roomno", "docname", "illness", "contact"));
	out.println("<table style='width: 65%;'>");
	count = 0;
	while (iter.size() > count)
	{
		out.println("<tr>");
		out.println("<td style='border-style: solid; text-align: center; border-width: 1px; width: 25%;'>" + iter.get(count) + "</td>");
		out.println("<td style='border-style: solid; text-align: center; border-width: 1px;'>");
		out.println(rs.getString(iter.get(count).toString()));
		out.println("</td>");
		out.println("</tr>");
		count+=1;
	}	
	out.println("</table>");
	
	out.println("<h4>Lab Reports</h4>");
	rs = ms.getData("select * from labtests where ref_id = " + id + " and category = 'in';");
	count = 0;
	iter = new ArrayList<String>(Arrays.asList("id", "testname", "result", "ref_id", "category"));
	while (rs.next())
	{
		out.println("<table style='width: 65%;'>");
		count = 0;
		while (iter.size() > count)
		{
			out.println("<tr>");
			out.println("<td style='border-style: solid; text-align: center; border-width: 1px; width: 25%;'>" + iter.get(count) + "</td>");
			out.println("<td style='border-style: solid; text-align: center; border-width: 1px;'>");
			out.println(rs.getString(iter.get(count).toString()));
			out.println("</td>");
			out.println("</tr>");
			count+=1;
		}	
		out.println("</table>");
		out.println("<br><br>");
	}
	
	out.println("<h4>Current Bill</h4>");
	rs = ms.getData("select * from bills where ref_id = " + id + " and category = 'in';");
	count = 0;
	iter = new ArrayList<String>(Arrays.asList("id", "treatment", "labtests", "ref_id", "category"));
	while (rs.next())
	{
		out.println("<table style='width: 65%;'>");
		count = 0;
		while (iter.size() > count)
		{
			out.println("<tr>");
			out.println("<td style='border-style: solid; text-align: center; border-width: 1px; width: 25%;'>" + iter.get(count) + "</td>");
			out.println("<td style='border-style: solid; text-align: center; border-width: 1px;'>");
			out.println(rs.getString(iter.get(count).toString()));
			out.println("</td>");
			out.println("</tr>");
			count+=1;
		}	
		out.println("</table>");
		out.println("<br><br>");
	}
	
}
catch (Exception ex)
{
	out.println(ex.toString());
	
}
%>

<!-- footer -->
<br><br>
<div style="height: 5%; width: 100%; background-color: black; color: white;"> HMS - Developed on JSP, Servlets, HTML - Avi Agrawal</div>
</center>
<!-- /footer -->


</body>
</html>