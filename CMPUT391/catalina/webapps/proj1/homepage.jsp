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


<TITLE>Homepage</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*" %>
<% 
	/**********************************************************
	*    	User Interface Section
	***********************************************************/
   	out.println("<p><b>Welcome to your homepage " 
		+ session.getAttribute("UserName") + "!</b></p>");
   	out.println("<p>You could change your password and your personal "
		+ "information.</p>");
   	out.println("<p>And you could also enter the search module to "
		+ "search for radiology records.</p>");
   	out.println("For more help information, please click on <a "
		+ "href='help.html#homepage' target=blank>Help </a><br>");
				
	out.println("<br><hr><b>Edit Your Personal Information<b><hr>")	;		
   	out.println("<form action=homepage.jsp>");
   	out.println("<input type=submit name=ChangePassword value='Change "
   		+ "Password' style='width: 200px'>");
   	out.println("</form>");
   	out.println("<form action=homepage.jsp>");
   	out.println("<input type=submit name=ChangeFirstName value='Change "
   		+ "Firstname' style='width: 200px'><br>");
   	out.println("</form>");
   	out.println("<form action=homepage.jsp>");
   	out.println("<input type=submit name=ChangeLastName value='Change "
   		+ "Lastname' style='width: 200px'>");
   	out.println("</form>");
   	out.println("<form action=homepage.jsp>");
   	out.println("<input type=submit name=ChangeAddress value='Change "
   		+ "Address' style='width: 200px'><br>");
   	out.println("</form>");
   	out.println("<form action=homepage.jsp>");
   	out.println("<input type=submit name=ChangePhoneNumber value='Change "
   		+ "Phone Number' style='width: 200px'>");
   	out.println("<hr>");

   	out.println("<b> Function </b><hr>");
   
   	if(session.getAttribute("PermissionLevel").equals("r")){
   		out.println("</form>");
   		out.println("<form action=newrecord.jsp>");
   		out.println("<input type=submit name=NewRecord value='Create a "
   			+"New Radiology Record' style='width: 200px'><br>");
   		out.println("</form>");
   	}
   	
   	out.println("</form>");
   	out.println("<form action=search.jsp>");
   	out.println("<input type=submit name=SearchEngine value='Enter "
   		+"Search Engine' style='width: 200px'><br>");
   	out.println("</form>");

   	out.println("</form>");
   	out.println("<form action=homepage.jsp>");
   	out.println("<input type=submit name=LogOut value='Log Out'"
   		+" style='width: 200px'><br>");
   	out.println("</form>");
   	out.println("<hr>");
   	
   	if(session.getAttribute("Person_Id") == null){
   		response.sendRedirect("login.jsp");
   		return;
   	}
   	
   	/* handling a user's request of changing password
   	 * part 1) change password 
   	 * part 2) save password
   	 * part 3) return or try again
   	 */
   	if(request.getParameter("ChangePassword") != null 
   		|| request.getParameter("TryPassword") != null){
       	out.println("<br>");
       	out.println("<form action=homepage.jsp>");
       	out.println("Old Password: <input type=password name=OLDPWD"
       		+"  maxlength=20 required><br>");
       	out.println("New Password: <input type=password name=NEWPWD"
       		+"  maxlength=20 required><br>");
       	out.println("<input type=submit name=SavePassword value=Save>");
       	out.println("</form>");
   	}		
   
   	if(request.getParameter("SavePassword") != null){
   		
   		/* get the values of old and new passwords*/
   		String oldPassword = (request.getParameter("OLDPWD")).trim();
   		String newPassword = (request.getParameter("NEWPWD")).trim();
   
   		/* get a conneciton*/
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
	   
   		/* test if old password matches the password stored in databse*/
	   	Statement stmt = null;
	   	ResultSet rset = null;
	   	
	   	String sql = "select PASSWORD from USERS where USER_NAME = '"
	   		+session.getAttribute("UserName")+"'";
		try{
	   		stmt = conn.createStatement();
	   		rset = stmt.executeQuery(sql);
	   	}catch(Exception ex){
	   		out.println("<hr>" + ex.getMessage() + "<hr>");
	   	}
			  
	   	String truepwd = "";
	   	while(rset != null && rset.next())
	   		truepwd = (rset.getString(1)).trim();
	
	   	/* handle error situations */
	   	if(oldPassword == null 
	   			|| oldPassword.isEmpty()
	   			|| !oldPassword.equals(truepwd) ){
	   		out.println("<br>");
	   		out.println("<p>Your old password is incorrect.</p>");
	   		out.println("<form action=homepage.jsp>");
	   		out.println("<input type=submit name=TryPassword "
	   			+ "value='Try Again'>");
	   		out.println("</form>");
	   	}else if (!newPassword.matches("\\w+\\.?")){
	   		out.println("<br>");
	   		out.println("<p>Your new password contains illegal "
	   			+ "characters.</p>");
	   		out.println("<form action=homepage.jsp>");
	   		out.println("<input type=submit name=TryPassword "
	   			+ "value='Try Again'>");
	   		out.println("</form>");		    	  
	   	}else if(oldPassword.equals(truepwd)){
	   		
	   		/* after authentication, update the new password */
	  		 sql = "update USERS set password='"+newPassword
	  	 		+ "' where user_name='"+session.getAttribute("UserName")+"'";
		 		 
			try{
	  			stmt = conn.createStatement();
	  			stmt.executeUpdate(sql);
				conn.commit();
	   		}catch(Exception ex){
	  			 try{
	  				 conn.rollback();
	  			 }catch(SQLException ex1){
		    		JOptionPane.showMessageDialog(null, "Database is "
	  			 		+"busy now. Please try later");
		    		conn.close();
		    		response.sendRedirect("homepage.jsp");
	  			 	return;
		    	}
	  		}finally{
	  			try{
	  				conn.close();
	  			}catch(Exception ex){
	  				out.println("<hr>" + ex.getMessage() + "<hr>");
	  			}
	  		}	   
	  		JOptionPane.showMessageDialog(null, "Your password has been "
	  			+ "reset!");
			response.sendRedirect("/proj1/homepage.jsp");
	     
	   	}
	}

   	/* change first name
   	 * 1. change first name
   	 * 2. save first name
   	 * 3. try again
   	 */
	if(request.getParameter("ChangeFirstName") != null 
		|| request.getParameter("TryFirstName") != null){
		out.println("<br>");
		out.println("<form action=homepage.jsp>");
		out.println("New Firstname: <input type=text name=NewFirstName"
			+ "  maxlength=24 required><br>");
		out.println("<input type=submit name=SaveFirstName value=Save>");
		out.println("</form>");
	}	

	if(request.getParameter("SaveFirstName") != null){
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
   
   		
   		Statement stmt = null;
   		ResultSet rset = null;
		String sql;
		
		/* get the user's new first name*/
		String newFirstname = (request.getParameter("NewFirstName")).trim();
		
		/* test if the first name contains only letter*/
		if(!newFirstname.matches("[a-zA-Z]+\\.?") 
			|| newFirstname == null || newFirstname.isEmpty()){
			out.println("<br>");
   			out.println("<p>Your new first name contains illegal "
				+ "characters.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryFirstName "
   				+ "value='Try Again'>");
   			out.println("</form>");		
		}else{
			
			/* if pass, update the new first name*/
			sql = "update PERSONS set FIRST_NAME='"+newFirstname
				+"' where PERSON_ID = (select PERSON_ID from USERS where" 
				+" user_name='"+session.getAttribute("UserName")+"')";
		 	
			try{
	  			stmt = conn.createStatement();
	  			stmt.executeUpdate(sql);
				conn.commit();
	   		}catch(Exception ex){
	  			 try{
	  				 conn.rollback();
	  			 }catch(SQLException ex1){
		    		JOptionPane.showMessageDialog(null, "Database is busy "
	  			 		+" now. Please try later");
		    		conn.close();
		    		response.sendRedirect("homepage.jsp");
		    	}
	  		}finally{
	  			try{
	  				conn.close();
	  			}catch(Exception ex){
	  				out.println("<hr>" + ex.getMessage() + "<hr>");
	  			}
	  		}
   
  			JOptionPane.showMessageDialog(null, "Your first name has "
  				+"been reset to " + newFirstname + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		}
	}
	
   	/* change last name
   	 * 1. change last name
   	 * 2. save last name
   	 * 3. try again
   	 */	
	if(request.getParameter("ChangeLastName") != null 
		|| request.getParameter("TryLastName") != null){
		out.println("<br>");
		out.println("<form action=homepage.jsp>");
		out.println("New Lastname: <input type=text name=NewLastName"
       		+"  maxlength=24 required><br>");
		out.println("<input type=submit name=SaveLastName value=Save>");
		out.println("</form>");
	}	

	if(request.getParameter("SaveLastName") != null){
		
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
   
   
   		Statement stmt = null;
   		ResultSet rset = null;
		String sql;

		String newLastname = (request.getParameter("NewLastName")).trim();
	
		if(!newLastname.matches("[a-zA-Z]+\\.?") 
			|| newLastname == null || newLastname.isEmpty()){
			out.println("<br>");
   			out.println("<p>Your new last name contains illegal "
				+ "characters.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryLastName "
   				+"value='Try Again'>");
   			out.println("</form>");		
		}else{
			sql = "update PERSONS set LAST_NAME='"+newLastname
				+"' where PERSON_ID = (select PERSON_ID from USERS where" 
				+" user_name='"+session.getAttribute("UserName")+"')";
		 		 
			try{
	  			stmt = conn.createStatement();
	  			stmt.executeUpdate(sql);
				conn.commit();
	   		}catch(Exception ex){
	  			 try{
	  				 conn.rollback();
	  			 }catch(SQLException ex1){
		    		JOptionPane.showMessageDialog(null, "Database is busy"
	  			 		+" now. Please try later");
		    		conn.close();
		    		response.sendRedirect("homepage.jsp");
		    	}
	  		}finally{
	  			try{
	  				conn.close();
	  			}catch(Exception ex){
	  				out.println("<hr>" + ex.getMessage() + "<hr>");
	  			}
	  		}
   
  			JOptionPane.showMessageDialog(null, "Your last name has been"
  				+ " reset to "+ newLastname + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		}
	}

	if(request.getParameter("ChangeAddress") != null 
		|| request.getParameter("TryAddress") != null){
       		out.println("<br>");
       		out.println("<form action=homepage.jsp>");
       		out.println("New Address: <input type=text name=NEWADD  "
       			+ "maxlength=128 required><br>");
       		out.println("<input type=submit name=SaveAddress value=Save>");
       		out.println("</form>");
	}

	if(request.getParameter("SaveAddress") != null){
		String newAddress = (request.getParameter("NEWADD")).trim();
		
		if(newAddress == null || newAddress.isEmpty()){
			out.println("<br>");
   			out.println("<p>Your new address is empty.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryAddress value="
   				+"'Try Again'>");
   			out.println("</form>");		
		}else{
			Connection conn = null;
   			String driverName = "oracle.jdbc.driver.OracleDriver";
   			String dbstring = "jdbc:oracle:thin:@gwynne.cs."
   				+"ualberta.ca:1521:CRS";
   
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
   
   
   			PreparedStatement updateAddress = null;
			String sql = "update PERSONS set ADDRESS = ?" 
				+ " WHERE PERSON_ID=(SELECT PERSON_ID FROM USERS"
				+ " WHERE USER_NAME='"+session.getAttribute("UserName")+"')";
			updateAddress = conn.prepareStatement(sql);
			
			try{
				updateAddress.setString(1, newAddress);
				updateAddress.executeUpdate();
				conn.commit();
			}catch(Exception ex){
				 try{
	  				 conn.rollback();
	  			 }catch(SQLException ex1){
		    		JOptionPane.showMessageDialog(null, "Database is busy "
	  			 		+"now. Please try later");
		    		conn.close();
		    		response.sendRedirect("homepage.jsp");
		    	}
  		 	}finally{
	  			try{
	  				conn.close();
	  			}catch(Exception ex){
	  				out.println("<hr>" + ex.getMessage() + "<hr>");
	  			}
	  		}

			JOptionPane.showMessageDialog(null, "Your address has been"
				+ " reset to " + newAddress + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		
		}
	}
	
   	/* change phone number
   	 * 1. change phone number
   	 * 2. save phone number
   	 * 3. success or try again
   	 */
	if(request.getParameter("ChangePhoneNumber") != null ||
		request.getParameter("TryPhoneNumber") != null){
       		out.println("<br>");
       		out.println("<form action=homepage.jsp>");
       		out.println("New Phone: <input type=text name=NEWPHONE"
       			+ "  maxlength=10 required><br>");
       		out.println("<input type=submit name=SavePhone value=Save>");
       		out.println("</form>");		
	}
	
	if(request.getParameter("SavePhone") != null){
		
		String newPhone = (request.getParameter("NEWPHONE").trim());
		
		/* test if the new phone number is valid*/
		if(newPhone.length() != 10 || newPhone.isEmpty() 
			|| newPhone == null || !newPhone.matches("[0-9]+")){
			out.println("<br>");
   			out.println("<p>You phone number is not a valid phone "
				+ "number.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryPhoneNumber "
   				+ "value='Try Again'>");
   			out.println("</form>");	
		}else{
			
			/* if the number is valid, then upload it. */
			Connection conn = null;
   			String driverName = "oracle.jdbc.driver.OracleDriver";
   			String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta."
   				+"ca:1521:CRS";
   
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
   
   			Statement stmt = null;
   			
   			/* update the new phone number to database */
			String sql = "update PERSONS set PHONE='"+ newPhone + "'"
				+ " WHERE PERSON_ID=(SELECT PERSON_ID FROM USERS"
				+ " WHERE USER_NAME='"+session.getAttribute("UserName")+"')";
			
			try{
	  			stmt = conn.createStatement();
	  			stmt.executeUpdate(sql);
				conn.commit();
	   		}catch(Exception ex){
	  			 try{
	  				 conn.rollback();
	  			 }catch(SQLException ex1){
		    		JOptionPane.showMessageDialog(null, "Database is busy"
	  			 		+" now. Please try later");
		    		conn.close();
		    		response.sendRedirect("homepage.jsp");
		    	}
	  		}finally{
	  			try{
	  				conn.close();
	  			}catch(Exception ex){
	  				out.println("<hr>" + ex.getMessage() + "<hr>");
	  			}
	  		}
	
			out.println(sql);
			JOptionPane.showMessageDialog(null, "Your phone has been reset "
				+"to " + newPhone + " !");
			response.sendRedirect("/proj1/homepage.jsp");			
		}
		
	}

	if(request.getParameter("LogOut") != null){
	    session.removeAttribute("UserName");
	    session.removeAttribute("Person_Id");
	    session.removeAttribute("PermissionLevel");
	    JOptionPane.showMessageDialog(null, "You have been logged out "
	    	+"successfully!");
	    response.sendRedirect("/proj1/login.jsp");		
	}
%>



</BODY>
</HTML>
