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


<TITLE>Sign Up</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,javax.portlet.ActionResponse.*,javax.swing.*"%>
<% 
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");
	
	/* in case the session expires, system will redirect the user to log in*/
    if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
    }
	
	if(request.getParameter("bSignUp") != null){
		
		/* get the user input from the login page */
		String userName = (request.getParameter("USERID")).trim();
		String passwd = (request.getParameter("PASSWD")).trim();
		String firstName = (request.getParameter("FNAME")).trim();
		String lastName = (request.getParameter("LNAME")).trim();
		String role  = request.getParameter("CLASS");
		String email = (request.getParameter("EMAIL")).trim();
		String address = (request.getParameter("ADDRESS")).trim();
		String phone = (request.getParameter("PHONE")).trim();
		String pid = (request.getParameter("PID")).trim();

		/* establish the connection to the underlying database */
		Connection conn = null;
	
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
		try{
			/* load and register the driver */
			Class drvClass = Class.forName(driverName); 
			DriverManager.registerDriver((Driver) drvClass.newInstance());
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		try{
			/* establish the connection  */
			conn = DriverManager.getConnection(dbstring,"mingxun",
				"hellxbox_4801");
			conn.setAutoCommit(false);
		}catch(Exception ex){
	       		out.println("<hr>" + ex.getMessage() + "<hr>");
		}

		/*select the user table from the underlying db and validate the 
		 *user name and password
		 */
		Statement stmt = conn.createStatement();
		ResultSet rset = null;
		
		String sql = "select user_name from USERS where USER_NAME = '"
			+ userName + "'";
		
		/* regular expression and logic check
		 * • password and username can only contain alphabets and numbers
		 * • usernames are unique.
		 * • first name and last name can only consist of alphabets
		 * • phone number is 10-digit long.
		 */
		if(!userName.matches("\\w+\\.?")){
			JOptionPane.showMessageDialog(null, "The username can only "
				+"contain a-z, A-Z.");
		}else if(stmt.executeQuery(sql).next()){
			JOptionPane.showMessageDialog(null,"This username is taken.");
		}else if(passwd.length() < 1){
			out.println("<p><b>Password can't be empty!</b></p>");
		}else if(!passwd.matches("\\w+\\.?")){
			JOptionPane.showMessageDialog(null,"The password can only contain"
			+" a-z, A-Z, 0-9.");
		}else if(firstName != null && !firstName.isEmpty() 
				&& !firstName.matches("[a-zA-Z]+\\.?")){
			JOptionPane.showMessageDialog(null,"The first name can only "
				+"contain alphabets.");
		}else if(lastName != null && !lastName.isEmpty() 
				&& !lastName.toLowerCase().matches("[a-zA-Z]+\\.?")){
			JOptionPane.showMessageDialog(null,"The last name can only "
				+"contain alphabets.");
		}else if(role == null){
			JOptionPane.showMessageDialog(null,"Please pick a class.");
		}else if(email != null && !email.isEmpty()
				&& !email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)"
			+ "*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")){
			JOptionPane.showMessageDialog(null,"The email address contains "
				+"illegal characters.");
		}else if(phone != null && !phone.isEmpty() &&
			( phone.length() != 10 || !phone.matches("[0-9]+"))){
			JOptionPane.showMessageDialog(null,"Please make sure the phone "
				+"number is valid.");
		}else{
			
			/* if passed all tests, try to insert new record into both
			 * persons table and users table by using PreparedStatement
			 */
			PreparedStatement insertPersons = null;
			PreparedStatement insertUsers = null;
			
			String sqlPersons = "INSERT INTO PERSONS" 
				+ "(PERSON_ID, FIRST_NAME, LAST_NAME, ADDRESS, EMAIL, "
				+"PHONE) VALUES (?, ?, ?, ?, ?, ?)";
			String sqlUsers = "insert into USERS"
				+ "(USER_NAME, PASSWORD, CLASS, PERSON_ID, DATE_REGISTERED)" 
				+ " VALUES (?, ?, ?, ?, ?)";
			
			int personId = 1;
			
			/* Generating the new person Id if registering a new user
			 * or pop up an input window to prompt for user id
			 */
			if(pid.equals("new")){
				ResultSet persons = null;
				String sqlGetNextId = "select max(person_id) from PERSONS";
				try{
					persons = stmt.executeQuery(sqlGetNextId);	
				}catch (Exception ex){
					out.println("<hr>" + ex.getMessage() + "<hr>");
				}
				persons.next();
				personId = persons.getInt(1) + 1;
			}else{
				boolean proceed = false;
				
				while(!proceed){
					boolean success = false;
					String inputId = JOptionPane.showInputDialog(null,
						"Please enter the person id: ");
					
					try{
						personId = Integer.parseInt(inputId);
						success = true;
					}catch(Exception ex){
						JOptionPane.showMessageDialog(null, "Please "
						+"enter only numbers! Please try again.");
					}
					if(success){
						ResultSet test = null;
						try{
							test = stmt.executeQuery("select * from users "
							+"where person_id='" + personId + "'");
						}catch(Exception ex){
							out.println("<hr>" + ex.getMessage() + "<hr>");
						}
						if(test != null && test.next()){
							proceed = true;
						}
					}
				}
					
			}

			/* Carry out update action on Persons table*/
			try{
				insertPersons = conn.prepareStatement(sqlPersons);
				insertPersons.setInt(1, personId);
				insertPersons.setString(2, firstName);
				insertPersons.setString(3, lastName);
				insertPersons.setString(4, address);
				insertPersons.setString(5, email.toLowerCase());
				insertPersons.setString(6, phone);
				insertPersons.executeUpdate();
				conn.commit();
			}catch(Exception ex){
		        try{
		        	conn.rollback();
		        }catch(Exception ex2){
		        	out.println("<hr>" + ex2.getMessage() + "<hr>");
		        	JOptionPane.showMessageDialog(null,"Database busy.");
		        	try{
	                	conn.close();
					}catch(Exception ex1){
	                	out.println("<hr>" + ex1.getMessage() + "<hr>");
					}
		        	response.sendRedirect("SignUp.jsp");
		        }
			}
			
			/* Carry out update action on USERS table*/
			try{
				insertUsers = conn.prepareStatement(sqlUsers);
				java.util.Date utilDate = new java.util.Date();
				java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
				insertUsers.setString(1, userName);
				insertUsers.setString(2, passwd);
				insertUsers.setString(3, role);
				insertUsers.setInt(4, personId);
		    	insertUsers.setDate(5, sqlDate);
				insertUsers.executeUpdate();
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
		        	response.sendRedirect("SignUp.jsp");
		        }
			}
			
			/* close connection */
			try{
                conn.close();
			}catch(Exception ex){
                out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			
			JOptionPane.showMessageDialog(null, "The user has been registered"
				+" successfully!");
			response.sendRedirect("/proj1/adminhomepage.jsp");		
		}
	}  
                
	/* UI part */
	out.println("<b>Find out more help information by clicking "
		+ "<a href='help.html#signUp' target='blank'>Help</a></b>"
		+ "<br><br>");								   
	out.println("<form action=SignUp.jsp>");
	out.println("<p><b>Sign Up a New Account for: </b><p>");
	out.println("<label for='existing uer'>Existing User</label>");
	out.println("<input type=radio name=PID id=EU value=old required>");
	out.println("<label for='new user'>New User</label>");
	out.println("<input type=radio name=PID id=NU value=new required><br>");
	out.println("UserName  : <input type=text name=USERID maxlength=20 "
		+ ">* please use only letters and numbers <br>");
	out.println("Password  : <input type=password name=PASSWD maxlength=20"
		+" >* please use only letters and numbers <br>");
	out.println("First Name: <input type=text name=FNAME maxlength=24"
		+" ><br>");
	out.println("Last  Name: <input type=text name=LNAME maxlength=24"
		+" ><br>");
	out.println("<label for='patient'>Patient</label>");
	out.println("<input type=radio name=CLASS id=patient value=p required>");
	out.println("<label for='radiologist'>Radiologist</label>");
	out.println("<input type=radio name=CLASS id=radiologist value=r "
		+ "required>");
	out.println("<label for='doctor'>Doctor</label>");
	out.println("<input type=radio name=CLASS id=doctor value=d"
		+ "required>");
	out.println("<label for='admin'>Admin</label>");
	out.println("<input type=radio name=CLASS id=admin value=a"
		+ " required><br>");
	out.println("Email     : <input type=text name=EMAIL maxlength=128"
		+ " ><br>");
	out.println("Address   : <input type=text name=ADDRESS maxlength=128"
		+ " ><br>");
	out.println("Phone     : <input type=text name=PHONE maxlenght=10"
		+ " ><br>");
	out.println("<input type=submit name=bSignUp value=SignUp>");
	out.println("</form>");
	out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br>");
	out.println("</form>");										 
      
%>



</BODY>
</HTML>

