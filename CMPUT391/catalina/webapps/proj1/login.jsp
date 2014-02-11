<HTML>
<HEAD>


<TITLE>Welcome to RIS</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,javax.portlet.ActionResponse.*,javax.swing.*" %>
<% 
        if(request.getParameter("bLogin") != null)
        {

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
		        conn = DriverManager.getConnection(dbstring,"mingxun","hellxbox_4801");
        		conn.setAutoCommit(false);
	        }
        	catch(Exception ex){
	        
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select PASSWORD from USERS where USER_NAME = '"+userName+"'";
	        out.println(sql);
        	try{
	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);
        	}
	
	        catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
        	}

	        String truepwd = "";
	
        	while(rset != null && rset.next())
	        	truepwd = (rset.getString(1)).trim();
	
                out.println("Password:" + truepwd);
        	//display the result
                
	        if(passwd.equals(truepwd) && passwd != null && !passwd.isEmpty()){
		        session.setAttribute("UserName", userName);
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
			out.println(role);

                        out.println("<p><b>Your Login is Successful!</b></p>");
                        session.setAttribute("PermissionLevel", role);
			if(role.equals("a")){			
                        	response.sendRedirect("/proj1/adminhomepage.jsp");
			}else{
				response.sendRedirect("/proj1/homepage.jsp");
			}
                }
        	else{
			JOptionPane.showMessageDialog(null, "Either your username or your password is invalid, please try again!");
	        	response.sendRedirect("/proj1/login.jsp");
                }

                try{
                        conn.close();
                }
                catch(Exception ex){
                        out.println("<hr>" + ex.getMessage() + "<hr>");
                }
        }
        else
        {
                out.println("<form action=login.jsp>");
                out.println("UserName: <input type=text name=USERID maxlength=20><br>");
                out.println("Password: <input type=password name=PASSWD maxlength=20><br>");
                out.println("<input type=submit name=bLogin value=LogIn>");
                out.println("</form>");
        }      
%>



</BODY>
</HTML>

