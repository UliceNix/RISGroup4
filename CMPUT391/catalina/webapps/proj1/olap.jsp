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
	out.println("<label for='records'></label>");
	out.println("The number of <b>records</b>: <input type=radio "
		+ "name=target id=records value=records required><br>");
	out.println("<label for='images'></label>");
	out.println("The number of <b>images</b>: <input type=radio" + 
		" name=target id=images value=images required>");
	out.println("<hr><br>");
	
	out.println("<p>for each:</p>");
	out.println("<label for='patient'></label>");
	out.println("<b>patient</b>: <input type=radio name=people "
		+"id=patient value=patient><br>");
	out.println("<hr><br>");
	
	out.println("<p>for each:</p>");
	out.println("<label for='type'></label>");
	out.println("<b>test type</b>: <input type=radio name=type "
		+" id=type value=type><br>");
	
	out.println("<p>for test date in each:</p>");
	out.println("<label for='day'></label>");
	out.println("<b>day</b>: <input type=radio name=timestamp "
		+" id=day value=date required><br>");
	out.println("<label for='week'></label>");
	out.println("<b>week</b>: <input type=radio name=timestamp "
		+" id=week value=week required><br>");
	out.println("<label for='month'></label>");
	out.println("<b>month</b>: <input type=radio name=timestamp "
		+" id=month value=month required><br>");
	out.println("<label for='year'></label>");
	out.println("<b>year</b>: <input type=radio name=timestamp "
		+" id=year value=year required><br>");
	out.println("<input type=submit name=generate value='Go'><br>");
	

	}

%>
</BODY>
</HTML>
