<HTML>
<HEAD>
<TITLE>OLAP: Data Analysis Module</TITLE>
</HEAD>

<BODY>

<script>
	window.onload = function() {
		document.getElementById('type').onchange = disablefield;
		document.getElementById('patient').onchange = disablefield;		
		document.getElementById('week').onchange = disablefield;
		document.getElementById('day').onchange = disablefield;
		document.getElementById('month').onchange = disablefield;
		document.getElementById('year').onchange = disablefield;
		document.getElementById('none').onchange = disablefield;
		document.getElementById('period').onchange = disablefield;
		document.getElementById('exact').onchange = disablefield;	
	}

	
	function disablefield()
	{
		if ( document.getElementById('patient').checked == true ){
			document.getElementById('spatient').disabled = true;	
		}else if(document.getElementById('patient').checked == false){
			document.getElementById('spatient').disabled = false;
		}

		if(document.getElementById('type').checked == true ){
			document.getElementById('stypes').disabled = true;
		}else if(document.getElementById('type').checked == false){
			document.getElementById('stypes').disabled = false;
		}

		if(document.getElementById('exact').checked == true){
			document.getElementById('sweek').disabled = false;
			document.getElementById('smonth').disabled = false;
			document.getElementById('syear').disabled = false;
			document.getElementById('sdate').disabled = false;
			document.getElementById('fmonth').disabled = true;
			document.getElementById('tmonth').disabled = true;
			document.getElementById('fweek').disabled = true;
			document.getElementById('tweek').disabled = true;
			document.getElementById('tdate').disabled = true;
			document.getElementById('fdate').disabled = true;
			document.getElementById('fyear').disabled = true;
			document.getElementById('tyear').disabled = true;
		}

		if(document.getElementById('period').checked == true){
			document.getElementById('sweek').disabled = true;
			document.getElementById('smonth').disabled = true;
			document.getElementById('syear').disabled = true;
			document.getElementById('sdate').disabled = true;
			document.getElementById('fmonth').disabled = false;
			document.getElementById('tmonth').disabled = false;
			document.getElementById('fweek').disabled = false;
			document.getElementById('tweek').disabled = false;
			document.getElementById('tdate').disabled = false;
			document.getElementById('fdate').disabled = false;
			document.getElementById('fyear').disabled = false;
			document.getElementById('tyear').disabled = false;
		}

		if(document.getElementById('none').checked == true||
			document.getElementById('day').checked == true||
			document.getElementById('year').checked == true||
			document.getElementById('month').checked == true||
			document.getElementById('week').checked == true){
			document.getElementById('sweek').disabled = true;
			document.getElementById('smonth').disabled = true;
			document.getElementById('syear').disabled = true;
			document.getElementById('sdate').disabled = true;
			document.getElementById('fmonth').disabled = true;
			document.getElementById('tmonth').disabled = true;
			document.getElementById('fweek').disabled = true;
			document.getElementById('tweek').disabled = true;
			document.getElementById('tdate').disabled = true;
			document.getElementById('fdate').disabled = true;
			document.getElementById('fyear').disabled = true;
			document.getElementById('tyear').disabled = true;
		}
		
	}
</script>

<%@ page import="java.sql.*,
   javax.portlet.ActionResponse.*,
   javax.swing.*,
   java.util.*,
   java.text.*" %>
<%
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");
	
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
		conn = DriverManager.getConnection(dbstring,"mingxun",
			"hellxbox_4801");
		conn.setAutoCommit(false);
	}catch(Exception ex){
       	out.println("<hr>" + ex.getMessage() + "<hr>");
	}
	
	if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
    }
	
	if(request.getParameter("generate") != null){
		String target = (request.getParameter("target")).trim();
		String type = (request.getParameter("type"));
		String period = (request.getParameter("timestamp"));
		
		if(target.equals("records")){
			return;
		}
		
	}
	
	Statement stmt = null;
	ResultSet rset = null;
	
	String test_types = "select distinct(test_type) from radiology_record";
	String patient_ids = "select u.person_id, "
		+ "CONCAT(CONCAT(p.first_name, ''), p.last_name) as patient_name "
		+ "from users u, persons p "
		+ "where u.person_id=p.PERSON_ID and u.CLASS='p'";
	
	try{
		stmt = conn.createStatement();
		rset = stmt.executeQuery(test_types);
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}
	
	ArrayList<String> types = new ArrayList<String>();
	while(rset != null && rset.next()){
		types.add(rset.getString(1));	
	}
		
	out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br><br>");
	out.println("</form>");
	
	out.println("<b>Find out more help information by clicking "
		+ "<a href='help.html#olap' target='blank'>Help</a></b><br>");	
	out.println("<hr>");
	
	out.println("<form action=olap.jsp>");
	out.println("<table BORDER=1>");
	out.println("<tr><td>");
	out.println("<p><b>You would like to see:</b></p>");
	out.println("<label for='records'></label>");
	out.println("The number of <b>records</b>: <input type=radio "
		+ "name=target id=records value=records required><br>");
	out.println("<label for='images'></label>");
	out.println("The number of <b>images</b>: <input type=radio" + 
		" name=target id=images value=images required>");
	out.println("</a></td>");
	out.println("<td></a></td>");

	out.println("<tr><td>");
	out.println("<p>for each:</p>");
	out.println("<b>test type</b>: <input type=checkbox name=type "
			+" id=type value=type><br>");
	out.println("</a></td>");
	out.println("<td><p>Or you would like to specify a test type</p>");
	out.println("<select name=selectTypes id=stypes style='width: 400px'>");
	for(int i = 0; i < types.size(); i++){
		out.println("<option value=\""+ types.get(i)+"\">" 
			+ types.get(i) + "</option>");
	}
	out.println("</select>");
	out.println("</a></td>");

	try{
		rset = stmt.executeQuery(patient_ids);
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}
	
	ArrayList<String> ids = new ArrayList<String>();
	ArrayList<String> names = new ArrayList<String>();
	while(rset != null && rset.next()){
		ids.add(rset.getString(1));
		names.add(rset.getString(2));
	}
	
	out.println("<tr><td>");	
	out.println("<p>for each:</p>");
	out.println("<b>patient</b>: <input type=checkbox name=people "
		+"id=patient value=patient>");
	out.println("</a></td>");
	
	out.println("<td>");
	out.println("<p>Or you would like to specify a patient id</p>");
	out.println("<select name=selectPatientId id=spatient style='width: 400px'>");
	for(int i = 0; i < ids.size(); i++){
		out.println("<option value=\"" + ids.get(i) + "\">" + ids.get(i) 
			+ ": " + names.get(i) + "</option>");
	}
	out.println("</select>");
	out.println("</a></td>");
	
	
	out.println("<tr><td>");
	out.println("<p>for test date in each:</p>");
	
	out.println("<b>day</b>: <input type=radio name=timestamp "
		+" id=day value=date required><br>");
	out.println("<label for='week'></label>");
			
	out.println("<b>week</b>: <input type=radio name=timestamp "
		+" id=week value=week required><br>");
	out.println("<label for='month'></label>");
			
	out.println("<b>month</b>: <input type=radio name=timestamp "
		+" id=month value=month required><br>");
	out.println("<label for='year'></label>");
			
	out.println("<b>year</b>: <input type=radio name=timestamp "
		+" id=year value=year required><br>");

	out.println("<b>a time period</b>: <input type=radio name=timestamp"
		+ " id=period value=period required><br>");

	out.println("<b>exact time</b>: <input type=radio name=timestamp"
		+ " id=exact value=exact required><br>");

	out.println("<b>none of above</b>: <input type=radio name=timestamp"
		+ " id=none value=none required><br>");
	
	out.println("</a></td>");
	out.println("<td><p>Or you would like to specify a date/week/month/year"
		+ "</p>");
	out.println("<p> Specify the result by week, month, year. </p>");
	out.println("Week&nbsp: <select name=selectWeek id=sweek style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 54; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	
	out.println("<br>");
	out.println("Month: <select name=selectMonth id=smonth style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='JAN'>Jan</option>");
	out.println("<option value='FEB'>Feb</option>");
	out.println("<option value='MAR'>Mar</option>");
	out.println("<option value='APR'>Apr</option>");
	out.println("<option value='MAY'>May</option>");
	out.println("<option value='JUN'>Jun</option>");
	out.println("<option value='JUL'>Jul</option>");
	out.println("<option value='AUG'>Aug</option>");
	out.println("<option value='SEP'>Sep</option>");
	out.println("<option value='OCT'>Oct</option>");
	out.println("<option value='NOV'>Nov</option>");
	out.println("<option value='DEC'>Dec</option>");
	out.println("</select><br>");
	
	out.println("Year&nbsp&nbsp: <select name=selectYear id=syear style='width: 150px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1900; i < 2015; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select><br>");
	
	out.println("<p> Or specify the result by exact date. </p>");
	out.println("Date: <input type=text name=date id=sdate maxlength=11>(Eg. JUN-01-2013)<br>");	
	out.println("</select>");
	out.println("<hr>");
	
	out.println("<p> Or choose a time period</p>");
	out.println("From Week&nbsp: <select name=fromWeek id=fweek style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 54; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("To Week &nbsp: <select name=toWeek id=tweek style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 54; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("<br>");
	
	out.println("From Month: <select name=fromMonth id=fmonth style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='JAN'>Jan</option>");
	out.println("<option value='FEB'>Feb</option>");
	out.println("<option value='MAR'>Mar</option>");
	out.println("<option value='APR'>Apr</option>");
	out.println("<option value='MAY'>May</option>");
	out.println("<option value='JUN'>Jun</option>");
	out.println("<option value='JUL'>Jul</option>");
	out.println("<option value='AUG'>Aug</option>");
	out.println("<option value='SEP'>Sep</option>");
	out.println("<option value='OCT'>Oct</option>");
	out.println("<option value='NOV'>Nov</option>");
	out.println("<option value='DEC'>Dec</option>");
	out.println("</select>");
	
	out.println("To Month: <select name=toMonth id=tmonth style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='JAN'>Jan</option>");
	out.println("<option value='FEB'>Feb</option>");
	out.println("<option value='MAR'>Mar</option>");
	out.println("<option value='APR'>Apr</option>");
	out.println("<option value='MAY'>May</option>");
	out.println("<option value='JUN'>Jun</option>");
	out.println("<option value='JUL'>Jul</option>");
	out.println("<option value='AUG'>Aug</option>");
	out.println("<option value='SEP'>Sep</option>");
	out.println("<option value='OCT'>Oct</option>");
	out.println("<option value='NOV'>Nov</option>");
	out.println("<option value='DEC'>Dec</option>");
	out.println("</select><br>");	
	
	out.println("From Year&nbsp&nbsp: <select name=fYear id=fyear "
		+"style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1900; i < 2015; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	
	out.println("To year&nbsp&nbsp: <select name=tYear id=tyear "
		+"style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1900; i < 2015; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("<br>");
	
	out.println("From Date: <input type=text name=fdate "
		+"id=fdate maxlength=11>(Eg. JUN-01-2013)<br>");	
	out.println("To &nbsp&nbsp&nbsp&nbsp&nbsp Date: "
		+ "<input type=text name=tdate id=tdate "
		+"maxlength=11>(Eg.JUN-02-2013)<br>");
	
	out.println("</a></td>");
	out.println("</table>");
	out.println("<input type=submit name=generate value='Go'><br>");
	out.println("<hr>");
	
	
	if(request.getParameter("generate") != null){
	
		/* target string is to record the choice of user on the number of
		 * images or records.
		 */
		String target = (request.getParameter("target")).trim();
		String timestamp = (request.getParameter("timestamp")).trim();
		
		/*
		 * Since type and other choices are optional, the strings may be null.
		 * Using trim() function on them is unsafe.
		 */
		String type = request.getParameter("type");
		String selectType = request.getParameter("selectType");
	
		String people = request.getParameter("people");
		String selectPeople = request.getParameter("selectPatientId");
		
		String toWeek = request.getParameter("toWeek");
		String fromWeek = request.getParameter("fromWeek");
		
		String fromMonth = request.getParameter("fromMonth");
		String toMonth = request.getParameter("toMonth");
		
		String fromYear = request.getParameter("fyear");
		String toYear = request.getParameter("tyear");
		
		String fromDate = request.getParameter();
		
		String select = "select ";
		String from = " from fact_comb"
		String where = " where ";
		String groupby = " group by ";
		
		ArrayList<String> selectElements = new ArrayList<String>();
		
		if(target.equals("record")){
			select += "count(distinct(record_id)) ";
		}else{
			select += "count(distinct(image_id)) ";
		}
		
		/* when checkbox is checked to see number of records
		 * for each patient.
		 */
		if(people != null && !people.isEmpty()){
			
			select += ", patient_id ";
			selectElements.add("patient_id");
			where += "patient_id is not null ";
			groupby += "patient_id";
		}else if(people == null && selectPeople != null 
				&& !selectPeople.equals("NA")){
			
			/* else if a specific person is selected*/
			select += ", patient_id ";
			selectElements.add("patient_id");
			where += "patient_id='" + selectPeople.trim() + "' ";	
			groupby += "patient_id";
		}
		
		if(type != null && !type.isEmpty()){
			
			select += ", test_type ";
			selectElements.add("test_type");
					
			if(where.length() > 6){
				where += " and ";
			}
			
			where += "test_type is not null";
			
			if(selectElements.size() > 1){
				groupby += ",";
			}
			groupby += "test_type";
		}else if(type == null && selectType != null
				&& !selectType.equals("NA")){
			
			select += ", test_type";
			selectElements.add("test_type");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += "test_type='" + selectType.trim() + "'";
			
			if(selectElements.size() > 1){
				groupby += ",";
			}
			groupby += "test_type";
			
		}
		
		if(timestamp.equals("day")){
			select += ", test_date";
			selectElements.add("test_date");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += "test_date is not null ";
			
			if(selectElements.size() > 1){
				groupby += ",";
			}
			
			groupby += "test_date";			
		}else if (timestamp.equals("week")){
			select += ", to_char(test_date, 'WW') as test_week";
			selectElements.add("test_week");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += "test_date is not null ";
			
			if(selectElements.size() > 1){
				groupby += ",";
			}
			
			groupby += "to_char(test_date, 'WW')";
		}else if(timestamp.equals("month")){
			
			select += ", to_char(test_date, 'MON') as test_month";
			selectElements.add("test_month");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += "test_date is not null ";
			
			if(selectElements.size() > 1){
				groupby += ",";
			}
			
			groupby += "to_char(test_date, 'MON')";			
		}else if(timestamp.equals("year")){
			
			select += ", to_char(test_date, 'YYYY') as test_year";
			selectElements.add("test_year");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += "test_date is not null ";
			
			if(selectElements.size() > 1){
				groupby += ",";
			}
			
			groupby += "to_char(test_date, 'YYYY')";					
		}else if(timestamp.equals("exact")){
			String selectWeek = request.getParameter("selectWeek");
			String selectMonth = request.getParameter("selectMonth");
			String selectYear = request.getParameter("selectYear");
			String selectDate = request.getParameter("date");
			
			if((!selectWeek.equals("NA") && !selectMonth.equals("NA")
				||(!selectWeek.equals("NA") && selectDate != null)
				||(!selectMonth.equals("NA") && selectDate != null)
				||(!selectYear.equals("NA") && selectDate != null)){
				JOptionPane.showMessageDialog(null, "Error 0: invalid "
					+"date! Please refer to help menu for error information.");
				request.sendRedirect("olap.jsp");
			}else if(!selectDate.isEmpty() && selectDate != null){
				
				if(!ValidateDate(selectDate.trim())){
					JOptionPane.showMessageDialog(null, "Error 1: invalid "
						+ "date format! Please make sure date is in "
						+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
					request.sendRedirect("olap.jsp");
				}
				select += ", test_date";
				selectElements.add("test_date");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += "test_date='" + selectDate.trim() + "' ";
				
				if(selectElements.size() > 1){
					groupby += ",";
				}
				
				groupby += "test_date ";				
			}else if(!selectWeek.equals("NA") && !selectYear.equals("NA")){
				select += ", to_char(test_date, 'YYYY-WW') as test_yearweek '";
				selectElements.add("test_yearweek");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += "to_char(test_date, 'YYYY-WW')='" 
					+ selectDate.trim() + "' ";
				
				if(selectElements.size() > 1){
					groupby += ",";
				}
				
				groupby += "to_char(test_date, 'YYYY-WW');				
				
			}else if(!selectMonth.equals("NA") && !selectYear.equals("NA")){
				select += ", to_char(test_date, 'YYYY-MON') as test_yearmon '";
				selectElements.add("test_yearmon");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += "to_char(test_date, 'YYYY-MON')='" 
					+ selectDate.trim() + "' ";
				
				if(selectElements.size() > 1){
					groupby += ",";
				}
				
				groupby += "to_char(test_date, 'YYYY-MON');		
			}else if(!selectMonth.equals("NA") && selectYear.equals("NA")){
				select += ", to_char(test_date, 'MON') as test_month '";
				selectElements.add("test_month");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += "to_char(test_date, 'MON')='" 
					+ selectDate.trim() + "' ";
				
				if(selectElements.size() > 1){
					groupby += ",";
				}
				
				groupby += "to_char(test_date, 'MON');	
			}else if(!selectWeek.equals("NA") && selectYear.equals("NA")){
				
				select += ", to_char(test_date, 'WW') as test_week '";
				selectElements.add("test_week");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += "to_char(test_date, 'WW')='" 
					+ selectDate.trim() + "' ";
				
				if(selectElements.size() > 1){
					groupby += ",";
				}
				
				groupby += "to_char(test_date, 'WW');	
			}else if(selectWeek.equals("NA") 
					&& selectMonth.equals("NA") && !selectYear.equals("NA")){
				select += ", to_char(test_date, 'YYYY') as test_year '";
				selectElements.add("test_year");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += "to_char(test_date, 'YYYY')='" 
					+ selectDate.trim() + "' ";
				
				if(selectElements.size() > 1){
					groupby += ",";
				}
				
				groupby += "to_char(test_date, 'YYYY');
			}
				
		}else if (timestamp.equlas("period")){
			
		}
		
		
	
		
		
	}
	
	try{
		conn.close();
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}


%>
<%!
	private String ConvertDate(String date, String format){
			return "to_char(" + date + ", '"+ format +"')";
	}
%>

<%!
	private boolean ValidateDate(String date){
		SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
		sdformat.setLenient(false);

   		try{
			sdformat.parse(from);
			sdformat.parse(to);
   		}catch(Exception ex){
			return false;
   		}
   		return true;
	}
%>

</BODY>
</HTML>
