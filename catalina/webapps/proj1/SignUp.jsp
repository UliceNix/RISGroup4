<HTML>
<HEAD>


<TITLE>Sign Up Page</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*" %>
<% 
   if(request.getParameter("bSignUp") != null){

	        //get the user input from the login page
     	String userName = (request.getParameter("USERID")).trim();
     	String passwd = (request.getParameter("PASSWD")).trim();
     	String firstName = (request.getParameter("FNAME")).trim();
     	String lastName = (request.getParameter("LNAME")).trim();
     	String role  = (request.getParameter("CLASS")).trim();
     	String email = (request.getParameter("EMAIL")).trim();
		String address = (request.getParameter("ADDRESS")).trim();
		String phone = (request.getParameter("PHONE")).trim();

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
     	String emailCheck = "select count(email) from PERSONS where EMAIL = '"+email+"'";
        out.println(sql);
        //rset = stmt.executeQuery(sql);

		if(!userName.matches("\\w.*")){
			out.println("<p><b>The username can only contain a-z, A-Z, 0-9.</b></p>");
		}else if(stmt.executeQuery(sql).next()){
			out.println("<p><b>This username is taken.</b></p>");			
		}else if(passwd.isEmpty() || passwd == null || passwd.length() < 6){
			out.println("<p><b>Password's should be at least 6 characters.</b></p>");
		}else if(!passwd.matches("\\w.*")){
			out.println("<p><b>The password can only contain a-z, A-Z, 0-9.</b></p>");
		}else if(!firstName.toLowerCase().matches("[a-z].*")){
			out.println("<p><b>The first name can only contain alphabets.</b></p>");
		}else if(!lastName.toLowerCase().matches("[a-z].*")){
			out.println("<p><b>The last name can only contain alphabets.</b></p>");
		}else if("prd".indexOf(role) < 0 || role.length() != 1 || role.isEmpty() ||role == null){
			out.println("<p><b>Invalid role. Please specify your identity by a signle character.<p><b>" +
					"<p><b>You are: a doctor(d), a radiologist(r), or a patient(p). </b></p>");
		}else if(!email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")){
			out.println("<p><b>Your email address contains illegal characters.<p><b>");
		}else if(address.isEmpty() || address == null || address.length() < 1){
			out.println("<p><b>Please re-enter your address.<p><b>");
		}else if(phone.length() != 10 || phone.isEmpty() || phone == null){
			out.println("<p><b>Please make sure your phone number is valid.<p><b>");
		}else{
			PreparedStatement insertPersons = null;
			PreparedStatement insertUsers = null;
			
			String sqlPersons = "INSERT INTO PERSONS" 
					+ "(PERSON_ID, FIRST_NAME, LAST_NAME, ADDRESS, EMAIL, PHONE) VALUES"
					+ "(?, ?, ?, ?, ?, ?)";
			String sqlUsers = "insert into USERS"
					+ "(USER_NAME, PASSWORD, CLASS, PERSON_ID, DATE_REGISTERED) VALUES"
					+ "(?, ?, ?, ?, ?)";
			
			ResultSet persons = null;
			String sqlGetNextId = "select * from PERSONS";
			persons = stmt.executeQuery(sqlGetNextId);
			out.println(persons);
			int personId = 1;
			while(persons.next()){
				personId++;
			}
			out.println("NEW ID IS" + personId);

		
			try{
				insertPersons = conn.prepareStatement(sqlPersons);
				insertPersons.setInt(1, personId);
				insertPersons.setString(2, firstName);
				insertPersons.setString(3, lastName);
				insertPersons.setString(4, address);
				insertPersons.setString(5, email);
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
			
				response.setIntHeader("Sign Up Successfully!", 5);
				response.sendRedirect("/proj1/login.jsp");	
				
		}
		
		out.println("<form action=SignUp.jsp method=post>");
		out.println("UserName  : <input type=text name=USERID maxlength=20><br>");
		out.println("Password  : <input type=password name=PASSWD maxlength=20><br>");
		out.println("First Name: <input type=text name=FNAME maxlength=24><br>");
		out.println("Last  Name: <input type=text name=LNAME maxlength=24><br>");
		out.println("Identity(p(atient), r(adiologist), d(octor)): <input type=text name=CLASS maxlength=1><br>");
		out.println("Email     : <input type=text name=EMAIL maxlength=128><br>");
		out.println("Address   : <input type=text name=ADDRESS maxlength=128><br>");
		out.println("Phone     : <input type=text name=PHONE maxlenght=10><br>");
		out.println("<input type=submit name=bSignUp value=SignUp>");

     }else{

		out.println("<form action=SignUp.jsp method=post>");
		out.println("UserName  : <input type=text name=USERID maxlength=20><br>");
		out.println("Password  : <input type=password name=PASSWD maxlength=20><br>");
		out.println("First Name: <input type=text name=FNAME maxlength=24><br>");
		out.println("Last  Name: <input type=text name=LNAME maxlength=24><br>");
		out.println("Identity(p(atient), r(adiologist), d(octor)): <input type=text name=CLASS maxlength=1><br>");
		out.println("Email     : <input type=email name=EMAIL maxlength=128><br>");
		out.println("Address   : <input type=text name=ADDRESS maxlength=128><br>");
		out.println("Phone     : <input type=text name=PHONE maxlenght=10><br>");
		out.println("<input type=submit name=bSignUp value=SignUp>");
     
     }     
%>



</BODY>
</HTML>

