<HTML>
<HEAD>


<TITLE>Sign Up Page</TITLE>
</HEAD>

<BODY>

				<%@ page
								import="java.sql.*,javax.portlet.ActionResponse.*,javax.swing.*"%>
				<% 
   if(request.getParameter("bSignUp") != null){

	        //get the user input from the login page
     	String userName = (request.getParameter("USERID")).trim();
     	String passwd = (request.getParameter("PASSWD")).trim();
     	String firstName = (request.getParameter("FNAME")).trim();
     	String lastName = (request.getParameter("LNAME")).trim();
     	String role  = request.getParameter("CLASS");
     	String email = (request.getParameter("EMAIL")).trim();
		String address = (request.getParameter("ADDRESS")).trim();
		String phone = (request.getParameter("PHONE")).trim();
   		String pid = (request.getParameter("PID")).trim();

	        //establish the connection to the underlying database
     	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
         	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
	    try{
		        //load and register the driver
     		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());
	        }
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
	
     	try{
	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"mingxun","hellxbox_4801");
     		conn.setAutoCommit(false);
	        }
     	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
     	}

	        //select the user table from the underlying db and validate the user name and password
     	Statement stmt = conn.createStatement();
     	ResultSet rset = null;
     	String sql = "select user_name from USERS where USER_NAME = '"+userName+"'";
     	String emailCheck = "select email from PERSONS where EMAIL = '"+email.toLowerCase()+"'";

        //rset = stmt.executeQuery(sql);
   		if(pid.isEmpty() || pid == null){
			out.println("<p><b>Please indicate if registering a new user.</b></p>");   			
   		}else if(!userName.matches("\\w.*")){
			out.println("<p><b>The username can only contain a-z, A-Z, 0-9.</b></p>");
		}else if(stmt.executeQuery(sql).next()){
			out.println("<p><b>This username is taken.</b></p>");			
		}else if(passwd.isEmpty() || passwd == null || passwd.length() < 6){
			out.println("<p><b>Password's should be at least 6 characters.</b></p>");
		}else if(!passwd.matches("\\w.*")){
			out.println("<p><b>The password can only contain a-z, A-Z, 0-9.</b></p>");
		}else if(!firstName.matches("\\w+\\.?") ){
			out.println("<p><b>The first name can only contain alphabets.</b></p>");
		}else if(!lastName.toLowerCase().matches("[a-z].*")){
			out.println("<p><b>The last name can only contain alphabets.</b></p>");
		}else if("prd".indexOf(role) < 0 || role.length() != 1 || role.isEmpty() || role == null){
			out.println("<p><b>Invalid role. Please specify your identity by a signle character.<p><b>" +
					"<p><b>You are: a doctor(d), a radiologist(r), or a patient(p). </b></p>");
		}else if(!email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")){
			out.println("<p><b>The email address contains illegal characters.<p><b>");
		}else if(stmt.executeQuery(emailCheck).next()){
			out.println("<p><b>The email has been registered with other users.<p><b>");
                }else if(address.isEmpty() || address == null || address.length() < 1){
			out.println("<p><b>Please re-enter the address.<p><b>");
		}else if(phone.length() != 10 || phone.isEmpty() || phone == null || !phone.matches("[0-9]+")){
			out.println("<p><b>Please make sure the phone number is valid.<p><b>");
		}else{
			PreparedStatement insertPersons = null;
			PreparedStatement insertUsers = null;
			
			String sqlPersons = "INSERT INTO PERSONS" 
					+ "(PERSON_ID, FIRST_NAME, LAST_NAME, ADDRESS, EMAIL, PHONE) VALUES"
					+ "(?, ?, ?, ?, ?, ?)";
			String sqlUsers = "insert into USERS"
					+ "(USER_NAME, PASSWORD, CLASS, PERSON_ID, DATE_REGISTERED) VALUES"
					+ "(?, ?, ?, ?, ?)";
			int personId = 1;
			if(pid.equals("NU")){
			    ResultSet persons = null;
			    String sqlGetNextId = "select * from PERSONS";
			    persons = stmt.executeQuery(sqlGetNextId);
			    out.println(persons);
			    while(persons.next()){
				personId++;
			     }
                         }else{
			    personId = Integer.parseInt(JOptionPane.showInputDialog(null, "Please enter the person id: "));
			 }

		
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
		        out.println("<hr>" + ex.getMessage() + "<hr>");
	
	        }
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
		        		 out.println("<hr>" + ex.getMessage() + "<hr>");
	
			}
			
		try{
                conn.close();
			}
			catch(Exception ex){
                out.println("<hr>" + ex.getMessage() + "<hr>");
			}
			
				JOptionPane.showMessageDialog(null, "The user has been registered successfully!");
				response.sendRedirect("/proj1/adminhomepage.jsp");	
				
		}
		
     }  
                                                                                    
		out.println("<b>Find out more help information by clicking <a href='help.html#signUp' target='blank'>Help</a></b><br><br>");								   
		out.println("<form action=SignUp.jsp>");
		out.println("<p><b>Sign Up a New Account for: </b><p>");
		out.println("<label for='existing user'>Existing User</label>");
		out.println("<input type=radio name=PID id=EU value=old required>");
		out.println("<label for='new user'>New User</label>");
		out.println("<input type=radio name=PID id=NU value=new required><br>");
		out.println("UserName  : <input type=text name=USERID maxlength=20 required><br>");
		out.println("Password  : <input type=password name=PASSWD maxlength=20 required><br>");
		out.println("First Name: <input type=text name=FNAME maxlength=24 required><br>");
		out.println("Last  Name: <input type=text name=LNAME maxlength=24 required><br>");
		out.println("<label for='patient'>Patient</label>");
		out.println("<input type=radio name=CLASS id=patient value=p required>");
		out.println("<label for='radiologist'>Radiologist</label>");
		out.println("<input type=radio name=CLASS id=radiologist value=r required>");
		out.println("<label for='doctor'>Doctor</label>");
		out.println("<input type=radio name=CLASS id=doctor value=d required><br>");
		out.println("Email     : <input type=email name=EMAIL maxlength=128 required><br>");
		out.println("Address   : <input type=text name=ADDRESS maxlength=128 required><br>");
		out.println("Phone     : <input type=text name=PHONE maxlenght=10 required><br>");
		out.println("<input type=submit name=bSignUp value=SignUp>");
                out.println("</form>");
		out.println("<form action=adminhomepage.jsp>");
		out.println("<input type=submit name=Back value='Go Back'><br>");
                out.println("</form>");										 
     
        
%>



</BODY>
</HTML>

