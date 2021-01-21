<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="admin.MainServlet"%>
<%@page import="java.util.Map"%>
<%@ page  import="java.sql.*" import="databaseconnection.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Home</title>
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
<h2>Admin Home</h2>
<!-- /header -->

<% 

String username = request.getParameter("username");
String key = request.getParameter("key");

try
{
if ((username.equals("admin") && key.equals("admin")))
{
	session.setAttribute("admin", "true");
	out.println("Authenticated");
}
else
{
	
	response.getWriter().print("<html><body><form action='labslogin.jsp' id = 'sb'></form>"
	+"<script>alert('Incorrect Credentials!'); document.getElementById('sb').submit(); </script>"
	+"</body></html>");
}
}
catch(Exception ex)
{
	try
	{
		session.getAttribute("admin");
	}
	catch (Exception ex1)
	{
		response.getWriter().print("<html><body><form action='labslogin.jsp' id = 'sb'></form>"
				+"<script>alert('Incorrect Credentials!'); document.getElementById('sb').submit(); </script>"
				+"</body></html>");	
	}
}

//table
HashMap<String, ArrayList> categoryfields = new HashMap();
categoryfields.put("inpatient", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "roomno", "docname", "illness", "contact")));
categoryfields.put("outpatient", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "visits", "docname", "illness", "contact")));
categoryfields.put("labtests", new ArrayList<String>(Arrays.asList("id", "testname", "result", "ref_id", "category")));
categoryfields.put("bills", new ArrayList<String>(Arrays.asList("id", "treatment", "labtests", "ref_id", "category")));
categoryfields.put("doctor", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "major", "contact")));
categoryfields.put("staff", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "work", "contact")));
MainServlet ms = new MainServlet();
ResultSet rs = null;
int count = 0;

for (Map.Entry<String,ArrayList> entry : categoryfields.entrySet())
{
	out.println("<h4>"+entry.getKey()+"</h4>");
	rs = ms.getData("select * from "+entry.getKey()+";");
	out.println("<table style='width: 65%;'>");
	while (rs.next())
	{
		count = 0;
		while (entry.getValue().size() > count)
		{
			out.println("<td style='border-style: solid; text-align: center; border-width: 1px;'>");
			out.println(rs.getString(entry.getValue().get(count).toString()));
			out.println("</td>");
			count+=1;
		}
		out.println("<td style='border-style: solid; text-align: center; border-width: 1px;'>"
		+"<form action = 'editdata.jsp' method='post'>"
		+"<input type='hidden' name='tnm' value='"+entry.getKey()+"' />"
		+"<input type='hidden' name='id' value="+rs.getString("id")+" />"
		+"<input type='hidden' name='mode' value='edit' />"
		+"<input type='hidden' name='source' value='admin'/>");
		
		if (entry.getKey().toString().equals("labtests") || entry.getKey().toString().equals("bills"))
		{
			out.println("<input type='hidden' name='category' value='"+rs.getString("category")+"' />");
		}
		
		out.println("<button type = 'submit' style='width: 65%; font-size: 0.7em; background-color: #f2f2f2; color: black;'>Edit</button></form>");
		out.println("<td style='border-style: solid; text-align: center; border-width: 1px;'>"
		+"<form action = 'editdata.jsp' method='post'>"
		+"<input type='hidden' name='tnm' value='"+entry.getKey()+"' />"
		+"<input type='hidden' name='id' value="+rs.getString("id")+" />"
		+"<input type='hidden' name='mode' value='clear' />"
		+"<input type='hidden' name='source' value='admin'/>"
		+"<button type = 'submit' style='width: 55%; font-size: 0.6em; background-color: #f2f2f2; color: black;'>Clear</button></form>");		
		out.println("</tr>");
	}
	out.println("</table>");
	out.println("<form action = 'editdata.jsp' method='post'>"
	+"<input type='hidden' name='tnm' value='"+entry.getKey()+"' />"
	+"<input type='hidden' name='mode' value='add' />"
	+"<input type='hidden' name='source' value='admin'/>"
	+"<button type = 'submit' style='width: 55%; font-size: 0.8em; background-color: #f2f2f2; color: black; width: 5%;'>Add</button></form>");		
	
}

%>



<!-- footer -->
<br><br>
<div style="height: 5%; width: 100%; background-color: black; color: white;"> HMS - Developed on JSP, Servlets, HTML - Avi Agrawal</div>
</center>
<!-- /footer -->


</body>
</html>