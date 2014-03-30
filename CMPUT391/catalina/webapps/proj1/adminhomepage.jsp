<!-- Copyright (C) 2014 Alice (Mingxun) Wu

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. -->

<HTML>
<HEAD>


<TITLE>Admin Homepage</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,
	javax.portlet.ActionResponse.*, 
	javax.swing.*" %>
<% 
	/**********************************************************
	*    	User Interface Section
	***********************************************************/
	out.println("<p><b>Welcome to Administrator's Homepage, "
		+ session.getAttribute("UserName") + "!</b></p>");
	out.println("<p>Manage the user's information (update an " 
		+ "exisiting user or register a new user).</p>");
	out.println("<p>Search for radiologist records.</p>");
	out.println("<p>Generate the report of all patients.</p>");
	out.println("<b>Find out more help information by clicking <a "
		+"href='help.html#adminHomepage' target='blank'>Help"
		+"</a></b><br><br>");
	
    out.println("<br><hr><b>Edit User Information</b><hr>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=NewUser value='Register a New "
	+ "User' style='width: 200px'><br>");
    out.println("</form>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<p>Enter the user's person_id</p><input type=text "
	+ "name=PersonId required style='width: 200px'><br>");
    out.println("<input type=submit name=UpdateUser value='Update a"
	+ " User' style='width: 200px'><br>");
    out.println("</form>");
    
    out.println("<hr><b>Edit Family Doctor Relationship</b><hr>");
    out.println("<form action=editfamdoc.jsp>");
    out.println("<input type=submit name=EditFamDoc value='Update Family"
	+ " Doctor Info' style='width: 200px'><br>");
	out.println("</form>");
    
	out.println("<hr><b>Functions</b><hr>");
    out.println("<form action=search.jsp>");
    out.println("<input type=submit name=Search value='Use Search Engine'"
    	+" style='width: 200px'>");
    out.println("</form>");
    out.println("<form action=report.jsp>");
    out.println("<input type=submit name=Report value='Generate a Report'"
    	+" style='width: 200px'>");
    out.println("</form>");
    out.println("<form action=olap.jsp>");
    out.println("<input type=submit name=DataAnalysis value='OLAP Report "
    	+"Generator' style='width: 200px'><br>");
    out.println("</form>");

    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=LogOut value='Log Out' "
    	+"style='width: 200px'><br>");
    out.println("</form>");
    
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");
	
	/* in case the session expires, system will redirect the user to log in*/
    if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
    }
	
	/* when admin wants to register a new account, direct admin to SignUp.jsp*/
    if (request.getParameter("NewUser") != null){
        response.sendRedirect("/proj1/SignUp.jsp");
    }

	/* before letting the admin to update a user, we need to make sure
	 * the admin enters a valid user id
	 */
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
     	String sql = "select * from PERSONS where PERSON_ID = '"
     		+ personId + "'";
     	
		/* test if the id is an integer*/
        if (personId.isEmpty() || personId == null 
	    || !personId.matches("[0-9]+")){
            JOptionPane.showMessageDialog(null,
            		"Invalid Person Id.");
        }else if (!(rset = stmt.executeQuery(sql)).next()){
        	
        	/* test the existence of the person*/
	    	JOptionPane.showMessageDialog(null,
	    			"This person does not exist.");
		}else{
			
			/* finally, on success, direct the admin to update the user*/
	    	session.setAttribute("updatePersonId", personId);
	    	response.sendRedirect("/proj1/updateuser.jsp");
		}
        
		/* close the connection */
    	try{
    		conn.close();
    	}catch(Exception ex){
    		out.println(ex.getMessage() + "<br>");
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
