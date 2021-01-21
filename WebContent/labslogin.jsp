<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Labs Login</title>
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
<h2>Labs Login</h2>
<!-- /header -->

<form action = "labs.jsp" method = "post">
Username(labs): <input name="username" /><br><br>
Password(labs): <input name="key" type="password" /><br><br>
<button action="submit">Login</button>
</form>

<!-- footer -->
<br><br>
<div style="height: 5%; width: 100%; background-color: black; color: white; font-size: 1em;"> HMS - Developed on JSP, Servlets, HTML - Avi Agrawal</div>
</center>
<!-- /footer -->

</body>
</html>