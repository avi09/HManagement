package admin;

import java.io.*;
import com.mysql.cj.jdbc.Driver;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {
	
	Statement stmt = null;
	String queries = null;
	
	public Connection getConnection() throws FileNotFoundException, IOException
	{	
		try
		{
			Connection con = null;
			Class.forName("com.mysql.cj.jdbc.Driver");	
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306","root","root");
			return con;
			
		}
		catch (Exception ex)
		{	
			ex.printStackTrace();
			return null;
		}
	}
	
	public ResultSet getData(String s)
	{
		ResultSet rs = null;
		try
		{
			Connection con = getConnection();
			Statement stmt = con.createStatement();
			stmt.executeQuery("use hmanagement;");
			rs = stmt.executeQuery(s);
			return rs;
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			return null;
		}
	}
	
	public void initdb(Connection con)
	{
		try
		{
			stmt = con.createStatement();
			queries = 
					"drop database if exists hmanagement;\n"
					+ "create database hmanagement;\n"
					+ "use hmanagement;\n"
					+ "create table inpatient "
					+ "("
					+ "id integer, "
					+ "name varchar(20), "
					+ "age integer, "
					+ "address varchar(25), "
					+ "roomno integer, "
					+ "docname varchar(20), "
					+ "illness varchar(20),"
					+ "contact varchar(15) "
					+ ");\n"
					+ "create table outpatient "
					+ "("
					+ "id integer, "
					+ "name varchar(20), "
					+ "age integer, "
					+ "address varchar(25), "
					+ "visits varchar(50), "
					+ "docname varchar(20), "
					+ "illness varchar(20),"
					+ "contact varchar(15) "
					+ ");\n"
					+ "create table doctor"
					+ "("
					+ "id integer, "
					+ "name varchar(20), "
					+ "age integer, "
					+ "address varchar(25), "
					+ "major varchar(15), "
					+ "contact varchar(10) "
					+ ");\n"
					+ "create table staff"
					+ "("
					+ "id integer, "
					+ "name varchar(10),"
					+ "age integer,"
					+ "address varchar(25),"
					+ "work varchar(15),"
					+ "contact varchar(10)"
					+ ");\n"
					+ "create table bills"
					+ "("
					+ "id integer, "
					+ "treatment integer,"
					+ "labtests integer,"
					+ "ref_id integer,"
					+ "category varchar(5)"
					+ ");\n"
					+ "create table labtests("
					+ "id integer, "
					+ "testname varchar(20), "
					+ "result varchar(10), "
					+ "ref_id integer,"
					+ "category varchar(25)"
					+ ");\n"
					+ "insert into outpatient values (1, 'Storm', 45, '2213 Gorman Street', '11/25/2020 10:00', 'Dr. Wind', 'Viral', '2556789');\n"
					+ "insert into outpatient values (2, 'Steve', 15, '289 Gorman Street', '11/15/2020 11:00', 'Dr. Wind', 'Viral', '246786');\n"
					+ "insert into outpatient values (3, 'Dom', 25, '2217 Gorman Street', '11/2/2020 16:00', 'Dr. Triva', 'Corona', '2245678');\n"
					+ "insert into outpatient values (4, 'Windy', 29, '22 Gorman Street', '1/5/2021 19:00', 'Dr. Dude', 'Fever', '768954');\n"
					+ "insert into outpatient values (5, 'Betty', 22, '4 Gorman Street', '11/28/2020 09:00', 'Dr. Beard', 'Aching', '256798');\n"
					+ "insert into outpatient values (6, 'Veronica', 26, '45 Gorman Street', '11/25/2020 11:00', 'Dr. Dude', 'Viral', '267895');\n"
					+ "insert into inpatient values (1, 'Tim', 18, '2215 Gorman Street', 5, 'Dr. Triva', 'Viral', '225684');\n"
					+ "insert into inpatient values (2, 'Dan', 45, '234 Gorman Street', 8, 'Dr. Triva', 'Corona', '221875');\n"
					+ "insert into inpatient values (3, 'Ross', 29, '67 Gorman Street', 16, 'Dr. Dude', 'Corona', '988645');\n"
					+ "insert into inpatient values (4, 'Joey', 28, '98 Gorman Street', 19, 'Dr. Beard', 'Tonsils', '22564119');\n"
					+ "insert into inpatient values (5, 'Kinsey', 25, '7821 Gorman Street', 5, 'Dr. Wind', 'Aching', '7788219');\n"
					+ "insert into doctor values (1, 'Dr. Wind', 45, '171 Gorman Street', 'Gainecology', '22564119');\n"
					+ "insert into doctor values (2, 'Dr. Trivia', 41, '28 Gorman Street', 'Dentist', '22564119');\n"
					+ "insert into doctor values (3, 'Dr. Dude', 29, '7992 Gorman Street', 'General', '22564119');\n"
					+ "insert into doctor values (4, 'Dr. Beard', 26, '6821 Gorman Street', 'General', '22564119');\n"
					+ "insert into staff values (1, 'Simmy', 28, '79 Gorman Street', 'Nurse', '66557658');\n"
					+ "insert into staff values (2, 'Georgia', 26, '4581 Gorman Street', 'Nurse', '67876865');\n"
					+ "insert into bills values (1, 10000, 4000, 1, 'out');\n"
					+ "insert into bills values (2, 8000, 0, 2, 'out');\n"
					+ "insert into bills values (3, 4000, 2000, 3, 'out');\n"
					+ "insert into bills values (4, 200, 15000, 4, 'out');\n"
					+ "insert into bills values (5, 18000, 19000, 5, 'out');\n"
					+ "insert into bills values (6, 16000, 6000, 6, 'out');\n"
					+ "insert into bills values (7, 18000, 0, 1, 'in');\n"
					+ "insert into bills values (8, 200, 0, 2, 'in');\n"
					+ "insert into bills values (9, 400, 2000, 3, 'in');\n"
					+ "insert into bills values (10, 600, 0, 4, 'in');\n"
					+ "insert into bills values (11, 7900, 0, 5, 'in');\n"
					+ "insert into labtests values (1, 'glyco', '+', 1, 'out');\n"
					+ "insert into labtests values (2, 'hemo', '+', 3, 'out');\n"
					+ "insert into labtests values (3, 'wbc', '+', 4, 'out');\n"
					+ "insert into labtests values (4, 'rbc', '+', 5, 'out');\n"
					+ "insert into labtests values (5, 'glyco', '+', 6, 'out');\n"
					+ "insert into labtests values (6, 'rbc', '+', 3, 'in');";
					
			ResultSet rs = stmt.executeQuery("use hmanagement;");
			System.out.println("Found DB");

		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			try
			{
				String[] lines = queries.split("\n");
				for (String iter:lines)
				{
					stmt.executeUpdate(iter);
					System.out.println("Running - " + iter);
				}
				
			}
			catch (Exception ex1)
			{
				ex1.printStackTrace();
			}
		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//Fetch Data
		Connection con = getConnection();
		initdb(con);
		response.sendRedirect("home.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		return;
	}

}
