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
	
	Connection conn = null;
	
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	try{
		//load and register the driver
		Class drvClass = Class.forName(driverName); 
		DriverManager.registerDriver((Driver) drvClass.newInstance());
	}catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	try{
		//establish the connection 
		conn = DriverManager.getConnection(dbstring,"mingxun",
			"hellxbox_4801");
		conn.setAutoCommit(false);
	}catch(Exception ex){
       	out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
    }
	
	if(request.getParameter("generate") != null){
		String target = (request.getParameter("target")).trim();
		String type = (request.getParameter("type"));
		String period = (request.getParameter("timestamp"));
		
		if(target.equals("records")){
			return;
		}
		
	}
	
	Statement stmt = null;
	ResultSet rset = null;
	
	String test_types = "select distinct(test_type) from radiology_record";
	String patient_ids = "select u.person_id, "
		+ "CONCAT(CONCAT(p.first_name, ''), p.last_name) as patient_name "
		+ "from users u, persons p "
		+ "where u.person_id=p.PERSON_ID and u.CLASS='p'";
	
	try{
		stmt = conn.createStatement();
		rset = stmt.executeQuery(test_types);
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}
	
	ArrayList<String> types = new ArrayList<String>();
	while(rset != null && rset.next()){
		types.add(rset.getString(1));	
	}
		
	out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br><br>");
	out.println("</form>");
	
	out.println("<b>Find out more help information by clicking "
		+ "<a href='help.html#olap' target='blank'>Help</a></b><br>");	
	out.println("<hr>");
	
	out.println("<form action=olap.jsp>");
	out.println("<table BORDER=1>");
	out.println("<tr><td>");
	out.println("<p><b>You would like to see:</b></p>");
	out.println("<label for='records'></label>");
	out.println("The number of <b>records</b>: <input type=radio "
		+ "name=target id=records value=records required><br>");
	out.println("<label for='images'></label>");
	out.println("The number of <b>images</b>: <input type=radio" + 
		" name=target id=images value=images required>");
	out.println("</a></td>");
	out.println("<td></a></td>");

	out.println("<tr><td>");
	out.println("<p>for each:</p>");
	out.println("<label for='type'></label>");
	out.println("<b>test type</b>: <input type=radio name=type "
			+" id=type value=type><br>");
	out.println("</a></td>");
	out.println("<td><p>Or you would like to specify a test type</p>");
	out.println("<select name=selectTypes style='width: 400px'>")
	out.println("<option value='empty'>N/A</option>");
	for(int i = 0; i < types.size(); i++){
		out.println("<option value=\""+ types.get(i)+"\">" 
			+ types.get(i) + "</option>");
	}
	out.println("</select>");
	out.println("</a></td>");

	try{
		rset = stmt.executeQuery(patient_ids);
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}
	
	ArrayList<String> ids = new ArrayList<String>();
	ArrayList<String> names = new ArrayList<String>();
	while(rset != null && rset.next()){
		ids.add(rset.getString(1));
		names.add(rset.getString(2));
	}
	
	out.println("<tr><td>");	
	out.println("<p>for each:</p>");
	out.println("<label for='patient'></label>");
	out.println("<b>patient</b>: <input type=radio name=people "
		+"id=patient value=patient>");
	out.println("</a></td>");
	
	out.println("<td>");
	out.println("<p>Or you would like to specify a patient id</p>");
	out.println("<select name=selectPatientId style='width: 400px'>");
	out.println("<option value='empty'>N/A</option>");
	for(int i = 0; i < ids.size(); i++){
		out.println("<option value=\"" + ids.get(i) + "\">" + ids.get(i) 
			+ ": " + names.get(i) + "</option>");
	}
	out.println("</select>");
	out.println("</a></td>");
	
	
	out.println("<tr><td>");
	out.println("<p>for test date in each:</p>");
	out.println("<b>day</b>: <input type=radio name=timestamp "
		+" id=day value=date><br>");
	out.println("<label for='week'></label>");
	out.println("<b>week</b>: <input type=radio name=timestamp "
		+" id=week value=week><br>");
	out.println("<label for='month'></label>");
	out.println("<b>month</b>: <input type=radio name=timestamp "
		+" id=month value=month><br>");
	out.println("<label for='year'></label>");
	out.println("<b>year</b>: <input type=radio name=timestamp "
		+" id=year value=year><br>");
	out.println("</a></td>");
	out.println("<td><p>Or you would like to specify a date/week/month/year"
		+ "</p>");
	out.println("<p> Specify the result by week, month, year. </p>");
	out.println("Week&nbsp: <select name=selectWeek style='width: 150px'>");
	out.println("<option value='empty'>N/A</option>");
	for(int i = 1; i < 54; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	
	out.println("<br>");
	out.println("Month: <select name=selectMonth style='width: 150px'>");
	out.println("<option value='empty'>N/A</option>");
	out.println("<option value='JAN'>January</option>");
	out.println("<option value='FEB'>February</option>");
	out.println("<option value='MAR'>March</option>");
	out.println("<option value='APR'>April</option>");
	out.println("<option value='MAY'>May</option>");
	out.println("<option value='JUN'>Jun</option>");
	out.println("<option value='JUL'>July</option>");
	out.println("<option value='AUG'>August</option>");
	out.println("<option value='SEP'>September</option>");
	out.println("<option value='OCT'>October</option>");
	out.println("<option value='NOV'>November</option>");
	out.println("<option value='DEC'>December</option>");
	out.println("</select><br>");
	
	out.println("Year&nbsp&nbsp: <select name=selectYear style='width: 150px'>");
	out.println("<option value='empty'>N/A</option>");
	for(int i = 1900; i < 2015; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select><br><hr>");
	
	out.println("<p> Or specify the result by exact date. </p>");
	out.println("Date: <input type=text name=date maxlength=11>(Eg. JUN-01-2013)<br>");	
	out.println("</a></td>");
	out.println("</table>");
	out.println("<input type=submit name=generate value='Go'><br>");
	out.println("<hr>");
	
	
	if(request.getParameter("generate") != null){
		
		
	}
	
	try{
		conn.close();
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}


%>
</BODY>
</HTML>
