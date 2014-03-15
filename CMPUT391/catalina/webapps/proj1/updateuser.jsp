<HTML>
<HEAD>


<TITLE>Update Information Page</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*,javax.swing.*,
org.apache.commons.lang.*" %>
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
	conn = DriverManager.getConnection(dbstring,"mingxun","hellxbox_4801");
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
    
    if(request.getParameter("bUpdate") != null){	        
     	userName = (request.getParameter("USERID")).trim();
     	passwd = (request.getParameter("PASSWD")).trim();
	firstName = (request.getParameter("FNAME")).trim();
     	lastName = (request.getParameter("LNAME")).trim();
	role  = request.getParameter("CLASS");
	email = (request.getParameter("EMAIL")).trim();
	address = StringEscapeUtils.escapeJava(
			(request.getParameter("ADDRESS")));
	phone = (request.getParameter("PHONE")).trim();
	
	String emailCheck = "select * from PERSONS where EMAIL = '"
	    + email.toLowerCase() + "'";
	
	if (passwd.isEmpty()){
	    sql = "SELECT PASSWORD FROM USERS WHERE PERSON_ID = '" 
		+ session.getAttribute("PersonId") +"'";
	    rset = stmt.executeQuery(sql);
	    if(rset != null && rset.next()){
		passwd = rset.getString("PASSWORD");
	    }
	}
	
	sql = "SELECT * FROM USERS WHERE PERSON_ID ='" 
		    + session.getAttribute("PersonId") +"'";

	if(!userName.matches("\\w.*")){
	    out.println("<p><b>The username can only contain a-z,"
		+" A-Z, 0-9.</b></p>");
	}else if((rset = stmt.executeQuery(sql)).next() &&
		    !(rset.getString("PERSON_ID")).equals(
			    session.getAttribute("PersonId"))){
	    out.println("<p><b>This username is taken.</b></p>");			
	}else if(passwd.length() < 6){
	    out.println("<p><b>Password's should be at least " 
	    + "6 characters.</b></p>");
	}else if(!passwd.matches("\\w.*")){
	    out.println("<p><b>The password can only contain a-z,"
	    + " A-Z, 0-9.</b></p>");
	}else if(!firstName.matches("[a-zA-Z]+\\.?") ){
	    out.println("<p><b>The first name can only contain "
	    + "alphabets.</b></p>");
	}else if(!lastName.toLowerCase().matches("[a-zA-Z]+\\.?")){
	    out.println("<p><b>The last name can only contain "
	    + "alphabets.</b></p>");
	}else if(role == null){
	    out.println("<p><b>Please pick a class. </b></p>");
	}else if(!email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)"
	    + "*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")){
	    out.println("<p><b>The email address contains illegal "
	    + "characters.<p><b>");
	}else if((rset = stmt.executeQuery(emailCheck)).next() &&
    	    !(rset.getString("PERSON_ID")).equals(
			    session.getAttribute("PersonId"))){
	    out.println("<p><b>The email has been registered with "
	    + "another user.<p><b>");
	}else if(address.isEmpty() || address == null 
	    || address.length() < 1){
	    out.println("<p><b>Please re-enter the address.<p><b>");
	}else if(phone.length() != 10 || phone.isEmpty() 
	    || phone == null || !phone.matches("[0-9]+")){
	    out.println("<p><b>Please make sure the phone number "
	    + "is valid.<p><b>");
	}else{
	
	    PreparedStatement updatePersons = null;
	    PreparedStatement updateUsers = null;
	    
	    String sqlPersons = "UPDATE PERSONS SET " 
		+ "FIRST_NAME = ?, LAST_NAME = ?, ADDRESS = ?, EMAIL = ?, "
		+ "PHONE = ? WHERE PERSON_ID='" 
		+ session.getAttribute("PersonId") + "'";
		
	    String sqlUsers = "UPDATE USERS SET "
		+ "USER_NAME = ?, PASSWORD = ?, CLASS = ? WHERE PERSON_ID='"
		+ session.getAttribute("PersonId") + "'";
	    
	
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
		out.println("<hr>" + ex.getMessage() + "<hr>");
	    }

	    try{
		updateUsers = conn.prepareStatement(sqlUsers);
		updateUsers.setString(1, userName);
		updateUsers.setString(2, passwd);
		updateUsers.setString(3, role);
		updateUsers.executeUpdate();
		conn.commit();

	    }catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	    }
		
	    try{
		conn.close();
	    }catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
	    }
	
	    response.sendRedirect("/proj1/adminhomepage.jsp");	
		    
	}
	out.println("<b>Find out more help information by clicking <a href='help.html#update' target='blank'>Help</a></b><br><br>");
	out.println("<form action=updateuser.jsp>");
	out.println("UserName  : <input type=text name=USERID value=" 
	    + userName + " maxlength=20 required ><br>");
	out.println("Password  : <input type=password name=PASSWD value" 
	    + passwd + " maxlength=20 required ><br>");
	out.println("First Name: <input type=text name=FNAME value='" 
	    + firstName + "' maxlength=24 required ><br>");
	out.println("Last  Name: <input type=text name=LNAME value='" 
	    + lastName + "' maxlength=24 required ><br>");
	out.println("<label for='patient'>Patient</label>");
	out.println("<input type=radio name=CLASS id=patient value=p required >");
	out.println("<label for='radiologist'>Radiologist</label>");
	out.println("<input type=radio name=CLASS id=radiologist value=r required >");
	out.println("<label for='doctor'>Doctor</label>");
	out.println("<input type=radio name=CLASS id=doctor value=d required ><br>");
	out.println("Email     : <input type=text name=EMAIL value='" 
	    + email + "' maxlength=128><br>");
	out.println("Address   : <input type=text name=ADDRESS value='"
	    + address +"' maxlength=128 required ><br>");
	out.println("Phone     : <input type=text name=PHONE value='" 
	    + phone + "' maxlenght=10 required ><br>");
	out.println("<input type=submit name=bUpdate value=Save>");
        out.println("</form>");	
        out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br>");
        out.println("</form>");	

     }else{
    
	
	sql = "select * from USERS where PERSON_ID = '" 
	    + session.getAttribute("PersonId") +"'";

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
	    + session.getAttribute("PersonId") +"'";
	
	try{
	    rset = stmt.executeQuery(sql);
	}catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	while(rset != null && rset.next()){
	    firstName = rset.getString("FIRST_NAME");
	    lastName = rset.getString("LAST_NAME");
	    address = rset.getString("ADDRESS");
	    email = rset.getString("EMAIL");
	    phone = rset.getString("PHONE");
	}

    out.println("<b>Find out more help information by clicking <a href='help.html#update' target='blank'>Help</a></b><br><br>");
	out.println("<form action=updateuser.jsp>");
	out.println("UserName  : <input type=text name=USERID value=" 
	    + userName + " maxlength=24 required><br>");
	out.println("Password  : <input type=password name=PASSWD value" 
	    + passwd + " maxlength=24 required><br>");
	out.println("First Name: <input type=text name=FNAME value='" 
	    + firstName + "' maxlength=24 required><br>");
	out.println("Last  Name: <input type=text name=LNAME value='" 
	    + lastName + "' maxlength=24 required><br>");
	out.println("<label for='patient'>Patient</label>");
	out.println("<input type=radio name=CLASS id=patient value=p required>");
	out.println("<label for='radiologist'>Radiologist</label>");
	out.println("<input type=radio name=CLASS id=radiologist value=r required>");
	out.println("<label for='doctor'>Doctor</label>");
	out.println("<input type=radio name=CLASS id=doctor value=d required><br>");
	out.println("Email     : <input type=text name=EMAIL value='" 
	    + email + "' maxlength=128 required><br>");
	out.println("Address   : <input type=text name=ADDRESS value=\""
	    + StringEscapeUtils.escapeHtml(address) +"\" maxlength=128 required ><br>");
	out.println("Phone     : <input type=text name=PHONE value=" 
	    + phone + " maxlenght=10 required ><br>");
	out.println("<input type=submit name=bUpdate value=Save>");
        out.println("</form>");	
        out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br>");
        out.println("</form>");		
     }     
%>



</BODY>
</HTML>

