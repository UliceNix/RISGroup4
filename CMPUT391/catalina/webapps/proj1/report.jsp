<HTML>
<HEAD>


<TITLE>Report page</TITLE>
</HEAD>

<BODY>
<%!
	private Connection getConnection(){
		Connection conn = null;
	   	String driverName = "oracle.jdbc.driver.OracleDriver";
	   	String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	
	   	try {
	   	    Class drvClass = Class.forName(driverName); 
		    DriverManager.registerDriver((Driver) drvClass.newInstance());
	   	}catch(Exception ex){
	   	    return null;
	   	}
	   	
	   	try {
	   		conn = DriverManager.getConnection(dbstring,"mingxun",
		    	"hellxbox_4801");
		    conn.setAutoCommit(false);
		    return conn;
	    }catch(Exception ex){
		   	return null;
	   	}
}
%>
<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, 
	javax.swing.*, 
	java.util.*, 
	java.text.*" %>
<% 
    out.println("<form action=adminhomepage.jsp method = post>");
    out.println("<input type=submit name=Back value='Go Back'><br>");
    out.println("</form>");
    out.println("<b>Find out more help information by clicking "
    	+ "<a href='help.html#report' target='blank'>Help</a></b><br><br>"); 
    out.println("<hr>");
    out.println("<form action=report.jsp>");
    out.println("<input type=text name=ReportKeyWord align=right required> " 
	+ "Enter a specific diagnosis.<br>");
    out.println("<input type=text name=ReportStart align=right required> " 
	+ "From (eg.02-FEB-2012)");
    out.println("<input type=text name=ReportEnd align=right required> " 
	+ "To (eg.02-FEB-2012)<br>");
    out.println("<input type=submit name=Generate value='Go'><br>");
    out.println("<hr>");
    out.println("</form>");

    if(request.getParameter("Generate") != null){
    	
        Connection conn = getConnection();
        
        if(conn == null{
			JOptionPane.showMessageDialog(null, "Can't get a connection."
			+" Please try again.");
			response.sendRedirect("report.jsp");
		}
	
	   	Statement stmt = null;
	   	try{
	   		stmt = conn.createStatement();
	   	}catch(Exception ex){
	   		out.println("<hr>" + ex.getMessage() + "<hr>");
	   	}
	   	
	   	ResultSet rset = null;
	
	   	String diagnosis = (request.getParameter("ReportKeyWord")).trim();
	   	String from = (request.getParameter("ReportStart")).trim();
	   	String to = (request.getParameter("ReportEnd")).trim();
	
	   	SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
	   	sdformat.setLenient(false);
	
	   	try{
	   	    sdformat.parse(from);
	   	    sdformat.parse(to);
	   	}catch(Exception ex){
			try{    
				conn.close();
			}catch(Exception es){
				out.println("<hr>" + es.getMessage() + "<hr>");
			}
	   	    JOptionPane.showMessageDialog(null,"Please check the date format,"
	   			+"make sure it's in dd-MON-yyyy");
	   	    return;
	   	}
	   	
		String sql = "with PID as (select distinct(patient_id), "
			+ "persons.address, persons.phone, persons.FIRST_NAME,"
			+ " persons.last_name from radiology_record join persons on "
			+ "persons.person_id = radiology_record.patient_id " 
			+ "where upper(diagnosis) like upper('%" + diagnosis + "%') "
			+ "and " + "test_date >= '" 
	 		+ from +"' and test_date < '" + to + "') " 
			+ " select PID.patient_id,  PID.First_NAME, PID.last_Name," 
			+ "PID.address, PID.phone, MIN(radiology_record.test_date) as "
			+ "first_date from PID join radiology_record on PID.patient_id "
			+ "= radiology_record.patient_id group by PID.patient_id, "
			+ "PID.address, PID.phone, PID.First_NAME, PID.last_Name";
		
		try{
	    	rset = stmt.executeQuery(sql);
		}catch(Exception ex){
			try{    
				conn.close();
			}catch(Exception es){
				out.println("<hr>" + es.getMessage() + "<hr>");
			}
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
		
		
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
	            out.println("    <td >"+ fName.get(i)+ " " 
		        	+ lName.get(i)  + "</a></td>");
	    	    out.println("    <td >"+ phone.get(i) +"</a></td>");
	    	    out.println("    <td >"+ address.get(i) +"</a></td>");
	    	    out.println("    <td >"+ ddate.get(i).substring(0, 10) 
	    	    	+"</a></td>"); 
		    }
	    }
	    
		try{    
			conn.close();
		}catch(Exception ex){
			out.println("<hr>" + ex.getMessage() + "<hr>");
		}
    }

%>

</BODY>
</HTML>
