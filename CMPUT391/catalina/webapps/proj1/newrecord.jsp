<html>
<head> 
<title>Create a New Radiology Record(Step 1 of 2)</title> 
</head>
<body> 

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*, java.util.*, java.lang.*, java.io.*" %>
<% 


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
   out.println("<form action=newrecord.jsp>");
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

   if(request.getParameter(SaveRecord) != null){
    			String pid = request.getParameter("pid");
    		String did = request.getParameter("did");
    		String type = request.getParameter("type");
    		String pDate = request.getParameter("pdate");
    		String tDate = request.getParameter("tdate");
    		String 
    	   
    	}
%>







</body> 
</html>
