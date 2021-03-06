package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.portlet.ActionResponse.*;
import javax.swing.*;
import java.util.*;

public final class editfamdoc_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<TITLE>Edit Family Doctor Relationship</TITLE>\n");
      out.write("</HEAD>\n");
      out.write("\n");
      out.write("<BODY>\n");
      out.write("\n");
      out.write("\n");
 
    out.println("<form action=adminhomepage.jsp>");
    out.println("<input type=submit name=Back value='Go Back'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    out.println("<form action=editfamdoc.jsp>");
    out.println("Enter the doctor's person id: <input type=text "
	+ "name=Doctor required><br>");
    out.println("Enter the patient's person id:  <input type=text "
	+ "name=Patient required><br><br>");
    out.println("<input type=submit name=AddFamDoc value='Add Relationship'>");
    out.println("<input type=submit name=DropFamDoc value='Drop Relationship'><br>");
    out.println("</form>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br><br>");
    
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
    String sql = "SELECT FAMILY_DOCTOR.DOCTOR_ID, P1.FIRST_NAME, P1.LAST_NAME,FAMILY_DOCTOR.PATIENT_ID, P2.FIRST_NAME, P2.LAST_NAME FROM FAMILY_DOCTOR, PERSONS P1, PERSONS P2 WHERE FAMILY_DOCTOR.DOCTOR_ID = P1.PERSON_ID AND FAMILY_DOCTOR.PATIENT_ID = P2.PERSON_ID ORDER BY DOCTOR_ID";
    rset = stmt.executeQuery(sql);
    ArrayList<String> docId = new ArrayList<String>();
    ArrayList<String> docFName = new ArrayList<String>();
    ArrayList<String> docLName = new ArrayList<String>();
    ArrayList<String> patId = new ArrayList<String>();
    ArrayList<String> patFName = new ArrayList<String>();
    ArrayList<String> patLName = new ArrayList<String>();
    while(rset != null && rset.next()){
        docId.add(rset.getString("DOCTOR_ID"));
	docFName.add(rset.getString("FIRST_NAME"));
	docLName.add(rset.getString("LAST_NAME"));
	patId.add(rset.getString(4));
	patFName.add(rset.getString(5));
	patLName.add(rset.getString(6));
    }

    out.println("<table BORDER=1>");
    out.println("<tr><td>Doctor ID</a></td>");
    out.println("    <td >Doctor Firstname</a></td>");
    out.println("    <td >Doctor Lastname</a></td>");
    out.println("    <td >Patient ID</a></td>");
    out.println("    <td >Patient Firstname</a></td>");
    out.println("    <td >Patient Lastname</a></td>"); 
    for(int i = 0; i < docId.size(); i++){
        out.println("<tr><td>"+ docId.get(i) + "</a></td>");
   	out.println("    <td >"+ docFName.get(i) + "</a></td>");
    	out.println("    <td >"+ docLName.get(i) +"</a></td>");
    	out.println("    <td >"+ patId.get(i) +"</a></td>");
    	out.println("    <td >"+ patFName.get(i) +"</a></td>");
    	out.println("    <td >"+ patLName.get(i) +"</a></td>"); 
    }
    if(request.getParameter("Go back") != null){
        response.sendRedirect("/proj1/adminhomepage.jsp");
    }
    if(request.getParameter("AddFamDoc") != null 
    	|| request.getParameter("DropFamDoc") != null ){

	String docID = (request.getParameter("Doctor")).trim();
    	String patID = (request.getParameter("Patient")).trim();
	String docSql = "select * from users where person_id = '" + docID + "' and users.CLASS = 'd'";
    	String patSql = "select * from users where person_id = '" + patID + "' and users.CLASS = 'p'";

	if(docID.isEmpty() || !docID.matches("[0-9]+")){

	    out.println("<p><b> Incorrect Doctor ID Format.</b></p>");	      

	}else if(patID.isEmpty() || !patID.matches("[0-9]+")){

	    out.println("<p><b> Incorrect Patient ID Format.</b></p>");	 

	}else if(!(rset = stmt.executeQuery(docSql)).next()){

	    out.println("<p><b> Invalid Doctor ID.</b></p>");

	}else if(!(rset = stmt.executeQuery(patSql)).next()){

	    out.println("<p><b> Invalid Patient ID.</b></p>");

	}else{
	    String checkSQL =  "select * from family_doctor where doctor_id = '" + docID + "' and patient_id = '" + patID + "'";
	    if(request.getParameter("AddFamDoc") != null && !(rset = stmt.executeQuery(checkSQL)).next()){
	        
	        String insertSQL = "insert into family_doctor values ('" + 
		docID + "', '" + patID + "')";

		try{
		    stmt.executeUpdate(insertSQL);
		    conn.commit();
		}catch(Exception ex){
		    out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		JOptionPane.showMessageDialog(null, "The new family doctor relationship has been added to database!");
		response.sendRedirect("/proj1/adminhomepage.jsp");		
	    }else if (request.getParameter("AddFamDoc") != null && (rset = stmt.executeQuery(checkSQL)).next()){
	        JOptionPane.showMessageDialog(null, "The family doctor relationship already exists. Please try again.");
	    	response.sendRedirect("/proj1/editfamdoc.jsp");	    
	    }else{
	        String deleteSQL = "delete from family_doctor where doctor_id = '" + docID + "' and patient_id = '" + patID + "'";
	    	rset = stmt.executeQuery(checkSQL);
	    	if(!rset.next()){
			JOptionPane.showMessageDialog(null, "The family doctor relationship doesn't exist. Please try again.");
			 response.sendRedirect("/proj1/editfamdoc.jsp");	
   		}else{
		    try{
		        stmt.executeUpdate(deleteSQL);
		        conn.commit();
		    }catch(Exception ex){
		        out.println("<hr>" + ex.getMessage() + "<hr>");
		    }
		
		    JOptionPane.showMessageDialog(null, "The new family doctor relationship has been removed from database!");
		    response.sendRedirect("/proj1/adminhomepage.jsp");	    
	    	    }
	    }
	}

	try{
	    conn.close();
	}catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	}
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
