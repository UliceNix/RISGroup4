<HTML>
<HEAD>
<TITLE>OLAP: Data Analysis Module</TITLE>
</HEAD>

<BODY>

<script>
	window.onload = function() {
		document.getElementById('fmonth').disabled = true;
		document.getElementById('tmonth').disabled = true;
		document.getElementById('fdate').disabled = true;
		document.getElementById('tdate').disabled = true;
		document.getElementById('fyear').disabled = true;
		document.getElementById('tyear').disabled = true;
		document.getElementById('fweek').disabled = true;
		document.getElementById('tweek').disabled = true;
		document.getElementById('sweek').disabled = true;
		document.getElementById('smonth').disabled = true;
		document.getElementById('syear').disabled = true;
		document.getElementById('sdate').disabled = true;
		
		document.getElementById('type').onchange = disablefield;
		document.getElementById('patient').onchange = disablefield;		
		document.getElementById('week').onchange = disablefield;
		document.getElementById('day').onchange = disablefield;
		document.getElementById('month').onchange = disablefield;
		document.getElementById('year').onchange = disablefield;
		document.getElementById('none').onchange = disablefield;
		document.getElementById('period').onchange = disablefield;
		document.getElementById('exact').onchange = disablefield;	

		document.getElementById('sweek').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('smonth').value = 'NA';
				document.getElementById('sdate').value = '';
				document.getElementById('smonth').disabled = true;
				document.getElementById('sdate').disabled = true;
			}else if(document.getElementById('syear').value == 'NA'){
				document.getElementById('smonth').disabled = false;
				document.getElementById('sdate').disabled = false;
			}else {
				document.getElementById('smonth').disabled = false;
			}
		};

		document.getElementById('smonth').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('sweek').value = 'NA';
				document.getElementById('sdate').value = '';
				document.getElementById('sweek').disabled = true;
				document.getElementById('sdate').disabled = true;
			}else if(document.getElementById('syear').value == 'NA'){
				document.getElementById('sweek').disabled = false;
				document.getElementById('sdate').disabled = false;
			}else {
				document.getElementById('sweek').disabled = false;
			}
		};

		document.getElementById('syear').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('sdate').disabled = true;
			}else if(document.getElementById('smonth').value == 'NA'
				&& document.getElementById('sweek').value == 'NA'){
				document.getElementById('sdate').disabled = false;
			}
		};

		
		document.getElementById('fweek').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('fmonth').value = 'NA';
				document.getElementById('tmonth').value = 'NA';
				document.getElementById('fdate').value = null;
				document.getElementById('tdate').value = null;
				document.getElementById('fmonth').disabled = true;
				document.getElementById('tmonth').disabled = true;
				document.getElementById('fdate').disabled = true;
				document.getElementById('tdate').disabled = true;
			}else if(document.getElementById('tweek').value == 'NA'){
				document.getElementById('fmonth').disabled = false;
				document.getElementById('tmonth').disabled = false;
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};
		
		document.getElementById('tweek').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('fmonth').value = 'NA';
				document.getElementById('tmonth').value = 'NA';
				document.getElementById('fdate').value = null;
				document.getElementById('tdate').value = null;
				document.getElementById('fmonth').disabled = true;
				document.getElementById('tmonth').disabled = true;
				document.getElementById('fdate').disabled = true;
				document.getElementById('tdate').disabled = true;
			}else if(document.getElementById('fweek').value == 'NA'){
				document.getElementById('fmonth').disabled = false;
				document.getElementById('tmonth').disabled = false;
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};
	
		document.getElementById('fmonth').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('fweek').value = 'NA';
				document.getElementById('tweek').value = 'NA';
				document.getElementById('fdate').value = null;
				document.getElementById('tdate').value = null;
				document.getElementById('fweek').disabled = true;
				document.getElementById('tweek').disabled = true;
				document.getElementById('fdate').disabled = true;
				document.getElementById('tdate').disabled = true;
			}else if(document.getElementById('tmonth').value == 'NA'){
				document.getElementById('fweek').disabled = false;
				document.getElementById('tweek').disabled = false;
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};
		
		document.getElementById('tmonth').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('fweek').value = 'NA';
				document.getElementById('tweek').value = 'NA';
				document.getElementById('fdate').value = null;
				document.getElementById('tdate').value = null;
				document.getElementById('fweek').disabled = true;
				document.getElementById('tweek').disabled = true;
				document.getElementById('fdate').disabled = true;
				document.getElementById('tdate').disabled = true;
			}else if(document.getElementById('fmonth').value == 'NA'){
				document.getElementById('fweek').disabled = false;
				document.getElementById('tweek').disabled = false;
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};

		document.getElementById('fyear').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('fdate').value = null;
				document.getElementById('tdate').value = null;
				document.getElementById('fdate').disabled = true;
				document.getElementById('tdate').disabled = true;
			}else if(document.getElementById('tyear').value == 'NA'
					&& document.getElementById('fweek').value == 'NA'
					&& document.getElementById('fmonth').value == 'NA'
					&& document.getElementById('tweek').value == 'NA'
					&& document.getElementById('tmonth').value == 'NA'){
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};

		document.getElementById('tyear').onchange = function(){
			if(this.value != 'NA'){
				document.getElementById('fdate').value = null;
				document.getElementById('tdate').value = null;
				document.getElementById('fdate').disabled = true;
				document.getElementById('tdate').disabled = true;
			}else if(document.getElementById('fyear').value == 'NA'
					&& document.getElementById('fweek').value == 'NA'
					&& document.getElementById('fmonth').value == 'NA'
					&& document.getElementById('tweek').value == 'NA'
					&& document.getElementById('tmonth').value == 'NA'){
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};

		document.getElementById('fdate').onchange = function(){
			if(this.value != '' || this.value.length > 0){
				document.getElementById('fweek').value = 'NA';
				document.getElementById('tweek').value = 'NA';
				document.getElementById('fmonth').value = 'NA';
				document.getElementById('tmonth').value = 'NA';
				document.getElementById('fyear').value = 'NA';
				document.getElementById('tyear').value = 'NA';

				document.getElementById('fweek').disabled = true;
				document.getElementById('tweek').disabled = true;
				document.getElementById('fmonth').disabled = true;
				document.getElementById('tmonth').disabled = true;
				document.getElementById('fyear').disabled = true;
				document.getElementById('tyear').disabled = true;
			}else if (document.getElementById('tdate').value == '' ||
					document.getElementById('tdate').length < 1){
				document.getElementById('fweek').disabled = false;
				document.getElementById('tweek').disabled = false;
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};

		document.getElementById('tdate').onchange = function(){
			if(this.value != '' || this.value.length > 0){
				document.getElementById('fweek').value = 'NA';
				document.getElementById('tweek').value = 'NA';
				document.getElementById('fmonth').value = 'NA';
				document.getElementById('tmonth').value = 'NA';
				document.getElementById('fyear').value = 'NA';
				document.getElementById('tyear').value = 'NA';

				document.getElementById('fweek').disabled = true;
				document.getElementById('tweek').disabled = true;
				document.getElementById('fmonth').disabled = true;
				document.getElementById('tmonth').disabled = true;
				document.getElementById('fyear').disabled = true;
				document.getElementById('tyear').disabled = true;
			}else if (document.getElementById('fdate').value == '' ||
					document.getElementById('fdate').length < 1){
				document.getElementById('tmonth').value = 'NA';
				document.getElementById('fweek').disabled = false;
				document.getElementById('tweek').disabled = false;
				document.getElementById('fdate').disabled = false;
				document.getElementById('tdate').disabled = false;				
			}
		};
		
		
		
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
	
	/*********************************************************************
	 *    				Establish Connection							 *
	 *********************************************************************/
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
	
	out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br><br>");
	out.println("</form>");
	
	out.println("<b>Find out more help information by clicking "
		+ "<a href='help.html#olap' target='blank'>Help</a></b><br>");	
	out.println("<hr>");
	
	if(request.getParameter("generate") != null){
		
		Statement statement = null;
		ResultSet resultSet = null;
			
		String timestamp = (request.getParameter("timestamp")).trim();
		
		/*
		 * Since type and other choices are optional, the strings may be null.
		 * Using trim() function on them is unsafe.
		 */
		String type = request.getParameter("type");
		String selectType = request.getParameter("selectType");
	
		String people = request.getParameter("people");
		String selectPeople = request.getParameter("selectPatientId");
		
		String with = "with fact_comb as (select i.image_id, patient_id, test_type,"
				+ " test_date, count(distinct(i.image_id)) as number_of_images"
				+ " from radiology_record r left join "
				+ " (select record_id, image_id from pacs_images) i "
				+ " on i.record_id = r.record_id"
				+ " group by cube(i.image_id, patient_id, test_type, test_date)) ";
		String select = " select ";
		String from = " from fact_comb ";
		String where = "where ";
		String groupby = " group by ";
		
		ArrayList<String> selectElements = new ArrayList<String>();
		
		select += "count(distinct(image_id)) ";
		selectElements.add("Number Of Images");
		/* when checkbox is checked to see number of records
		 * for each patient.
		 */
		 
		if(people != null && !people.isEmpty()){
			
			select += ", patient_id ";
			selectElements.add("Patient Id");
			where += " patient_id is not null ";
			groupby += "patient_id";
		}else if(people == null && selectPeople != null 
				&& !selectPeople.equals("NA")){
			
			/* else if a specific person is selected*/
		
			select += ", patient_id ";
			selectElements.add("Patient Id");
			where += " patient_id='" + selectPeople.trim() + "' ";	
			groupby += "patient_id";
		}
		
		if(type != null && !type.isEmpty()){
			
			select += ", test_type ";
			selectElements.add("Test Type");
					
			if(where.length() > 6){
				where += " and ";
			}
			
			where += " test_type is not null";
			
			if(selectElements.size() > 2){
				groupby += ",";
			}
			groupby += "test_type";
		}else if(type == null && selectType != null
				&& !selectType.equals("NA")){
			
			select += ", test_type";
			selectElements.add("Test Type");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += " test_type='" + selectType.trim() + "'";
			
			if(selectElements.size() > 2){
				groupby += ",";
			}
			groupby += "test_type";
			
		}
		
		
		if(timestamp.equals("date")){
			select += ", test_date";
			selectElements.add("Test Time");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += " test_date is not null ";
			
			if(selectElements.size() > 2){
				groupby += ",";
			}
			
			groupby += "test_date";			
		}else if (timestamp.equals("week")){
			select += ", to_char(test_date, 'WW') as test_week";
			selectElements.add("Test Time");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += " test_date is not null ";
			
			if(selectElements.size() > 2){
				groupby += ",";
			}
			
			groupby += "to_char(test_date, 'WW')";
		}else if(timestamp.equals("month")){
			
			select += ", to_char(test_date, 'MON') as test_month";
			selectElements.add("Test TDate");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += " test_date is not null ";
			
			if(selectElements.size() > 2){
				groupby += ",";
			}
			
			groupby += "to_char(test_date, 'MON')";			
		}else if(timestamp.equals("year")){
			
			select += ", to_char(test_date, 'YYYY') as test_year";
			selectElements.add("test Time");
			
			if(where.length() > 6){
				where += " and ";
			}
			
			where += " test_date is not null ";
			
			if(selectElements.size() > 2){
				groupby += ",";
			}
			
			groupby += "to_char(test_date, 'YYYY')";	
			
		}else if(timestamp.equals("exact")){
			
			String selectWeek = request.getParameter("selectWeek");
			String selectMonth = request.getParameter("selectMonth");
			String selectYear = request.getParameter("selectYear");
			String selectDate = request.getParameter("date");
		
			if(Empty(selectDate) && Empty(selectMonth) && Empty(selectYear)
					&& Empty(selectWeek)){
				try{
					JOptionPane.showMessageDialog(null, "Error 3: please make"
						+"sure that you have entered correct time information"
						+" in Week or Month or Year or Date.");
					response.sendRedirect("/proj1/olap.jsp");
					return;
				}catch(Exception ex){
					out.println("error on display or others");
				}
			}else if(selectDate != null && !selectDate.isEmpty()){
				
				if(!ValidateDate(selectDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
						response.sendRedirect("/proj1/olap.jsp");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				out.println("<hr>" + selectDate + "<hr>");
				select += ", test_date";
				selectElements.add("Test Time");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += " test_date='" + selectDate.trim() + "' ";
				where += " and  test_date is not null ";
				
				if(selectElements.size() > 2){
					groupby += ",";
				}
				
				groupby += "test_date ";				
			}else if(selectWeek != null && !selectWeek.equals("NA")){
				String format = "";
				String targetDate = "";
				if(selectYear != null && !selectYear.equals("NA")){
					format = "YYYY-WW";
					targetDate = selectYear + "-" + selectWeek;
				}else{
					format = "WW";
					targetDate = selectWeek;
				}
				select += ", to_char(test_date, '" + format + "') as test_date";
				selectElements.add("Test Time");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += " to_date(to_char(test_date, '" + format +"'), '" 
					+ format + "')=to_date('" + targetDate + "', '" 
					+ format + "') ";
				where += " and test_date is not null ";
				if(selectElements.size() > 2){
					groupby += ", ";
				}
				groupby += " to_char(test_date, '" + format + "')";
			}else if(selectMonth != null && !selectMonth.equals("NA")){
				String format = "";
				String targetDate = "";
				
				if(selectYear != null && !selectYear.equals("NA")){
					format = "YYYY-MON";
					targetDate = selectYear + "-" + selectMonth;
				}else{
					format = "MON";
					targetDate = selectMonth;
				}
				
				select += ", to_char(test_date, '" + format + "') as test_date";
				selectElements.add("Test Time");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += " to_char(test_date, '" + format +"')='" + targetDate + "'";
				where += " and to_char(test_date, '" + format +"') is not null ";
				if(selectElements.size() > 2){
					groupby += ", ";
				}
				groupby += " to_char(test_date, '" + format + "')";
				
			}else if(selectYear != null && !selectYear.equals("NA")){
				select += ", to_char(test_date, 'YYYY') as test_date";
				selectElements.add("Test Time");
				
				if(where.length() > 6){
					where += " and ";
				}
				
				where += " to_char(test_date, 'YYYY')='" + selectYear + "'";
				where += " and  to_char(test_date, 'YYYY') is not null ";
				if(selectElements.size() > 2){
					groupby += ", ";
				}
				groupby += " to_char(test_date, 'YYYY')";
			}			
		}else if(timestamp.equals("period")){
			
			String toWeek = request.getParameter("toWeek");
			String fromWeek = request.getParameter("fromWeek");
			
			String fromMonth = request.getParameter("fromMonth");
			String toMonth = request.getParameter("toMonth");
			
			String fromYear = request.getParameter("fYear");
			String toYear = request.getParameter("tYear");
			
			String fromDate = request.getParameter("fdate");
			String toDate = request.getParameter("tdate");
			
			String format1 = "";
			String target1 = "";
			String target2 = "";
			
			if(Empty(toWeek) && Empty(fromWeek)
					&& Empty(toMonth) && Empty(fromMonth)
					&& Empty(toYear) && Empty(fromYear)
					&& Empty(fromDate) && Empty(toDate)){
				try{
					JOptionPane.showMessageDialog(null, "636Error 3: please make"
						+"sure that you have entered correct time information"
						+" in Week or Month or Year or Date.");
					response.sendRedirect("/proj1/olap.jsp");
					return;
				}catch(Exception ex){
					out.println("error on display or others");
				}				
			}else if(NotEmpty(fromDate)){
				if(!ValidateDate(fromDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
						response.sendRedirect("/proj1/olap.jsp");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				
				if(NotEmpty(toDate) || !ValidateDate(toDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
						response.sendRedirect("/proj1/olap.jsp");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				
				format1 = "dd-MON-YYYY";
				target1 = toDate.trim();
				target2 = toDate.trim();
				
			}else if(NotEmpty(toDate)){
				
				if(!ValidateDate(toDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
						response.sendRedirect("/proj1/olap.jsp");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				format1 = "dd-MON-YYYY";
				target2= toDate.trim();
				
			}else if(NotEmpty(fromWeek)){				
				
				format1 = (NotEmpty(fromYear)) ? "YYYY-WW" : "WW";
				target1 = (format1.equals("WW")) ? fromWeek.trim() 
						: fromYear.trim() + "-" + fromWeek.trim();
			
				boolean checkYW = (format1.equals("WW") == true) ? false : true;
				
				if(checkYW){
					if((NotEmpty(toYear) && Empty(toWeek))
						|| (Empty(toYear) && NotEmpty(toWeek))){
						try{
							JOptionPane.showMessageDialog(null, "Error 4: "
								+ "Unpaired date. Please check your input.");
							response.sendRedirect("/proj1/olap.jsp");
							return;
						}catch(Exception ex){
							out.println("error on display or others");
						}
					}else if(NotEmpty(toYear) && NotEmpty(toWeek)){
						target2 = toYear.trim() + "-" + toWeek.trim();
					}
				}else{
					target2 = toWeek.trim();
				}
 			}else if(NotEmpty(toWeek)){

				if(NotEmpty(fromYear)){
					JOptionPane.showMessageDialog(null, "Unpaired Date! Please make" 
						+ " sure you only select Week or Year-Week.");
					response.sendRedirect("olap.jsp");
					return;
				}
				
				format1 = (NotEmpty(toYear)) ? "YYYY-WW" : "WW";
				target2 = (format1.equals("WW")) ? toWeek.trim() 
						: toYear.trim() + "-" + toWeek.trim();
 			}else if(NotEmpty(fromMonth)){				
				format1 = (NotEmpty(fromYear)) ? "YYYY-MON" : "MON";
				target1 = (format1.equals("MON")) ? fromMonth.trim() 
						: fromYear.trim() + "-" + fromMonth.trim();

				boolean checkYM = (format1.equals("MON") == true) ? false : true;
				if(checkYM){
					if((NotEmpty(toYear) && Empty(toMonth))
							|| (Empty(toYear) && NotEmpty(toMonth))){
							try{
								JOptionPane.showMessageDialog(null, "Error 4: "
									+ "Unpaired date. Please check your input.");
								response.sendRedirect("/proj1/olap.jsp");
								return;
							}catch(Exception ex){
								out.println("error on display or others");
							}
						}else if(NotEmpty(toYear) && NotEmpty(toMonth)){
							target2 = toYear.trim() + "-" + toWeek.trim();
						}	
				}else{
					if(NotEmpty(toMonth)){
						target2 = toMonth.trim();
					}					
				}				
 			}else if (NotEmpty(toMonth)){
 				
				if(NotEmpty(fromYear)){
					JOptionPane.showMessageDialog(null, "Unpaired Date! Please make" 
						+ " sure you only select Month or Year-Month.");
					response.sendRedirect("olap.jsp");
					return;
				}
				format1 = (NotEmpty(toYear)) ? "YYYY-MON" : "MON";
				target2 = (format1.equals("MON")) ? toMonth.trim() 
						: toYear.trim() + "-" + toMonth.trim();
				
 			}else if(NotEmpty(fromYear)){
 				format1 = "YYYY";
 				target1 = fromYear.trim();

				if(NotEmpty(toYear)){
					target2 = toYear.trim();
				}
 			}else if(NotEmpty(toYear)){
 				format1 = "YYYY";
 				target2 = toYear.trim();				
 			}
			
			select += ", to_char(test_date,'"+format1+"')";
			selectElements.add("Test Time");
			where = (where.length() > 6) ? where + " and " : where;
			where += "test_date is not null ";
			
			if(target1 != null && !target1.isEmpty()){
				where += " and " + toTestDate(format1) + " >= " + toTargetDate(target1, format1);
			}
			if(target2 != null && !target2.isEmpty()){
				where = where + " and " + toTestDate(format1) + " < " + toTargetDate(target2, format1);
			}
			
			groupby = (selectElements.size() > 2) ? groupby + "," : groupby;
			groupby += "to_char(test_date,'"+format1+"')";
			
		}
		
		for(int i = 0 ; i < selectElements.size(); i++){
			out.println(selectElements.get(i) + "<br>");
		}
		
		String sql = with + select + from;

		sql = (where.length() > 6) ? sql + where: sql;
		sql = (groupby.length() > 10) ? sql + groupby : sql;
		
		out.println(sql + "<hr>");
		/*
		try{
			statement = conn.createStatement();
			resultSet = statement.executeQuery(sql);
		}catch(Exception ex){
			out.println("<hr>Error: " + ex.getMessage() + "<hr>");
		}
		out.println("<hr><b>Result: </b><br>");
		out.println("<table border=1>");
		out.println("<tr>");
		for(int i = 0; i < selectElements.size(); i++){
			out.println("<td><p>" + selectElements.get(i) + "<p></a></td>");
		}
		while(resultSet.next() && resultSet != null){
			out.println("<tr>");
			for(int i = 0; i < selectElements.size(); i++){
				out.println("<td><p>" + resultSet.getString(i+1) + "<p></a></td>");
			}
		}
		out.println("</table>");
		out.println("<br><hr>");
	*/
	}

	
	/************************************************************************
	*  
	*                  UI Design Part starts here
	*
	*************************************************************************/
	Statement stmt = null;
	ResultSet rset = null;
	
	String test_types = "select distinct(test_type) from radiology_record";
	String patient_ids = "select distinct(u.person_id), "
		+ "CONCAT(CONCAT(p.first_name, ''), p.last_name) as patient_name "
		+ "from users u, persons p "
		+ "where u.person_id=p.PERSON_ID and u.CLASS='p'"
		+ " and p.first_name is not null and p.last_name is not null"
		+ " order by u.person_id";
	
	try{
		stmt = conn.createStatement();
		rset = stmt.executeQuery(test_types);
	}catch(Exception ex){
		out.println("<hr>Error: " + ex.getMessage() + "<hr>");
	}
	
	ArrayList<String> types = new ArrayList<String>();
	while(rset != null && rset.next()){
		if(rset.getString(1) != null){
			types.add(rset.getString(1));	
		}
	}
	
	/*********************************************************************
	 *    				Build UI Table  								 *
	 *********************************************************************/
	out.println("<form action=olap.jsp>");
	out.println("<table BORDER=1>");

	out.println("<tr><td>");
	out.println("<p>for each:</p>");
	out.println("<b>test type</b>: <input type=checkbox name=type "
			+" id=type value=type><br>");
	out.println("</a></td>");
	out.println("<td><p>Or you would like to specify a test type</p>");
	out.println("<select name=selectTypes id=stypes style='width: 400px'>");
	out.println("<option value='NA'>N/A</option>");
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
	out.println("<option value='NA'>N/A</option>");
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
	for(int i = 2014; i > 1899; i--){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select><br>");
	
	out.println("<p> Or specify the result by exact date. </p>");
	out.println("Date: <input type=text name=date id=sdate maxlength=11>(Eg. 09-AUG-2013)<br>");
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
	for(int i = 2014; i > 1899; i--){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	
	out.println("To year&nbsp&nbsp: <select name=tYear id=tyear "
		+"style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 2014; i > 1899; i--){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("<br>");
	
	out.println("From Date: <input type=text name=fdate "
		+"id=fdate maxlength=11>(Eg. 01-JUN-2013)<br>");
	out.println("To &nbsp&nbsp&nbsp&nbsp&nbsp Date: "
		+ "<input type=text name=tdate id=tdate "
		+"maxlength=11>(Eg.05-JUN-2013)<br>");
	
	out.println("</a></td>");
	out.println("</table>");
	out.println("<input type=submit name=generate value='Go'><br>");
	out.println("<hr>");
	
	/*********************************************************************
	 *    				Close Connection								 *
	 *********************************************************************/
	try{
		conn.close();
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}


%>

<%!
	private boolean ValidateDate(String date){
		SimpleDateFormat sdformat = new SimpleDateFormat("dd-MMM-yyyy");
		sdformat.setLenient(false);

   		try{
			sdformat.parse(date);
   		}catch(Exception ex){
			return false;
   		}
   		return true;
	}
%>

<%!
	private boolean Empty(String str){
		return (str == null || str.isEmpty() || str.equals("NA"));
	}
%>

<%!
	private boolean NotEmpty(String str){
		return (str != null && !str.isEmpty() && !str.equals("NA"));
	}
%>

<%!
	private String toTargetDate(String targetdate, String format){
		return "to_date('" + targetdate + "', '" + format + "')";
	}
%>

<%!
	private String toTestDate(String format){
		return "to_date(to_char(test_date, '" + format + "'), '" + format + "') ";
	}
%>



</BODY>
</HTML>
