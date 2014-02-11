package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.portlet.ActionResponse.*;
import javax.swing.*;
import java.util.*;
import java.text.*;

public final class report_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<TITLE>Report page</TITLE>\n");
      out.write("</HEAD>\n");
      out.write("\n");
      out.write("<BODY>\n");
      out.write("\n");
      out.write("\n");
 
    out.println("<form action=adminhomepage.jsp method = post>");
    out.println("<input type=submit name=Back value='Go Back'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=report.jsp>");
    out.println("<input type=text name=ReportKeyWord align=right required> " 
	+ "Enter a specific diagnosis.<br>");
    out.println("<input type=date name=ReportStart align=right required> " 
	+ "From (eg.02-FEB-2012)");
    out.println("<input type=date name=ReportEnd align=right required> " 
	+ "To (eg.02-FEB-2012)<br>");
    out.println("<input type=submit name=Generate value='Go'><br>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br>");
    out.println("</form>");

    if(request.getParameter("Generate") != null){
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

   	String diagnosis = (request.getParameter("ReportKeyWord")).trim();
   	String from = (request.getParameter("ReportStart")).trim();
   	String to   = (request.getParameter("ReportEnd")).trim();

   	SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
   	sdformat.setLenient(false);

   	try{
   	    sdformat.parse(from);
   	    sdformat.parse(to);
   	}catch(Exception ex){
   	    JOptionPane.showMessageDialog(null,"Please check the date format, make sure it's in dd-MMM-yyyy");
   	    return;
   	}
   	
        String sql = "with PID as (select distinct(patient_id), persons.address, persons.phone, persons.FIRST_NAME, persons.last_name " 
   + "from radiology_record join persons on persons.person_id = radiology_record.patient_id " 
   + "where upper(diagnosis) like upper('%" + diagnosis + "%') and " + "test_date >= '" 
   + from +"' and test_date < '" + to + "') " + " select PID.patient_id,  PID.First_NAME, PID.last_Name, PID.address, PID.phone, MIN(radiology_record.test_date) as first_date from PID join radiology_record on PID.patient_id = radiology_record.patient_id group by PID.patient_id, PID.address, PID.phone, PID.First_NAME, PID.last_Name";
        rset = stmt.executeQuery(sql);
 
 
   	
   	ArrayList<String> id = new ArrayList<String>();
   	ArrayList<String> fName = new ArrayList<String>();
   	ArrayList<String> lName = new ArrayList<String>();
   	ArrayList<String> phone = new ArrayList<String>();
   	ArrayList<String> address = new ArrayList<String>();
   	ArrayList<String> ddate = new ArrayList<String>();
   	
   	while(rset != null && rset.next()){
   	    id.add(rset.getString(1));
   	    fName.add(rset.getString(2));
            lName.add(rset.getString(3));
	    phone.add(rset.getString(4));
	    address.add(rset.getString(5));
	    ddate.add(rset.getString(6));
   	}

        if(id.size() == 0){
	    out.println("<p><b>No results!</b><p>");
	}else{
   	    out.println("<table BORDER=1>");
   	    out.println("<tr><td>Patient ID</a></td>");
   	    out.println("    <td >Patient Name</a></td>");
   	    out.println("    <td >Patient Phone</a></td>");
   	    out.println("    <td >Patient Address </a></td>");
   	    out.println("    <td >Patient First Diagnosis Date</a></td>");   
   	
   	    for(int i = 0; i < id.size(); i++){
	        out.println("<tr><td>"+ id.get(i) + "</a></td>");
                out.println("    <td >"+ fName.get(i)+ " " + lName.get(i)  + "</a></td>");
    	        out.println("    <td >"+ phone.get(i) +"</a></td>");
    	        out.println("    <td >"+ address.get(i) +"</a></td>");
    	        out.println("    <td >"+ ddate.get(i).substring(0, 10) +"</a></td>"); 
	    }
        }

     }


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
