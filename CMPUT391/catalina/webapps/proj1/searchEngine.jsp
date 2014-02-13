<HTML>
<HEAD>


<TITLE>Report page</TITLE>
</HEAD>

<BODY>


<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*, java.util.*, java.text.*" %>
<% 
    String role = session.getAttribute("PermissionLevel");
    String personId = session.getAttribute("Person_Id");
    ArrayList<String> rids = new ArrayList<String>();
    ArrayList<String> pids = new ArrayList<String>();
    ArrayList<String> dids = new ArrayList<String>();
    ArrayList<String> rdids = new ArrayList<String>();
    ArrayList<String> types = new ArrayList<String>();
    ArrayList<String> pdates = new ArrayList<String>();
    ArrayList<String> tdates = new ArrayList<String>();
    ArrayList<String> diags = new ArrayList<String>();
    ArrayList<String> description = new ArrayList<String>();
    
    out.println("<form action=searchEngine.jsp>");
    out.println("<input type=text name=KeyWord align=right required> " 
	+ "Enter keywords. If entering multiple keywords please use 'and' and 'or' as delimeters.<br>");
    out.println("<input type=date name=Start align=right required> " 
	+ "From (eg.02-FEB-2012)");
    out.println("<input type=date name=End align=right required> " 
	+ "To (eg.02-FEB-2012)<br>");
    out.println("<input type=submit name=Generate value='Go'><br>");
    out.println("------------------------------------------------------"
	+ "--------------------------------------------------------------"
	+ "----------------------------------<br>");
    out.println("</form>");
    
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
    
    if(request.getParameter("Generate") != null){
    }else{
	
	if(role.equals("p")){
	    String patientRecords = "select * from radiology_record where patient_id='" + personId + "'";
	    
	    rset = stmt.executeQuery(patientRecords)
	    
	    while(rset != null && rset.next()){
		rids.add(rset.getString(1));
		pids.add(rset.getString(2));
		dids.add(rset.getString(3));
		rdids.add(rset.getString(4));
		types.add(rset.getString(5));
		pdates.add(rset.getString(6));
		tdates.add(rset.getString(7));
		diags.add(rset.getString(8));
		description.add(rset.getString(9));		
	    }
	    
	    for(int i = 0; i < rids.size(); i++){
		String getPics = "select image_id from pacs_images where record_id='" + rids.get(i) + "'";
		rset = stmt.executeQuery(getPics);
		
	    
	    }
	    
	
	}
	
    
    
    }

%>

</BODY>
</HTML>
