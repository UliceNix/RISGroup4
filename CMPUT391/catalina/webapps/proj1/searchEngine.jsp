<HTML>
<HEAD>


<TITLE>Report page</TITLE>
</HEAD>

<BODY>


<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*, java.util.*, java.text.*" %>
<% 
    String role = (String) session.getAttribute("PermissionLevel");
    Integer personId = (Integer) session.getAttribute("Person_Id");
    String selectcols = "select record_id,patient_id, doctor_id, radiologist_id, test_type, prescribing_date,test_date, diagnosis, description, concat(concat(first_name, ' '), last_name) AS patient_name, p.address, p.email, p.phone";

    ArrayList<String> names = new ArrayList<String>();
    ArrayList<String> adds = new ArrayList<String>();
    ArrayList<String> emails = new ArrayList<String>();
    ArrayList<String> phones = new ArrayList<String>();
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
    out.println("<input type=submit name=Back value='Go Back'><br><br>");
    out.println("</form>");


    out.println("<form action=searchEngine.jsp>");
    out.println("<input type=text name=KeyWord align=right required> " 
		+ "Enter keywords. If entering multiple keywords please use 'and' or 'or' as delimeters.<br>");
    out.println("<input type=date name=Start align=right required> " 
		+ "From (eg.02-FEB-2012)");
    out.println("<input type=date name=End align=right required> " 
		+ "To (eg.02-FEB-2012)<br>");
    out.println("<p> Please Select The Order of Your Search Result.(If leaving it blank, the result will be sorted by default order.)</p>");
    out.println("<label for=NewToOld> Most Recent First</label>");
    out.println("<input type=radio name=Order id=NewToOld value=new>");
    out.println("<label for=OldToNew> Least Recent First</label>");
    out.println("<input type=radio name=Order id=OldToNew value=old><br>");
    out.println("<input type=submit name=Generate value='Go'><br>");
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
		conn = DriverManager.getConnection(dbstring,"mingxun", "hellxbox_4801");
		conn.setAutoCommit(false);
    }catch(Exception ex){
		out.println("<hr>" + ex.getMessage() + "<hr>");
    }

    Statement stmt = conn.createStatement();
    ResultSet rset = null;
    
    if(request.getParameter("Back") != null){

		if(role.equals("a")){
		    response.sendRedirect("adminhomepage.jsp");	
		}else{
			response.sendRedirect("homepage.jsp");	
		}

    }else if(request.getParameter("Generate") != null){

        String from = (request.getParameter("Start")).trim();
        String to = (request.getParameter("End")).trim();
        
        SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
	   	sdformat.setLenient(false);

	   	try{
	   	    sdformat.parse(from);
	   	    sdformat.parse(to);
	   	}catch(Exception ex){
	   	    JOptionPane.showMessageDialog(null, "Please check the date format, make sure it's in dd-MMM-yyyy");
	   	    response.sendRedirect("searchEngine.jsp");
	   	}
        
        String keyword = (request.getParameter("KeyWord")).trim().toLowerCase();
        
		int andCheck = keyword.indexOf(" and ");
        int orCheck = keyword.indexOf(" or ");

        if(andCheck >= 0 && orCheck >= 0) {

            JOptionPane.showMessageDialog(null, "Please make sure you only use 'and' or 'or' in your search key words");
            response.sendRedirect("searchEngine.jsp");

        }
        
        String[] keywords;

        if(andCheck >= 0){

            keywords = keyword.split(" and ");

        }else{

            keywords = keyword.split(" or ");

        }

        String order = request.getParameter("Order");
        String sqlOrder = "";

        if(order != null && order.equals("new")){

            sqlOrder = " Order by TEST_DATE DESC";        

        }else if (order != null && order.equals("old")){

            sqlOrder = " Order by TEST_DATE ASC";
        }
        
        String select = "";

	 	if(role.equals("p")){

		    select  = selectcols + "from (radiology_record r join persons p on r.patient_id=p.person_id) where patient_id='" + personId + "' and (";

		}else if (role.equals("r")){

		    select = selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id) where radiologist_id='" + personId + "' and (";

		}else if (role.equals("d")){

			select = selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id) where doctor_id='" + personId + "' and (";	

		}else{

		    select = selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id)";

		}
        

        select += "(upper(description) like '%" + keywords[0].trim().toUpperCase() + "%' or upper(diagnosis) like '%" + keywords[0].trim().toUpperCase() + "%' or upper(concat(concat(first_name, ' '), last_name)) like '%" + keywords[0].trim().toUpperCase() + "%' ) ";

        if(andCheck >= 0){

            for(int i = 1; i < keywords.length; i++){

                select += "and (upper(description) like '%" + keywords[i].trim().toUpperCase() + "%' or upper(diagnosis) like '%" + keywords[i].trim().toUpperCase() + "%' or upper(concat(concat(first_name, ' '), last_name)) like '%" + keywords[i].trim().toUpperCase() + "%' ) ";

            }

        }else if (orCheck >= 0){

            for(int i = 1; i < keywords.length; i++){

                select += "or (upper(description) like '%" + keywords[i].trim().toUpperCase() + "%' or upper(diagnosis) like '%" + keywords[i].trim().toUpperCase() + "%' or upper(concat(concat(first_name, ' '), last_name)) like '%" + keywords[i].trim().toUpperCase() + "%' ) ";
            }
        }
        
		select += ")";

        select += " and test_date >='" + from + "' and test_date<'" + to + "'"; 

        if(!sqlOrder.isEmpty() && sqlOrder != null){

            select+=sqlOrder;

        }

		rset = stmt.executeQuery(select);

		out.println("<table BORDER=1>");
		out.println("<tr><td>Record ID</a></td>");
		out.println("    <td >Patient ID</a></td>");
		out.println("    <td >Doctor ID</a></td>");
   		out.println("    <td >Radiologist ID </a></td>");
		out.println("    <td >Test Type</a></td>"); 
		out.println("    <td >Prescribing Date</a></td>"); 
		out.println("    <td >Test Date </a></td>"); 
		out.println("    <td >Diagnosis </a></td>"); 
		out.println("    <td >description</a></td>"); 
/*
		out.println("    <td >patient name</a></td>"); 
		out.println("    <td >patient email</a></td>"); 
		out.println("    <td >patient address</a></td>");
		out.println("    <td >patient phone number</a></td>"); 
*/ 
		out.println("    <td >Medical Images</a></td>"); 

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
			//names.add(rset.getString(10));
			//adds.add(rset.getString(11));
			//emails.add(rset.getString(12));
			//phones.add(rset.getString(13));
					
		}
	
		for(int i = 0; i < rids.size(); i++){
			String pdate = (pdates.get(i).isEmpty()) ? pdates.get(i) : pdates.get(i).substring(0, 10);
			String tdate = (tdates.get(i).isEmpty()) ? tdates.get(i) : tdates.get(i).substring(0, 10);

		    out.println("<tr><td>"+ rids.get(i) + "</a></td>");
		    out.println("    <td>"+ pids.get(i)+ "</a></td>");
		    out.println("    <td>"+ dids.get(i) +"</a></td>");
		    out.println("    <td>"+ rdids.get(i) +"</a></td>");
		    out.println("    <td>"+ types.get(i) +"</a></td>");
		    out.println("    <td>"+ pdate +"</a></td>"); 
		    out.println("    <td>"+ tdate +"</a></td>"); 
		    out.println("    <td>"+ diags.get(i) +"</a></td>");
		    out.println("    <td>"+ description.get(i) +"</a></td>");
			out.println("    <td>"+ names.get(i) +"</a></td>");
			out.println("    <td>"+ emails.get(i) +"</a></td>");
			out.println("    <td>"+ adds.get(i) +"</a></td>");
			out.println("    <td>"+ phones.get(i) +"</a></td>");
			    
		    String getPics = "select image_id from pacs_images where record_id='" + rids.get(i) + "'";
		    rset = stmt.executeQuery(getPics);
		    out.println("<td>");
		    
			while(rset.next()){

				String pic_id = rset.getString(1);
				out.println("<a href=\"GetOnePic?bigrid" + rids.get(i) + "pic" + pic_id + "\">");
				out.println("<img src=\"GetOnePic?rid" + rids.get(i) + "pic" + pic_id +
				"\"></a>");
	
		    }
	
		    out.println("</a></td>");
			
		}
	        out.println("</table>");   
	     
	}else{
		out.println("<table BORDER=1>");
		out.println("<tr><td>Record ID</a></td>");
		out.println("    <td >Patient ID</a></td>");
		out.println("    <td >Doctor ID</a></td>");
	   	out.println("    <td >Radiologist ID </a></td>");
		out.println("    <td >Test Type</a></td>"); 
		out.println("    <td >Prescribing Date</a></td>"); 
		out.println("    <td >Test Date </a></td>"); 
		out.println("    <td >Diagnosis </a></td>"); 
		out.println("    <td >description</a></td>"); 
/*
		out.println("    <td >patient name</a></td>"); 
		out.println("    <td >patient email</a></td>"); 
		out.println("    <td >patient address</a></td>");
		out.println("    <td >patient phone number</a></td>"); */ 
		out.println("    <td >Medical Images</a></td>"); 
		
		if(role.equals("p")){
		    String patientRecords = selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id) where patient_id='" + 	personId + "'";
	    
		    rset = stmt.executeQuery(patientRecords);
		}else if (role.equals("r")){
		    String radiologistRecords = selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id) where radiologist_id='" + personId + "'";
		    rset = stmt.executeQuery(radiologistRecords);   
		}else if (role.equals("d")){
			String doctorRecords = selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id) where doctor_id='" + personId + "'";
			rset = stmt.executeQuery(doctorRecords);

		}else{

		    rset = stmt.executeQuery(selectcols + " from (radiology_record r join persons p on r.patient_id=p.person_id)");	
		}
	    
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
/*	
			names.add(rset.getString(10));
			adds.add(rset.getString(11));
			emails.add(rset.getString(12));
			phones.add(rset.getString(13));*/
				
		}
	
		for(int i = 0; i < rids.size(); i++){
	
			String pdate = (pdates.get(i).isEmpty()) ? pdates.get(i) : pdates.get(i).substring(0, 10);
			String tdate = (tdates.get(i).isEmpty()) ? tdates.get(i) : tdates.get(i).substring(0, 10);

	    	out.println("<tr><td>"+ rids.get(i) + "</a></td>");
	    	out.println("    <td>"+ pids.get(i)+ "</a></td>");
	    	out.println("    <td>"+ dids.get(i) +"</a></td>");
	    	out.println("    <td>"+ rdids.get(i) +"</a></td>");
	    	out.println("    <td>"+ types.get(i) +"</a></td>");
	    	out.println("    <td>"+ pdate +"</a></td>"); 
	    	out.println("    <td>"+ tdate +"</a></td>"); 
	    	out.println("    <td>"+ diags.get(i) +"</a></td>");
	    	out.println("    <td>"+ description.get(i) +"</a></td>");
		/*	out.println("    <td>"+ names.get(i) +"</a></td>");
			out.println("    <td>"+ emails.get(i) +"</a></td>");
			out.println("    <td>"+ adds.get(i) +"</a></td>");
			out.println("    <td>"+ phones.get(i) +"</a></td>");
	    	*/
	    	String getPics = "select image_id from pacs_images where record_id='" + rids.get(i) + "'";
	    	rset = stmt.executeQuery(getPics);
	    	out.println("<td>");
	    	while(rset.next()){
				String pic_id = rset.getString(1);
				out.println("<a href=\"GetOnePic?bigrid" + rids.get(i) + "pic" + pic_id + "\">");
				out.println("<img src=\"GetOnePic?rid" + rids.get(i) + "pic" + pic_id +
				"\"></a>");
				
	    	}
			out.println("</a></td>");
	   	
			
		}
        out.println("</table>");
		    
	
   }
	
%>

</BODY>
</HTML>
