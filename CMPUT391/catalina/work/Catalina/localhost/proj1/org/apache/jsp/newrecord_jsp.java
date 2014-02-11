package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.portlet.ActionResponse.*;
import javax.swing.*;
import java.util.*;
import java.lang.*;
import java.io.*;

public final class newrecord_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<html>\n");
      out.write("<head> \n");
      out.write("<title>Create a New Radiology Record(Step 1 of 2)</title> \n");
      out.write("</head>\n");
      out.write("<body> \n");
      out.write("\n");
      out.write("\n");
 
/*
   Process p = Runtime.getRuntime().exec("uname -n");
   
   InputStream is = p.getInputStream();
   
   BufferedReader reader = new BufferedReader(new InputStreamReader(is));

   String line = null;
   while((line = reader.readLine()) != null){
   	out.println(line);
   }*/

   out.println("<form action=adminhomepage.jsp>");
   out.println("<input type=submit name=Back value='Go Back'><br>");
   out.println("</form>");
   out.println("------------------------------------------------------"
   + "--------------------------------------------------------------"
   + "----------------------------------<br>");

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

   String sql = "SELECT COUNT(*) AS NEXT_RID FROM RADIOLOGY_RECORD";
   rset = stmt.executeQuery(sql);
   int rid = 0;
   while(rset != null && rset.next()){
   	rid = rset.getInt("NEXT_RID") + 1;
   }
   out.println("<p><b>Current Record ID: " + rid + ". </b></p>");
   Integer id = (Integer) session.getAttribute("Person_Id");
   out.println("<p> As a radiologsit, you could create a new radiology record by entering the information first and add pacs.</p>");
   out.println("<form action=addpacs.jsp>");
   out.println("Please Enter Patient Id Here:<br> <input type=text name=pid> <br>");
   out.println("Please Enter Doctor Id Here:<br><input type=text name=did> <br>");
   out.println("Please Enter Test Type Here:<br> <input type=text name=type maxlenght=24><br>");
   out.println("Please Enter Prescribing Date Here:<br><input type=date name=pdate><br>");
   out.println(" Please Enter Test Date Here:<br> <input type=date name=tdate><br>");
   out.println("Please Enter Diagnosis Here:<br> <input type=text name=diagnosis maxlength=128><br>");
   out.println(" Please Enter Discription Here:<br><input type=text name=description maxlength=1024><br><br>");
   out.println("<input type=submit name=SaveRecord value='Save New Record'><br>");
   out.println("</form>");
   out.println("------------------------------------------------------"
   + "--------------------------------------------------------------"
   + "----------------------------------<br><br>");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</body> \n");
      out.write("</html>\n");
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
