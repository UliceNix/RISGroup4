package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.portlet.ActionResponse.*;
import javax.swing.*;

public final class homepage_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<HTML>\n");
      out.write("<HEAD>\n");
      out.write("\n");
      out.write("\n");
      out.write("<TITLE>Homepage</TITLE>\n");
      out.write("</HEAD>\n");
      out.write("\n");
      out.write("<BODY>\n");
      out.write("\n");
      out.write("\n");
 
   out.println(session.getAttribute("PermissionLevel"));
   out.println("<p><b>Welcome to your homepage " + session.getAttribute("UserName") + "!</b></p>");
   out.println("<p><b>You could change your password and your personal information.</b></p>");
   out.println("<p><b>And you could also enter the search module to search for radiology records.</b></p>");
   out.println("<form action=homepage.jsp>");
   out.println("<input type=submit name=ChangePassword value='Change Password'><br>");
   out.println("</form>");
   out.println("<form action=homepage.jsp>");
   out.println("<input type=submit name=ChangeFirstName value='Change Firstname'><br>");
   out.println("</form>");
   out.println("<form action=homepage.jsp>");
   out.println("<input type=submit name=ChangeLastName value='Change Lastname'><br>");
   out.println("</form>");
   out.println("<form action=homepage.jsp>");
   out.println("<input type=submit name=ChangeAddress value='Change Address'><br>");
   out.println("</form>");
   out.println("<form action=homepage.jsp>");
   out.println("<input type=submit name=ChangePhoneNumber value='Change Phone Number'><br>");

   if(session.getAttribute("PermissionLevel").equals("r")){
   	out.println("</form>");
   	out.println("<form action=newrecord.jsp>");
   	out.println("<input type=submit name=NewRecord value='Create a New Radiology Record'><br>");
   	out.println("</form>");
   }
   out.println("</form>");
   out.println("<form action=search.jsp>");
   out.println("<input type=submit name=SearchEngine value='Enter Search Engine'><br>");
   out.println("</form>");

   out.println("</form>");
   out.println("<form action=homepage.jsp>");
   out.println("<input type=submit name=LogOut value='Log Out'><br>");
   out.println("</form>");
   
   if(request.getParameter("ChangePassword") != null 
   || request.getParameter("TryPassword") != null){
       out.println("<br>");
       out.println("<form action=homepage.jsp>");
       out.println("Old Password: <input type=password name=OLDPWD  maxlength=20><br>");
       out.println("New Password: <input type=password name=NEWPWD  maxlength=20><br>");
       out.println("<input type=submit name=SavePassword value=Save>");
       out.println("</form>");
   }	
   
   if(request.getParameter("SavePassword") != null){
   	String oldPassword = (request.getParameter("OLDPWD")).trim();
   	String newPassword = (request.getParameter("NEWPWD")).trim();
   
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
   
   
   	Statement stmt = null;
   	ResultSet rset = null;
   	String sql = "select PASSWORD from USERS where USER_NAME = '"+session.getAttribute("UserName")+"'";
	try{
   		stmt = conn.createStatement();
   		rset = stmt.executeQuery(sql);
   	}catch(Exception ex){
   		out.println("<hr>" + ex.getMessage() + "<hr>");
   	}
		  
   	String truepwd = "";
   	while(rset != null && rset.next())
   		truepwd = (rset.getString(1)).trim();

   	if(!oldPassword.equals(truepwd) || oldPassword == null || oldPassword.isEmpty()){
   		out.println("<br>");
   		out.println("<p>Your old password is incorrect.</p>");
   		out.println("<form action=homepage.jsp>");
   		out.println("<input type=submit name=TryPassword value=Try_Again>");
   		out.println("</form>");
   	}else if (!newPassword.matches("\\w.*")){
   		out.println("<br>");
   		out.println("<p>Your new password contains illegal characters.</p>");
   		out.println("<form action=homepage.jsp>");
   		out.println("<input type=submit name=TryPassword value=Try_Again>");
   		out.println("</form>");		    	  
   	}else if(oldPassword.equals(truepwd)){
  		 sql = "update USERS set password='"+newPassword
  	 +"' where user_name='"+session.getAttribute("UserName")+"'";
		 		 
		try{
  			stmt = conn.createStatement();
  			stmt.executeUpdate(sql);
			conn.commit();
			conn.close();
   		}catch(Exception ex){
  			 out.println("<hr>" + ex.getMessage() + "<hr>");
  		 }
   
  		JOptionPane.showMessageDialog(null, "Your password has been reset!");
		response.sendRedirect("/proj1/homepage.jsp");
     
	      }
	      
	   }

	if(request.getParameter("ChangeFirstName") != null 
		|| request.getParameter("TryFirstName") != null){
		out.println("<br>");
       	 	out.println("<form action=homepage.jsp>");
        	out.println("New Firstname: <input type=text name=NewFirstName  maxlength=24><br>");
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
   			conn = DriverManager.getConnection(dbstring,"mingxun","hellxbox_4801");
   			conn.setAutoCommit(false);
  	 	}catch(Exception ex){
   			out.println("<hr>" + ex.getMessage() + "<hr>");
   		}
   
   
   		Statement stmt = null;
   		ResultSet rset = null;
		String sql;
		String newFirstname = (request.getParameter("NewFirstName")).trim();	
		if(!newFirstname.matches("\\w+\\.?") 
			|| newFirstname == null || newFirstname.isEmpty()){
			out.println("<br>");
   			out.println("<p>Your new first name contains illegal characters.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryFirstName value=Try_Again>");
   			out.println("</form>");		
		}else{
			sql = "update PERSONS set FIRST_NAME='"+newFirstname
			+"' where PERSON_ID = (select PERSON_ID from USERS where" 
			+" user_name='"+session.getAttribute("UserName")+"')";
		 	out.println(sql); 
			try{
  				stmt = conn.createStatement();
  				stmt.executeUpdate(sql);
				conn.commit();
				conn.close();
   			}catch(Exception ex){
  			 	out.println("<hr>" + ex.getMessage() + "<hr>");
  		 	}
   
  			JOptionPane.showMessageDialog(null, "Your first name has been reset to " 
			+ newFirstname + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		}
	}

	if(request.getParameter("ChangeLastName") != null 
		|| request.getParameter("TryLastName") != null){
		out.println("<br>");
       	 	out.println("<form action=homepage.jsp>");
        	out.println("New Lastname: <input type=text name=NewLastName  maxlength=24><br>");
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
   			conn = DriverManager.getConnection(dbstring,"mingxun","hellxbox_4801");
   			conn.setAutoCommit(false);
  	 	}catch(Exception ex){
   			out.println("<hr>" + ex.getMessage() + "<hr>");
   		}
   
   
   		Statement stmt = null;
   		ResultSet rset = null;
		String sql;

		String newLastname = (request.getParameter("NewLastName")).trim();
	
		if(!newLastname.matches("\\w+\\.?") 
			|| newLastname == null || newLastname.isEmpty()){
			out.println("<br>");
   			out.println("<p>Your new last name contains illegal characters.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryLastName value=Try_Again>");
   			out.println("</form>");		
		}else{
			sql = "update PERSONS set LAST_NAME='"+newLastname
			+"' where PERSON_ID = (select PERSON_ID from USERS where" 
			+" user_name='"+session.getAttribute("UserName")+"')";
		 		 
			try{
  				stmt = conn.createStatement();
  				stmt.executeUpdate(sql);
				conn.commit();
				conn.close();
   			}catch(Exception ex){
  			 	out.println("<hr>" + ex.getMessage() + "<hr>");
  		 	}
   
  			JOptionPane.showMessageDialog(null, "Your last name has been reset to " 
			+ newLastname + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		}
	}

	if(request.getParameter("ChangeAddress") != null 
		|| request.getParameter("TryAddress") != null){
       		out.println("<br>");
       		out.println("<form action=homepage.jsp>");
       		out.println("New Address: <input type=text name=NEWADD  maxlength=128><br>");
       		out.println("<input type=submit name=SaveAddress value=Save>");
       		out.println("</form>");
	}

	if(request.getParameter("SaveAddress") != null){
		String newAddress = (request.getParameter("NEWADD")).trim();
		
		if(newAddress == null || newAddress.isEmpty()){
			out.println("<br>");
   			out.println("<p>Your new address is empty.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryAddress value=Try_Again>");
   			out.println("</form>");		
		}else{
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
   
   
   			PreparedStatement updateAddress = null;
			String sql = "update PERSONS set ADDRESS = ?" 
				+ " WHERE PERSON_ID=(SELECT PERSON_ID FROM USERS"
				+ " WHERE USER_NAME='"+session.getAttribute("UserName")+"')";
			updateAddress = conn.prepareStatement(sql);
			try{
				updateAddress.setString(1, newAddress);
				updateAddress.executeUpdate();
				conn.commit();
				conn.close();
			}catch(Exception ex){
  			 	out.println("<hr>" + ex.getMessage() + "<hr>");
  		 	}
			out.println(sql);
			JOptionPane.showMessageDialog(null, "Your address has been reset to " 
			+ newAddress + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		
		}
	}

	if(request.getParameter("ChangePhoneNumber") != null ||
		request.getParameter("TryPhoneNumber") != null){
       		out.println("<br>");
       		out.println("<form action=homepage.jsp>");
       		out.println("New Phone: <input type=text name=NEWPHONE  maxlength=10><br>");
       		out.println("<input type=submit name=SavePhone value=Save>");
       		out.println("</form>");		
	}
	
	if(request.getParameter("SavePhone") != null){
		String newPhone = (request.getParameter("NEWPHONE").trim());
		if(newPhone.length() != 10 || newPhone.isEmpty() 
			|| newPhone == null || !newPhone.matches("[0-9]+")){
			out.println("<br>");
   			out.println("<p>You phone number is not a valid phone number.</p>");
   			out.println("<form action=homepage.jsp>");
   			out.println("<input type=submit name=TryPhoneNumber value=Try_Again>");
   			out.println("</form>");	
		}else{
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
   
   			Statement stmt = null;
			String sql = "update PERSONS set PHONE='"+ newPhone + "'"
				+ " WHERE PERSON_ID=(SELECT PERSON_ID FROM USERS"
				+ " WHERE USER_NAME='"+session.getAttribute("UserName")+"')";
			
			try{
				stmt = conn.createStatement();
  				stmt.executeUpdate(sql);
				conn.commit();
				conn.close();
			}catch(Exception ex){
  			 	out.println("<hr>" + ex.getMessage() + "<hr>");
  		 	}
	
			out.println(sql);
			JOptionPane.showMessageDialog(null, "Your phone has been reset to " 
			+ newPhone + " !");
			response.sendRedirect("/proj1/homepage.jsp");	
		
		
		}
		
	}

	if(request.getParameter("LogOut") != null){
       		JOptionPane.showMessageDialog(null, "You have been logged out successfully!");
		response.sendRedirect("/proj1/login.jsp");		
	}

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</BODY>\n");
      out.write("</HTML>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
