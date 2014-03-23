<HTML>
<HEAD>


<TITLE>Update Information Page</TITLE>
</HEAD>

<BODY>

<%@ page
	import="java.sql.*,
	javax.portlet.ActionResponse.*,
	javax.swing.*,
	javax.servlet.*,
	org.apache.commons.lang.*"%>
<%
	Connection conn = null;
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

	try{
		Class drvClass = Class.forName(driverName); 
		DriverManager.registerDriver((Driver) drvClass.newInstance());
	}catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}

	try{
		conn = DriverManager.getConnection(dbstring,"mingxun",
				"hellxbox_4801");
		conn.setAutoCommit(false);
	}catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	Statement stmt = conn.createStatement();
	ResultSet rset = null;
	String userName = "";
	String passwd = "";
	String firstName = "";
	String lastName = "";
	String role = "";
	String email = "";
	String address = "";
	String phone = "";
	String sql;
	boolean success = false;
	
	if(session.getAttribute("updatePersonId")== null){
		JOptionPane.showMessageDialog(null, "Sorry, I'm lame."
		+" I lost the id of the person you want to update!");
		response.sendRedirect("adminhomepage.jsp");
	}else if(request.getParameter("back") != null){
		session.removeAttribute("updatePersonId");
		response.sendRedirect("adminhomepage.jsp");		
	}else if(request.getParameter("bUpdate") != null){	 
		
		userName = (request.getParameter("USERID")).trim();
		passwd = (request.getParameter("PASSWD")).trim();
		firstName = request.getParameter("FNAME");
		lastName = request.getParameter("LNAME");
		role  = request.getParameter("CLASS");
		email = (request.getParameter("EMAIL")).trim();
		address = StringEscapeUtils.escapeJava(
			(request.getParameter("ADDRESS")));
		phone = request.getParameter("PHONE");
	
	
		sql = "SELECT * FROM USERS WHERE PERSON_ID='"
			+ session.getAttribute("updatePersonId") +"'";
		
		try{
			rset = stmt.executeQuery(sql);			
		}catch(Exception ex){
			JOptionPane.showMessageDialog(null, ex.getMessage()
					+ "Please try again later!");
			tryAgain(conn, response);
		}
		
		if(!userName.matches("\\w+\\.?")){
			JOptionPane.showMessageDialog(null, "The username can only contain a-z,"
				+" A-Z, 0-9.");
		}else if(rset != null && rset.next() &&
			!(rset.getString("PERSON_ID")).equals(
				session.getAttribute("updatePersonId"))){
			JOptionPane.showMessageDialog(null,"This username is taken.");
		}else if(passwd.length() < 1){
			out.println("<p><b>Password can't be empty!</b></p>");
		}else if(!passwd.matches("\\w+\\.?")){
			JOptionPane.showMessageDialog(null,"The password can only contain a-z,"
				+ " A-Z, 0-9.");
		}else if(firstName != null && !firstName.isEmpty() 
				&& !firstName.matches("[a-zA-Z]+\\.?")){
			JOptionPane.showMessageDialog(null,"The first name can only contain "
				+ "alphabets.");
		}else if(lastName != null && !lastName.isEmpty() 
				&& !lastName.toLowerCase().matches("[a-zA-Z]+\\.?")){
			JOptionPane.showMessageDialog(null,"The last name can only contain "
				+ "alphabets.");
		}else if(role == null){
			JOptionPane.showMessageDialog(null,"Please pick a class.");
		}else if(email != null && !email.isEmpty()
				&& !email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)"
			+ "*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")){
			JOptionPane.showMessageDialog(null,"The email address contains illegal "
			+ "characters.");
		}else if(phone != null && !phone.isEmpty() &&
			( phone.length() != 10 || !phone.matches("[0-9]+"))){
			JOptionPane.showMessageDialog(null,"Please make sure the phone number "
			+ "is valid.");
		}else{			
			PreparedStatement updatePersons = null;
			PreparedStatement updateUsers = null;
			
			String sqlPersons = "UPDATE PERSONS SET " 
				+ "FIRST_NAME = ?, LAST_NAME = ?, ADDRESS = ?, EMAIL = ?, "
				+ "PHONE = ? WHERE PERSON_ID='"
				+ session.getAttribute("updatePersonId") + "'";
			
			String sqlUsers = "UPDATE USERS SET "
				+ "USER_NAME = ?, PASSWORD = ?, CLASS = ? WHERE PERSON_ID='"
				+ session.getAttribute("updatePersonId") + "'";
			
			try{
				updatePersons = conn.prepareStatement(sqlPersons);
				updatePersons.setString(1, firstName);
				updatePersons.setString(2, lastName);
				updatePersons.setString(3, address);
				updatePersons.setString(4, email.toLowerCase());
				updatePersons.setString(5, phone);
				updatePersons.executeUpdate();
				conn.commit();
			
			}catch(Exception ex){
		        try{
		        	conn.rollback();
		        }catch(Exception ex2){
		        	out.println("<hr>" + ex2.getMessage() + "<hr>");
		        	JOptionPane.showMessageDialog(null, "Database busy.");
		        	try{
	                	conn.close();
					}catch(Exception ex1){
	                	out.println("<hr>" + ex1.getMessage() + "<hr>");
					}
		        	response.sendRedirect("updateuser.jsp");
		        }
			}
			
			try{
				updateUsers = conn.prepareStatement(sqlUsers);
				updateUsers.setString(1, userName);
				updateUsers.setString(2, passwd);
				updateUsers.setString(3, role);
				updateUsers.executeUpdate();
				conn.commit();
			}catch(Exception ex){
		        try{
		        	conn.rollback();
		        }catch(Exception ex2){
		        	out.println("<hr>" + ex2.getMessage() + "<hr>");
		        	JOptionPane.showMessageDialog(null, "Database busy.");
		        	try{
	                	conn.close();
					}catch(Exception ex1){
	                	out.println("<hr>" + ex1.getMessage() + "<hr>");
					}
		        	response.sendRedirect("updateuser.jsp");
		        }
			}
			session.removeAttribute("updatePersonId");
			success = true;
		}
		
		try{
			conn.close();
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		if(success){
			JOptionPane.showMessageDialog(null, "Your update is successful!");
			response.sendRedirect("/proj1/adminhomepage.jsp");	
		}else{
			response.sendRedirect("/proj1/updateuser.jsp");	
		}
		

	}else{
		
		sql = "select * from USERS where PERSON_ID = '"
			+ session.getAttribute("updatePersonId") +"'";
		
		try{
			rset = stmt.executeQuery(sql);
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		while(rset != null && rset.next()){
			userName = rset.getString("USER_NAME");
			passwd = rset.getString("PASSWORD");
			role = rset.getString("CLASS");
		}
		
		sql = "select * from PERSONS where PERSON_ID = '"
			+ session.getAttribute("updatePersonId") +"'";
		try{
			rset = stmt.executeQuery(sql);
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
	
		while(rset != null && rset.next()){
			firstName = (rset.getString("FIRST_NAME")==null) ? "" :rset.getString("FIRST_NAME");
			lastName = (rset.getString("LAST_NAME")== null) ? "" : rset.getString("LAST_NAME");
			address = (rset.getString("ADDRESS")==null) ? "" : rset.getString("ADDRESS"); 
			email = (rset.getString("EMAIL")==null) ? "" : rset.getString("EMAIL");
			phone = (rset.getString("PHONE")==null) ? "" : rset.getString("PHONE");
		}

		out.println("<b>Find out more help information by clicking " 
			+ " <a href='help.html#update' target='blank'>Help</a></b><br><br>");
		out.println("<form action=updateuser.jsp>");
		out.println("UserName  : <input type=text name=USERID value=" 
			+ userName + " maxlength=24 required>* can only contain alphabet"
			+ " and numbers.<br>");
		out.println("Password  : <input type=password name=PASSWD value" 
			+ passwd + " maxlength=24 required>* can only contain alphabets"
			+ " and numbers.<br>");
		out.println("First Name: <input type=text name=FNAME value='"
			+ firstName + "' maxlength=24 ><br>");
		out.println("Last  Name: <input type=text name=LNAME value='"
			+ lastName + "' maxlength=24 ><br>");
		out.println("<label for='admin'>Admin</label>");
		out.println("<input type=radio name=CLASS id=admin value=a"
			+ " required>");
		out.println("<label for='patient'>Patient</label>");
		out.println("<input type=radio name=CLASS id=patient value=p required>");
		out.println("<label for='radiologist'>Radiologist</label>");
		out.println("<input type=radio name=CLASS id=radiologist value=r "
			+"required>");
		out.println("<label for='doctor'>Doctor</label>");
		out.println("<input type=radio name=CLASS id=doctor value=d required>"
			+"<br>");
		out.println("Email     : <input type=text name=EMAIL value='" 
			+ email + "' maxlength=128 ><br>");
		out.println("Address   : <input type=text name=ADDRESS value=\""
			+ StringEscapeUtils.escapeHtml(address) +"\" maxlength=128"
			+ " ><br>");
		out.println("Phone     : <input type=text name=PHONE value=\""
			+ phone + "\" maxlenght=10  ><br>");
		out.println("<input type=submit name=bUpdate value=Save>");
		out.println("</form>");	
		out.println("<form action=adminhomepage.jsp>");
		out.println("<input type=submit name=Back value='Go Back'><br>");
		out.println("</form>");		
	}     
%>
<%!
private void tryAgain(Connection conn, HttpServletResponse response){
	try{
		conn.close();
	}catch(SQLException ex){
		java.lang.System.out.println(ex.getMessage());
	}finally{
		try{
			response.sendRedirect("updateuser.jsp");
		}catch(Exception ex){
			java.lang.System.out.println(ex.getMessage());
		}
	}
}
%>



</BODY>
</HTML>

