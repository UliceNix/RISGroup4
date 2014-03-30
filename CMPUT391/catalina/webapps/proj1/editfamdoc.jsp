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


<TITLE>Edit Family Doctor Relationship</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, 
	javax.swing.*, java.util.*" %>
<% 
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");

	/* in case the session expires, system will redirect the user to log in*/
	if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
	}

	/* print out user interface layout*/
	out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br>");
	out.println("</form>");
	out.println("<b>Find out more help information by clicking <a href"
    		+"='help.html#editFamDoctor' target='blank'>Help</a></b><br><br>");
	out.println("<hr>");
	out.println("<form action=editfamdoc.jsp>");
	out.println("Enter the doctor's person id: <input type=text "
		+ "name=Doctor required><br>");
	out.println("Enter the patient's person id:  <input type=text "
		+ "name=Patient required><br><br>");
	out.println("<input type=submit name=AddFamDoc value='Add Relationship'>");
	out.println("<input type=submit name=DropFamDoc value='Drop Relationship'"
		+ "><br>");
	out.println("</form>");
	out.println("<hr>");
    
	/* establish a connection */
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

	/* prepare to execute a query that simply returns 
	 * all current family doctor and patient information
	 * and display them in a table later
	 */
	Statement stmt = null;
	
	try{
		stmt = conn.createStatement();
	}catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}
    
	ResultSet rset = null;
	ResultSet rset1 = null;
    
	String sql = "SELECT FAMILY_DOCTOR.DOCTOR_ID, P1.FIRST_NAME, "
		+ "P1.LAST_NAME,FAMILY_DOCTOR.PATIENT_ID, P2.FIRST_NAME, "
		+ "P2.LAST_NAME FROM FAMILY_DOCTOR, PERSONS P1, PERSONS P2 "
		+ "WHERE FAMILY_DOCTOR.DOCTOR_ID = P1.PERSON_ID AND "
		+ "FAMILY_DOCTOR.PATIENT_ID = P2.PERSON_ID ORDER BY DOCTOR_ID";
	
	/* execute the query*/
	try{
		rset = stmt.executeQuery(sql);
	}catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}
    
	/* handling result */
	ArrayList<String> docId = new ArrayList<String>();
	ArrayList<String> docFName = new ArrayList<String>();
	ArrayList<String> docLName = new ArrayList<String>();
	ArrayList<String> patId = new ArrayList<String>();
	ArrayList<String> patFName = new ArrayList<String>();
	ArrayList<String> patLName = new ArrayList<String>();
    
	while(rset != null && rset.next()){
		docId.add(rset.getString("DOCTOR_ID"));
		docFName.add(rset.getString("FIRST_NAME"));
		docLName.add(rset.getString("LAST_NAME"));
		patId.add(rset.getString(4));
		patFName.add(rset.getString(5));
		patLName.add(rset.getString(6));
	}

	/* display the result in the following table */
	out.println("<table BORDER=1>");
	out.println("<tr><td>Doctor ID</a></td>");
	out.println("    <td >Doctor Firstname</a></td>");
	out.println("    <td >Doctor Lastname</a></td>");
	out.println("    <td >Patient ID</a></td>");
	out.println("    <td >Patient Firstname</a></td>");
	out.println("    <td >Patient Lastname</a></td>"); 
	
	for(int i = 0; i < docId.size(); i++){
		out.println("<tr><td>"+ docId.get(i) + "</a></td>");
		out.println("    <td >"+ docFName.get(i) + "</a></td>");
		out.println("    <td >"+ docLName.get(i) +"</a></td>");
		out.println("    <td >"+ patId.get(i) +"</a></td>");
		out.println("    <td >"+ patFName.get(i) +"</a></td>");
		out.println("    <td >"+ patLName.get(i) +"</a></td>"); 
	}

	/* handle back request*/
	if(request.getParameter("Go back") != null){
		try{
			conn.close();
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		response.sendRedirect("/proj1/adminhomepage.jsp");
	}

	/* handle add family doctor and patient relationship */
	if(request.getParameter("AddFamDoc") != null 
		|| request.getParameter("DropFamDoc") != null ){
		
		/* retrieve the values from input fields*/
		String docID = (request.getParameter("Doctor")).trim();
		String patID = (request.getParameter("Patient")).trim();
		
		String docSql = "select * from users where person_id = '" 
			+ docID + "' and users.CLASS = 'd'";
		String patSql = "select * from users where person_id = '" 
			+ patID + "' and users.CLASS = 'p'";
		
		/* test if doctor id is an integer */
		if(docID.isEmpty() || !docID.matches("[0-9]+")){
	
			JOptionPane.showMessageDialog(null, "Incorrect Doctor ID Format.");
			try{
				conn.close();
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			return;
	
		}else if(patID.isEmpty() || !patID.matches("[0-9]+")){
			
			/* test if patient id is an integer */
			JOptionPane.showMessageDialog(null, "Incorrect Patient ID "
				+"Format.");	 
			try{
				conn.close();
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			return;
	
		}else if(!(rset = stmt.executeQuery(docSql)).next()){
		
			/* test if doctor id exists */
			JOptionPane.showMessageDialog(null, "Invalid Doctor ID.");
			try{
				conn.close();
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			return;
	
		}else if(!(rset = stmt.executeQuery(patSql)).next()){
	
			/* test if patient id exists */
			JOptionPane.showMessageDialog(null, "Invalid Patient ID.");
			try{
				conn.close();
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			return;
	
		}else{
			
			/* check if the new relationship has already existed in the table*/
			String checkSQL =  "select * from family_doctor where doctor_id='" 
				+ docID + "' and patient_id = '" + patID + "'";
			
			if(request.getParameter("AddFamDoc") != null 
				&& !(rset = stmt.executeQuery(checkSQL)).next()){
				String insertSQL = "insert into family_doctor values ('" + 
					docID + "', '" + patID + "')";
		
				/* update the table by executing insertSQL*/
				try{
					stmt.executeUpdate(insertSQL);
					conn.commit();
				}catch(Exception ex){
					try{
						conn.rollback();
					}catch(SQLException ex1){
						JOptionPane.showMessageDialog(null, "Database is busy now."
							+ " Please try later");
						conn.close();
						response.sendRedirect("editfamdoc.jsp");
						return;
					}				
				}
				
				JOptionPane.showMessageDialog(null, "The new family doctor"
					+" relationship has been added to database!");
				try{
					conn.close();
				}catch(Exception ex){
					out.println("<hr>" + ex.getMessage() + "<hr>");
				}
				response.sendRedirect("/proj1/editfamdoc.jsp");	    
		    
			}else if (request.getParameter("AddFamDoc") != null
					 && (rset = stmt.executeQuery(checkSQL)).next()){
	
				/* hanld the case when new relationship has existed */
	        	JOptionPane.showMessageDialog(null, "The family doctor "
	        		+"relationship already exists. Please try again.");
	        	try{
	        		conn.close();
				}catch(Exception ex){
					out.println("<hr>" + ex.getMessage() + "<hr>");
				}
	    		response.sendRedirect("/proj1/editfamdoc.jsp");	  
	    		return;
			}else{
				
				/* hanle the case of deleting */			
	    		String deleteSQL = "delete from family_doctor where "
	    			+"doctor_id = '"
	    			+ docID + "' and patient_id = '" + patID + "'";
	    		rset = stmt.executeQuery(checkSQL);
	    		
	    		/* if the relationship that needs to be deleted doesn not
	    		 * exist
	    		 */
	    		if(!rset.next()){
					JOptionPane.showMessageDialog(null, "The family doctor "
	    				+"relationship doesn't exist. Please try again.");
					try{
						conn.close();
					}catch(Exception ex){
						out.println("<hr>" + ex.getMessage() + "<hr>");
					}
					response.sendRedirect("/proj1/editfamdoc.jsp");	
					return;
				}else{
					/* else exist, delete the relationship */
					try{
			    		stmt.executeUpdate(deleteSQL);
			    		conn.commit();
			    	}catch(Exception ex){
			    		try{
			    			conn.rollback();
			    		}catch(SQLException ex1){
			    			JOptionPane.showMessageDialog(null, "Database is "
			    			+"busy now. Please try later");
			    			conn.close();
			    			response.sendRedirect("editfamdoc.jsp");
			    			return;
			    		}
			    	}
			    	
			    	JOptionPane.showMessageDialog(null, "The new family doctor"
			    		+" relationship has been removed from database!"); 
			    					
			    	/* close connection*/
			    	try{
			    		conn.close();
					}catch(Exception ex){
						out.println("<hr>" + ex.getMessage() + "<hr>");
					}
					response.sendRedirect("/proj1/editfamdoc.jsp");
					return;
				}
			}
		}
	
		try{
			conn.close();
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
}

%>



</BODY>
</HTML>
