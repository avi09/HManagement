<%@page import="java.sql.Connection"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="admin.MainServlet"%>
<%@ page  import="java.sql.*" import="databaseconnection.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
MainServlet ms = new MainServlet();
Connection con = ms.getConnection();
Statement stmt = con.createStatement();

String mode = request.getParameter("mode");
String tnm = request.getParameter("tnm");

HashMap<String, ArrayList> categoryfields = new HashMap();
categoryfields.put("bills", new ArrayList<String>(Arrays.asList("id", "treatment", "labtests", "ref_id", "category")));
categoryfields.put("labtests", new ArrayList<String>(Arrays.asList("id", "testname", "result", "ref_id", "category")));
categoryfields.put("inpatient", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "roomno", "docname", "illness", "contact")));
categoryfields.put("outpatient", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "visits", "docname", "illness", "contact")));
categoryfields.put("staff", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "work", "contact")));
categoryfields.put("doctor", new ArrayList<String>(Arrays.asList("id", "name", "age", "address", "major", "contact")));

ArrayList<String> iter = categoryfields.get(tnm);
ArrayList<String> ints = new ArrayList();
ints.add("age");
ints.add("labtests");
ints.add("treatment");
ints.add("ref_id");

String query = null;

if (mode.equals("edit"))
{	
	
	query = "update "+tnm+" set "; 
	
	int count = 0;
	while (iter.size()-1 > count)
	{
		if ((!iter.get(count).equals("id")) && (!ints.contains(iter.get(count).toString())))
		query = query + iter.get(count) + " = '" + request.getParameter(iter.get(count).toString()) + "', ";
		
		if (ints.contains(iter.get(count).toString()))
		query = query + iter.get(count) + " = " + request.getParameter(iter.get(count).toString()) + ", ";
		
		count+=1;
	}
	query = query + iter.get(count) + " = '" + request.getParameter(iter.get(count).toString()) + "' where id = " + request.getParameter("id");
	
	if (tnm.equals("bills") || tnm.equals("bills"))
	{
		query = query + " and category = '" + request.getParameter("category") + "'"; 
	}
	query  = query + ";";
	stmt.executeQuery("use hmanagement;");
	stmt.executeUpdate(query);
	System.out.print(query);
	out.println("<script>alert('Done'); window.location.href = '"+request.getParameter("source")+".jsp';</script>");
}

if (mode.equals("clear"))
{
	int id = Integer.parseInt(request.getParameter("id"));
	query = "delete from "+tnm+" where id = "+id+";";
	stmt.executeQuery("use hmanagement;");
	stmt.executeUpdate(query);
	out.println("<script>window.location.href = '"+request.getParameter("source")+".jsp';</script>");
}


if (mode.equals("add"))
{
	stmt.executeQuery("use hmanagement;");
	ResultSet rs = stmt.executeQuery("select max(id) from " + tnm + ";"); 
	rs.next();
	int id = Integer.parseInt(rs.getString("max(id)"));
	id = id + 1;
	
	query = "insert into  "+tnm+" values(" + id + ", "; 
	int count = 0;
	
	while (iter.size()-1 > count)
	{
		if ((!iter.get(count).equals("id")) && (!ints.contains(iter.get(count).toString())))
		query = query + "'" + request.getParameter(iter.get(count).toString()) + "', ";
		if (ints.contains(iter.get(count).toString()))
		query = query + request.getParameter(iter.get(count).toString()) + ", ";
		count+=1;
	}
	query = query + "'" + request.getParameter(iter.get(count).toString()) + "'";
	query  = query + ");";
	stmt.executeUpdate(query);
	out.println("<script>alert('Done'); window.location.href = '"+request.getParameter("source")+".jsp';</script>");
}

%>

</body>
</html>