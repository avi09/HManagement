<%@ page  import="java.sql.*" import="databaseconnection.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<title>HManagement</title>
<link href="style.css" rel="stylesheet" media="all" type="text/css" />
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
<h2></h2>
<!-- /header -->

<h1>Welcome</h1>
The database has been initialized! Sample data has also been inserted. You're all set.<br><br> 
Please select your use case category from the navigation Menu.


<!-- footer -->
<br><br>
<div style="height: 5%; width: 100%; background-color: black; color: white; font-size: 1em;"> HMS - Developed on JSP, Servlets, HTML - Avi Agrawal</div>
</center>
<!-- /footer -->

</body>
</html>