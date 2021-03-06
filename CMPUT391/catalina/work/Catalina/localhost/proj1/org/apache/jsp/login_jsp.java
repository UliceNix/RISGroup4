package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.portlet.ActionResponse.*;
import javax.swing.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<HTML>\r\n");
      out.write("<HEAD>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<TITLE>Welcome to RIS</TITLE>\r\n");
      out.write("</HEAD>\r\n");
      out.write("\r\n");
      out.write("<BODY>\r\n");
      out.write("\r\n");
 
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

   			session.setAttribute("PermissionLevel", role);
   			sql = "select person_id from users where user_name = '" + userName + "'";
   	
   			try{
				stmt = conn.createStatement();
				rset = stmt.executeQuery(sql);			
			}catch(Exception ex){
				out.println("<hr>" + ex.getMessage() + "<hr>");			
			}
   			
   			int personId = 0;

   			while(rset.next()){
   				personId = rset.getInt("PERSON_ID");
   			}
   			session.setAttribute("Person_Id", personId);

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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</BODY>\r\n");
      out.write("</HTML>\r\n");
      out.write("\r\n");
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
