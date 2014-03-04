<HTML>
<HEAD>


<TITLE>Admin Homepage</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*" %>
<% 
    out.println("<p><b>Welcome to Administrator's Homepage, " 
	+ session.getAttribute("UserName") + "!</b></p>");
    out.println("<p><b>Manage the user's information (update an " 
	+ "exisiting user or register a new user).</b></p>");
    out.println("<p><b>Search for radiologist records.</b></p>");
    out.println("<p><b>Generate the report of all patients..</b></p>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=NewUser value='Register a New "
	+ "User'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<p>Enter the user's person_id</p><input type=text "
	+ "name=PersonId required><br>");
    out.println("<input type=submit name=UpdateUser value='Update a"
	+ " User'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=editfamdoc.jsp>");
    out.println("<input type=submit name=EditFamDoc value='Update Family"
	+ " Doctor Information'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=search.jsp>");
    out.println("<input type=submit name=Search value='Use Search Engine'>");
    out.println("</form>");
    out.println("<form action=report.jsp>");
    out.println("<input type=submit name=Report value='Generate a Report'>");
    out.println("</form>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=DataAnalysis value='OLAP Report Generator'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=LogOut value='Log Out'><br>");
    out.println("</form>");

    if (request.getParameter("NewUser") != null){
        response.sendRedirect("/proj1/SignUp.jsp");
    }

    if (request.getParameter("UpdateUser") != null){
        String personId = (request.getParameter("PersonId")).trim();
        Connection conn = null;
	    
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
 
	try {
	    Class drvClass = Class.forName(driverName); 
	    DriverManager.registerDriver((Driver) drvClass.newInstance());
	}catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
     	try {
	    conn = DriverManager.getConnection(dbstring,"mingxun",
	    "hellxbox_4801");
	    conn.setAutoCommit(false);
	}catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
     	}

     	Statement stmt = conn.createStatement();
     	ResultSet rset = null;
     	String sql = "select * from PERSONS where PERSON_ID = '"+personId+"'";
	
        if (personId.isEmpty() || personId == null 
	    || !personId.matches("[0-9]+")){
            out.println("<p><b>Invalid Person Id.</b></p>");
        }else if (!(rset = stmt.executeQuery(sql)).next()){
	    out.println("<p><b>This person does not exist..</b></p>");	    
	}else{
	    session.setAttribute("PersonId", personId);
	    response.sendRedirect("/proj1/updateuser.jsp");
	}
    }
    
    
    if (request.getParameter("LogOut") != null){
        session.removeAttribute("UserName");
	session.removeAttribute("Person_Id");
	session.removeAttribute("PermissionLevel");
	JOptionPane.showMessageDialog(null, "You have been logged"
		    + " out successfully!");
	response.sendRedirect("/proj1/login.jsp");		
    }

%>



</BODY>
</HTML>
