<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="admin.MainServlet"%>
<%@ page  import="java.sql.*" import="databaseconnection.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Data</title>
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
<h2>Edit Data</h2>
<!-- /header -->

<% 

String tnm = request.getParameter("tnm");
String id = request.getParameter("id");
String mode = request.getParameter("mode");

HashMap<String, ArrayList> categoryfields = new HashMap();
categoryfields.put("bills", new ArrayList<String>(Arrays.asList("id", "treatment", "labtests", "ref_id", "category")));
categoryfields.put("labtests", new ArrayList<String>(Arrays.asList("id", "testname", "result", "ref_id", "category")));
categoryfields.put("inpatient", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "roomno", "docname", "illness", "contact")));
categoryfields.put("outpatient", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "visits", "docname", "illness", "contact")));
categoryfields.put("staff", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "work", "contact")));
categoryfields.put("doctor", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "major", "contact")));

MainServlet ms = new MainServlet();


if (mode.equals("edit"))
{
	String query = "select * from "+tnm+" where id = "+id;
	
	if (tnm.equals("bills") || tnm.equals("labtests"))
	{
		query = query + " and category = '" + request.getParameter("category") + "'"; 
	}
	
	query  = query + ";";
	ResultSet rs = ms.getData(query);
	
	int count = 0;
	ArrayList iter = categoryfields.get(tnm);
	out.println("<h2>"+tnm+"</h2><form action='submitrequest.jsp'>");
	rs.next();
	
	while (iter.size() > count)
	{
		out.println(iter.get(count) + "<br> <input name = '"+iter.get(count)+"' value = '"+rs.getString(iter.get(count).toString())+"' /><br><br>");
		count+=1;
	}
	out.println("<input type='hidden' name='tnm' value='"+tnm+"' />");
	out.println("<input type='hidden' name='mode' value='edit' />");
	out.println("<input type='hidden' name='source' value='"+request.getParameter("source")+"' />");
	out.println("<button type = 'submit'>Submit</button></form><br>");
	out.println("<script> function back(){ window.location.href = 'home.jsp' }</script><form><button onclick = 'back()'>Cancel</button></form><br>");
}

if (mode.equals("clear"))
{
	out.println("<form action='submitrequest.jsp' id='clearf'>");	
	out.println("<input type='hidden' name='id' value='"+id+"'/>");
	out.println("<input type='hidden' name='tnm' value='"+tnm+"' />");
	out.println("<input type='hidden' name='source' value='"+request.getParameter("source")+"' />");
	out.println("<input type='hidden' name='mode' value='clear'/> </form>");
	out.println("<script>document.getElementById('clearf').submit(); </script>");
}

if (mode.equals("add"))
{
	int count = 0;
	ArrayList iter = categoryfields.get(tnm);
	out.println("<h2>"+tnm+"</h2><form action='submitrequest.jsp'>");
	while (iter.size() > count)
	{
		out.println(iter.get(count) + "<br> <input name = '"+iter.get(count)+"' /><br><br>");
		count+=1;
	}
	out.println("<input type='hidden' name='tnm' value='"+tnm+"' />");
	out.println("<input type='hidden' name='mode' value='add' />");
	out.println("<input type='hidden' name='source' value='"+request.getParameter("source")+"' />");
	out.println("<button type = 'submit'>Submit</button></form><br>");
	out.println("<script> function back(){ window.location.href = 'home.jsp' }</script><form><button onclick = 'back()'>Cancel</button></form><br>");
}

%>



<!-- footer -->
<br><br>
<div style="height: 5%; width: 100%; background-color: black; color: white;"> HMS - Developed on JSP, Servlets, HTML - Avi Agrawal</div>
</center>
<!-- /footer -->


</body>
</html>