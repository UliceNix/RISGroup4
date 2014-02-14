<html>
<head> 
<title>Create a New Radiology Record(Step 1 of 2)</title> 
</head>
<body> 

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*, java.util.*, java.lang.*, java.io.*, java.text.*, java.net.*, org.apache.commons.fileupload.*,org.apache.commons.io.*, java.awt.Image.*, java.util.List, javax.imageio.*, java.awt.image.*, oracle.sql.*, oracle.jdbc.*" %>
<% 
    
    
    out.println("<form action=homepage.jsp>");
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
    String sql = "";

    sql = "SELECT COUNT(*) AS NEXT_RID FROM RADIOLOGY_RECORD";
    rset = stmt.executeQuery(sql);
    int rid = 0;
    while(rset != null && rset.next()){
        rid = rset.getInt("NEXT_RID") + 1;
    }   
   
    Integer id = (Integer) session.getAttribute("Person_Id");
    out.println("User Id is: " + id);
   
    String pid = "";
    String did = "";
    String type = "";
    String pDate = "";
    String tDate = "";
    String diag = "";
    String description = "";

    if(request.getParameter("SaveRecord") != null){
   
        pid = request.getParameter("pid");
        did = request.getParameter("did");
        type = request.getParameter("type");
        pDate = request.getParameter("pdate");
        tDate = request.getParameter("tdate");
        diag = request.getParameter("diagnosis");
        description = request.getParameter("description");
      
      
        String validPid = "select count(*) from users where person_id = '" + 
	 pid + "' and class = 'p'";
        String validDid = "select count(*) from users where person_id = '" 
	 + did + "' and class = 'd'";
	 
        if (!pid.isEmpty()){
      
	    try{
	        int patient_id = Integer.parseInt(pid);	
	    }catch (Exception ex){
	        JOptionPane.showMessageDialog(null,"The patient id should be an "
	       +"integer");
                response.sendRedirect("newrecord.jsp");
	    
	    }
	    rset = stmt.executeQuery(validPid);
	 
	    int count = 0;
	    while(rset != null && rset.next()){
	        count = rset.getInt(1);
	    }
	    if(count < 1){
	        JOptionPane.showMessageDialog(null, "The patient id is invalid.");
	        response.sendRedirect("newrecord.jsp");
	    }
        }else{
	    pid = null;      
      } 
      
      if (!did.isEmpty()){
      
      	 try{
	    int doctor_id = Integer.parseInt(did);	
	 }catch (Exception ex){
	    JOptionPane.showMessageDialog(null,"The doctor id should be an "
	       + "integer");
            response.sendRedirect("newrecord.jsp");
	    
	 }
	 
	 rset = stmt.executeQuery(validDid);
	 
	 int count = 0;
	 while(rset != null && rset.next()){
	    count = rset.getInt(1);
	 }
	 if(count < 1){
	    JOptionPane.showMessageDialog(null, "The doctor id is invalid.");
            response.sendRedirect("newrecord.jsp");

	 }
      
      } else {
	 did = null;
	 
      }
      
      if (!pDate.isEmpty()){
      
	 SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
	 sdformat.setLenient(false);

	 try{
	    sdformat.parse(pDate);
	 }catch(Exception ex){
	    JOptionPane.showMessageDialog(null,"Please check the date format,"
	    +" make sure it's in dd-MMM-yyyy");
            response.sendRedirect("newrecord.jsp");

	 }
	 
      } else {
	 pDate = null;      
      }
      
      if (!tDate.isEmpty()){
      
	 SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
	 sdformat.setLenient(false);

	 try{
	    sdformat.parse(pDate);
	 }catch(Exception ex){
	    JOptionPane.showMessageDialog(null,"Please check the date format,"
	    + " make sure it's in dd-MMM-yyyy");	 
            response.sendRedirect("newrecord.jsp");
      }
      
      }else{
	 tDate = null;      
      }
      
      PreparedStatement insertRecord = null;
      String insertSql = "insert into radiology_record" 
	    + " (record_id, patient_id, doctor_id, radiologist_id, test_type, "
	    + "prescribing_date, test_date, diagnosis, description) values "
	    + " (?, ?, ?, ?, ?, ?, ?, ?, ?)";
      insertRecord = conn.prepareStatement(insertSql);
      insertRecord.setInt(1, rid);
      insertRecord.setString(2, pid);
      insertRecord.setString(3, did);
      insertRecord.setInt(4, id);
      insertRecord.setString(5, type);
      insertRecord.setString(6, pDate);
      insertRecord.setString(7, tDate);
      insertRecord.setString(8, diag);
      insertRecord.setString(9, description);
      try{
	 insertRecord.executeUpdate();
	 conn.commit();
	 session.setAttribute("Saved_Record_Id", rid);
	 response.sendRedirect("/proj1/newrecord.jsp");
      }catch(Exception ex){
	 out.println("<hr>" + ex.getMessage() + "<hr>");      
      }
   
   }else if (session.getAttribute("Saved_Record_Id") != null){
      out.println("<p>");
      out.println("<hr>");
      out.println("You are uploading for record " + session.getAttribute("Saved_Record_Id") + ".");
      out.println("Please input or select the path of the image!");
      out.println("<form name='upload-image' method=POST enctype='multipart/form-data' action='UploadImage'>");
      out.println("<table>");
      out.println("<tr>");
      out.println("<th>File path: </th>");
      out.println("<td><input accept='image/jpeg,image/gif,image/png, image/bmp, image/jpg' name='file-path' type='file' size='30' required multiple/></input></td> ");
      out.println("</tr>");
      out.println("<tr>");
      out.println("<td ALIGN=CENTER COLSPAN='2'><input type='submit' name='.submit' value='Upload'></td>");
      out.println("</tr>");
      out.println("</table>");
      out.println("</form>") ;  
   
   
   }else{         
      out.println("<p><b>Current Record ID: " + rid + ". </b></p>");
      out.println("<p> As a radiologsit, you could create a new radiology "
	 + "record by entering the information first and add pacs.</p>");
      out.println("<form action=newrecord.jsp method=post>");
      out.println("Please Enter Patient Id Here:<br> <input type=text name=pid"
	 + " value='" + pid + "' ><br>");
      out.println("Please Enter Doctor Id Here:<br><input type=text name=did" 
	 + " value='" + did + "'><br>");
      out.println("Please Enter Test Type Here:<br> <input type=text name=type maxlenght=24 value=\"" + type + "\"><br>");
      out.println("Please Enter Prescribing Date Here:<br><input type=date "
	 + "name=pdate value=\"" + pDate + "\"><br>");
      out.println(" Please Enter Test Date Here:<br> <input type=date "
	 + "name=tdate value=\"" + tDate + "\"><br>");
      out.println("Please Enter Diagnosis Here:<br> <input type=text " 
	 + "name=diagnosis value=\"" + diag + "\"maxlength=128><br>");
      out.println(" Please Enter Description Here:<br><input type=text "
	 + "name=description value=\"" + description + "\"maxlength=1024><br><br>");
      out.println("<input type=submit name=SaveRecord value='Save New Record'>"
	 + "<br>");
      out.println("</form>");
      out.println("------------------------------------------------------"
      + "--------------------------------------------------------------"
      + "----------------------------------<br><br>");
   }
   
 
      
   
%>



</body> 
</html>
