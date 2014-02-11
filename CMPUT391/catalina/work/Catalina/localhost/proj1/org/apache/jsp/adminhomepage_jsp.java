package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.portlet.ActionResponse.*;
import javax.swing.*;

public final class adminhomepage_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<TITLE>Admin Homepage</TITLE>\n");
      out.write("</HEAD>\n");
      out.write("\n");
      out.write("<BODY>\n");
      out.write("\n");
      out.write("\n");
 
    out.println("<p><b>Welcome to Administrator's Homepage," 
	+ session.getAttribute("UserName") + "!</b></p>");
    out.println("<p><b>Manage the user's information (update an " 
	+ "exisiting user or register a new user).</b></p>");
    out.println("<p><b>Search for radiologist records.</b></p>");
    out.println("<p><b>Generate the report of all patients..</b></p>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=NewUser value='Register a New "
	+ "User'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<p>Enter the user's person_id</p><input type=text "
	+ "name=PersonId required><br>");
    out.println("<input type=submit name=UpdateUser value='Update a"
	+ " User'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=editfamdoc.jsp>");
    out.println("<input type=submit name=EditFamDoc value='Update Family"
	+ " Doctor Information'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=Search value='Use Search Engine'>");
    out.println("</form>");
    out.println("<form action=report.jsp>");
    out.println("<input type=submit name=Report value='Generate a Report'>");
    out.println("</form>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=DataAnalysis value='OLAP Report Generator'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=LogOut value='Log Out'><br>");
    out.println("</form>");

    if (request.getParameter("NewUser") != null){
        response.sendRedirect("/proj1/SignUp.jsp");
    }

    if (request.getParameter("UpdateUser") != null){
        String personId = (request.getParameter("PersonId")).trim();
        Connection conn = null;
	    
	String driverName = "oracle.jdbc.driver.OracleDriver";
	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
 
	try {
	    Class drvClass = Class.forName(driverName); 
	    DriverManager.registerDriver((Driver) drvClass.newInstance());
	}catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
     	try {
	    conn = DriverManager.getConnection(dbstring,"mingxun",
	    "hellxbox_4801");
	    conn.setAutoCommit(false);
	}catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
     	}

     	Statement stmt = conn.createStatement();
     	ResultSet rset = null;
     	String sql = "select * from PERSONS where PERSON_ID = '"+personId+"'";
	
        if (personId.isEmpty() || personId == null 
	    || !personId.matches("[0-9]+")){
            out.println("<p><b>Invalid Person Id.</b></p>");
        }else if (!(rset = stmt.executeQuery(sql)).next()){
	    out.println("<p><b>This person does not exist..</b></p>");	    
	}else{
	    session.setAttribute("PersonId", personId);
	    response.sendRedirect("/proj1/updateuser.jsp");
	}
    }
    
    if (request.getParameter("LogOut") != null){
       		JOptionPane.showMessageDialog(null, "You have been logged"
		    + " out successfully!");
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
