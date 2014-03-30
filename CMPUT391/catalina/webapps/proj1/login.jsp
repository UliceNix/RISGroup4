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


<TITLE>Welcome to RIS</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,javax.portlet.ActionResponse.*,javax.swing.*" %>
<% 
	if(request.getParameter("bLogin") != null){
		
		//get the user input from the login page
		String userName = (request.getParameter("USERID")).trim();
		String passwd = (request.getParameter("PASSWD")).trim();
		out.println("<p>Your input User Name is "+userName+"</p>");
		out.println("<p>Your input password is "+passwd+"</p>");

		//establish the connection to the underlying database
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
	
	
		/*select the user table from the underlying db and validate 
		 *the user name and password
		 */
		Statement stmt = null;
		ResultSet rset = null;
		String sql = "select PASSWORD from USERS where USER_NAME = '"
			+userName+"'";

		try{
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		/* retrieve the password */
		String truepwd = "";
	
		while(rset != null && rset.next())
			truepwd = (rset.getString(1)).trim();
	
		/* compare the password with the input one, if matches direct the user
		 * to his/her homepage depending on his/her class. Or else, let the 
		 * user try again. 
		 */
		if(passwd.equals(truepwd) && passwd != null && !passwd.isEmpty()){
	    	
			session.setAttribute("UserName", userName);
	        
			/* try to get the class of the current user */
			sql = "select CLASS from USERS where USER_NAME = '"+userName+"'";
			try{
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);			
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");			
			}
			
			String role = "";
			while(rset.next()){
				role = (rset.getString(1)).trim();
			}
		
			/* retrieve the person id of current user */
			sql = "select person_id from users where USER_NAME = '"
				+userName+"'";
			try{
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);			
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");			
			}
			
			int person_id = 0;
			while(rset.next()){
				person_id = rset.getInt(1);
			}
			
			/* close connection */
			try{
				conn.close();
			}
				catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			
			session.setAttribute("Person_Id", person_id);
			session.setAttribute("PermissionLevel", role);
			
			/* direct the user to his/her homepage */
			if(role.equals("a")){			
				response.sendRedirect("/proj1/adminhomepage.jsp");
			}else{
				response.sendRedirect("/proj1/homepage.jsp");
			}
	
		}else{
			
			/* print out error message*/
			JOptionPane.showMessageDialog(null, "Either your username or "
				+"your password is invalid, please try again!");
						
			/* close conenction */
			try{
				conn.close();
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			response.sendRedirect("/proj1/login.jsp");
		}

		
	}else{
		
		/* print out the log in page */
		out.println("<b>Find out more help information by clicking "
			+ "<a href='help.html#logIn' target='blank'>Help</a>"
			+ "</b><br><br>");
		out.println("<form action=login.jsp>");
		out.println("UserName: <input type=text name=USERID maxlength=20"
			+ " required><br>");
		out.println("Password: <input type=password name=PASSWD "
			+ "required maxlength=20><br>");
		out.println("<input type=submit name=bLogin value='Log In'>");
		out.println("</form>");   
	}      
%>



</BODY>
</HTML>

