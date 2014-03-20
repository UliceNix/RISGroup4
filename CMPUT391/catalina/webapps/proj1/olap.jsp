<HTML>
<HEAD>
<TITLE>OLAP: Data Analysis Module</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,
   javax.portlet.ActionResponse.*,
   javax.swing.*,
   java.util.*,
   java.text.*" %>
<%
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");
	
	if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
    }
	
	out.println("<form action=olap.jsp>");
	out.println("input type=submit name=Back value='Go Back'><br><br>");
	out.println("</form>");
	out.println("<b>Find out more help information by clicking "
		+ "<a href='help.html#olap' target='blank'>Help</a></b><br>");	
	out.println("<hr><br>");
	
	out.println("<form action=olap.jsp>");
	out.println("<p><b>You would like to see:</b></p>");
	out.println("The number of <b>records</b>: <input type=checkbox "
		+ "name=target value=records required><br>");
	out.println("The number of <b>images</b>: <input type=checkbox" + 
		" name=target value=images required>");
	out.println("<hr><br>");
	out.println("<p>for each:</p>");
	out.println("<b>patient</b>: <input type=checkbox name=people "
		+"value=patient required><br>");
	out.println("<b>doctor</b>: <input type=checkbox name=people "
		+"value=doctor required><br>");
	out.println("<b>radiologist</b>: <input type=checkbox name=people "
		+"value=radiologist required><br>");
	out.println("<hr><br>");
	
	out.println("<p>for each:</p>");
	out.println("<b>test type</b>: <input type=checkbox name=type "
		+" value=type required><br>");
	
	out.println("<p>for test date in each:</p>");
	out.println("<b>day</b>: <input type=checkbox name=timestamp "
		+" value=date required><br>");
	out.println("<b>week</b>: <input type=checkbox name=timestamp "
			+" value=week required><br>");
	out.println("<b>month</b>: <input type=checkbox name=timestamp "
			+" value=month required><br>");
	out.println("<b>year</b>: <input type=checkbox name=timestamp "
			+" value=year required><br>");
	out.println("<input type=submit name=generate value='Go'><br>");
	
	
%>
</BODY>
</HTML>