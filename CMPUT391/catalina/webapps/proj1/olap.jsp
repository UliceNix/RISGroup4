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
		
		document.getElementById('fweek').onchange = function(){
			if(this.value != 'NA'){
				disableDates();
			}else if(clearFromTos() == true){
				enableDates();			
			}
		};
		
		document.getElementById('tweek').onchange = function(){
			if(this.value != 'NA'){
				disableDates();
			}else if(clearFromTos() == true){
				enableDates();			
			}
		};
	
		document.getElementById('fmonth').onchange = function(){
			if(this.value != 'NA'){
				disableDates();
			}else if(clearFromTos() == true){
				enableDates();			
			}
		};
		
		document.getElementById('tmonth').onchange = function(){
			if(this.value != 'NA'){
				disableDates();
			}else if(clearFromTos() == true){
				enableDates();			
			}
		};

		document.getElementById('fyear').onchange = function(){
			if(this.value != 'NA'){
				disableDates();
			}else if(clearFromTos() == true){
				enableDates();			
			}
		};

		document.getElementById('tyear').onchange = function(){
			if(this.value != 'NA'){
				disableDates();
			}else if(clearFromTos() == true){
				enableDates();			
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
		
		document.getElementById('sweek').onchange = function(){
			if(this.value != 'NA'){
				disableSdate();
			}else if(clearSdate() == true){
				enableSdate();
			}
		};
		

		document.getElementById('smonth').onchange = function(){
			if(this.value != 'NA'){
				disableSdate();
			}else if(clearSdate() == true){
				enableSdate();
			}
		};

		document.getElementById('syear').onchange = function(){
			if(this.value != 'NA'){
				disableSdate();
			}else if(clearSdate() == true){
				enableSdate();
			}
		};
		
		document.getElementById('sdate').onchange = function(){
			if(this.value != '' || this.value.length > 0){
				disableSdate();
			}else if(clearSdate() == true){
				enableSdate();
			}
		};
		
		
	}

	function disableDates(){
		document.getElementById('fdate').value = '';
		document.getElementById('tdate').value = "";
		document.getElementById('fdate').disabled = true;
		document.getElementById('tdate').disabled = true;
	}
	
	function enableDates(){
		document.getElementById('fdate').disabled = false;
		document.getElementById('tdate').disabled = false;
	}
	
	function clearFromTos(){
		return document.getElementById('tmonth').value == 'NA'
			&& document.getElementById('tweek').value == 'NA'
			&& document.getElementById('tyear').value == 'NA'
			&& document.getElementById('fmonth').value == 'NA'
			&& document.getElementById('fweek').value == 'NA'
			&& document.getElementById('fyear').value == 'NA';;
	}
	
	function disableSdate(){
		document.getElementById('sdate').value = '';
		document.getElementById('sdate').disabled = true;
	}
	
	function enableSdate(){
		document.getElementById('sdate').disabled = false;
	}
	
	function clearSelect(){
		return document.getElementById('smonth').value == 'NA'
		&& document.getElementById('sweek').value == 'NA'
		&& document.getElementById('syear').value == 'NA';
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


<%@ page import="java.sql.*,
   javax.portlet.ActionResponse.*,
   javax.swing.*,
   java.util.*,
   java.text.*" %>
<%
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");

	if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
	}

	Connection conn = getConnection();
	
	if(conn == null){
		JOptionPane.showMessageDialog(null, "Can't get a connection."
		+" Please try again.");
		response.sendRedirect("olap.jsp");
	}
	
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
	
	out.println("<form action=adminhomepage.jsp>");
	out.println("<input type=submit name=Back value='Go Back'><br><br>");
	out.println("</form>");
	
	out.println("<b>Find out more help information by clicking "
		+ "<a href='help.html#olap' target='blank'>Help</a></b><br>");	
	out.println("<hr>");
	
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
	for(int i = 1; i < 6; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	
	out.println("<br>");
	out.println("Month: <select name=selectMonth id=smonth style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='01'>Jan</option>");
	out.println("<option value='02'>Feb</option>");
	out.println("<option value='03'>Mar</option>");
	out.println("<option value='04'>Apr</option>");
	out.println("<option value='05'>May</option>");
	out.println("<option value='06'>Jun</option>");
	out.println("<option value='07'>Jul</option>");
	out.println("<option value='08'>Aug</option>");
	out.println("<option value='09'>Sep</option>");
	out.println("<option value='10'>Oct</option>");
	out.println("<option value='11'>Nov</option>");
	out.println("<option value='12'>Dec</option>");
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
	for(int i = 1; i < 6; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("To Week &nbsp: <select name=toWeek id=tweek style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 6; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("<br>");
	
	out.println("From Month: <select name=fromMonth id=fmonth style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='01'>Jan</option>");
	out.println("<option value='02'>Feb</option>");
	out.println("<option value='03'>Mar</option>");
	out.println("<option value='04'>Apr</option>");
	out.println("<option value='05'>May</option>");
	out.println("<option value='06'>Jun</option>");
	out.println("<option value='07'>Jul</option>");
	out.println("<option value='08'>Aug</option>");
	out.println("<option value='09'>Sep</option>");
	out.println("<option value='10'>Oct</option>");
	out.println("<option value='11'>Nov</option>");
	out.println("<option value='12'>Dec</option>");
	out.println("</select>");
	
	out.println("To Month: <select name=toMonth id=tmonth style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	out.println("<option value='01'>Jan</option>");
	out.println("<option value='02'>Feb</option>");
	out.println("<option value='03'>Mar</option>");
	out.println("<option value='04'>Apr</option>");
	out.println("<option value='05'>May</option>");
	out.println("<option value='06'>Jun</option>");
	out.println("<option value='07'>Jul</option>");
	out.println("<option value='08'>Aug</option>");
	out.println("<option value='09'>Sep</option>");
	out.println("<option value='10'>Oct</option>");
	out.println("<option value='11'>Nov</option>");
	out.println("<option value='12'>Dec</option>");
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
	
	if(request.getParameter("generate") != null){
		Statement sm = null;
		ResultSet rs = null;
		
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
		
		String from = " from fact_comb left join (select test_date, "
			+ "to_char(test_date, 'YYYY') as test_year, "
			+ "to_char(test_date, 'MM') as test_month, "
			+ "to_char(test_date, 'W') as test_week "
			+ "from (select distinct test_date "
			+ "from radiology_record where test_date is not null)) t "
			+ "on t.test_date = fact_comb.test_date ";
		
		String where = "where ";
		String groupby = " group by ";
		
		ArrayList<String> selectElements = new ArrayList<String>();
		
		select += "count(distinct(image_id)) ";
		selectElements.add("Number Of Images");
		
		/************************************************************
		* 			When a person id option is selected 
		************************************************************/
		if(people != null || 
				(selectPeople != null && !selectPeople.equals("NA"))){
			
			if(people != null && !people.isEmpty()){
				where += " patient_id is not null ";				
			}else if(people == null && selectPeople != null 
					&& !selectPeople.equals("NA")){				
				/* else if a specific person is selected*/		
				where += " patient_id='" + selectPeople.trim() + "' ";	
			}
			
			selectElements.add("Patient Id");
			select += ", patient_id ";
			groupby += "patient_id";
		}
		
		/************************************************************
		* 			When a type is selected 
		************************************************************/
		if(type != null ||
				(selectType != null && !selectType.isEmpty())){

			select += ", test_type ";
			selectElements.add("Test Type");
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			groupby += "test_type";
			
			if(type != null && !type.isEmpty()){
				where += " test_type is not null";
			}else if(type == null && selectType != null
					&& !selectType.equals("NA")){				
				where += " test_type='" + selectType.trim() + "'";				
			}
		}
		
		/************************************************************
		* 			When a time option is selected 
		************************************************************/
		if(timestamp.equals("date")){
			select += ", t.test_date";
			selectElements.add("Test Time");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " t.test_date is not null ";
			groupby += "t.test_date";			
			
		}else if (timestamp.equals("week")){
			select += ", to_char(t.test_date, 'WW') as test_week";
			selectElements.add("Test Time");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " t.test_date is not null ";			
			groupby += "to_char(t.test_date, 'WW')";
			
		}else if(timestamp.equals("month")){
			
			select += ", to_char(t.test_date, 'MON') as test_month";
			selectElements.add("Test TDate");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " t.test_date is not null ";			
			groupby += "to_char(t.test_date, 'MON')";			
		}else if(timestamp.equals("year")){
			
			select += ", to_char(t.test_date, 'YYYY') as test_year";
			selectElements.add("test Time");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " t.test_date is not null ";
			groupby += "to_char(t.test_date, 'YYYY')";	
			
		}else if(timestamp.equals("exact")){
			
			String selectWeek = request.getParameter("selectWeek");
			String selectMonth = request.getParameter("selectMonth");
			String selectYear = request.getParameter("selectYear");
			String selectDate = request.getParameter("date");
			
			if(Empty(selectDate) 
					&& Empty(selectMonth) 
					&& Empty(selectYear)
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
							+" 'DD-MON-YYYY, eg. 02-FEB-2012'.");
						response.sendRedirect("/proj1/olap.jsp");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				
				select += ", t.test_date";
				selectElements.add("Test Time");
				
				where = (where.length() > 6) ? where + " and " : where;
				where += " t.test_date='" + selectDate.trim() + "' ";
				where += " and  t.test_date is not null ";
				
				groupby = (selectElements.size() > 2) 
						? groupby + "," : groupby;
				groupby += "t.test_date ";				
			}else if(NotEmpty(selectWeek)){
				select += ", t.test_week";
				selectElements.add("Test Week");
				
				where = (where.length() > 6) ? where + " and " : where;
				where += " t.test_week='"+ selectWeek.trim() +"' ";
				
				groupby = (selectElements.size() > 2) 
						? groupby + "," : groupby;
				groupby += " t.test_week ";
				
				if(NotEmpty(selectMonth)){
					select += ", t.test_month";
					selectElements.add("Test Month");
					
					where += " and t.test_month='" + selectMonth.trim() + "'";
					groupby += ", t.test_month ";
				}
				
				if(NotEmpty(selectYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += " and t.test_year='" + selectYear.trim() + "'";
					groupby += ", t.test_year ";
				}			
			}else if(NotEmpty(selectMonth)){
				select += ", t.test_month";
				selectElements.add("Test Month");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_month='" + selectMonth.trim() + "'";
				groupby += " t.test_month ";
				
				if(NotEmpty(selectYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += " and t.test_year='" + selectYear.trim() + "'";
					groupby += ", t.test_year ";
				}
				
			}else if(NotEmpty(selectYear)){
				select += ", t.test_year";
				selectElements.add("Test Year");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_year='" + selectYear.trim() + "'";
				groupby += " t.test_year ";
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
			
			if(Empty(toWeek) && Empty(fromWeek)
					&& Empty(toMonth) && Empty(fromMonth)
					&& Empty(toYear) && Empty(fromYear)
					&& Empty(fromDate) && Empty(toDate)){
				try{
					JOptionPane.showMessageDialog(null, "Error 3: please make"
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
				
				/* the input date is valid*/
				select += ", t.test_date";
				selectElements.add("Test Date");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_date >= '" + fromDate.trim() + "' ";
				groupby += " t.test_date";
				
				if(NotEmpty(toDate) && !ValidateDate(toDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
						response.sendRedirect("/proj1/olap.jsp");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}else if(NotEmpty(toDate) && ValidateDate(toDate.trim())){
					where += " and t.test_date < '" + toDate.trim() + "' ";
				}
				
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
				select += ", t.test_date";
				selectElements.add("Test Date");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_date < '" + toDate.trim() + "' ";
				groupby += " t.test_date";
			}else if(NotEmpty(fromWeek) && NotEmpty(toWeek)){
				
				select += ", t.test_week";
				selectElements.add("Test Week");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_week >= '" + fromWeek.trim() + "' ";
				where += " and t.test_week <'" + toWeek.trim() + "'";
				groupby += " t.test_week";
				
				if(NotEmpty(fromMonth) && NotEmpty(toMonth)){
					select += ", t.test_month";
					selectElements.add("Test Month");
					
					where += "and t.test_month >= '" 
					+ fromMonth.trim() + "' and t.test_month < '" 
					+ toMonth.trim() + "'";
					groupby += ", t.test_month";
				}
				
				if(NotEmpty(fromYear) && NotEmpty(toYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += "and t.test_year >= '" 
					+ fromYear.trim() + "' and t.test_year < '" 
					+ toYear.trim() + "'";
					groupby += ", t.test_year";
				}	
			}else if(NotEmpty(fromMonth) && NotEmpty(toMonth)){
				select += ", t.test_month";
				selectElements.add("Test Month");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_month >= '" + fromMonth.trim() + "' ";
				where += " and t.test_month <'" + toMonth.trim() + "'";
				groupby += " t.test_month";
				
				if(NotEmpty(fromYear) && NotEmpty(toYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += "and t.test_year >= '" 
					+ fromYear.trim() + "' and t.test_year < '" 
					+ toYear.trim() + "'";
					groupby += ", t.test_year";
				}				
			}else if(NotEmpty(fromYear) && NotEmpty(toYear)){
				select += ", t.test_year";
				selectElements.add("Test Year");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_year >= '" + fromYear.trim() + "' ";
				where += " and t.test_year <'" + toYear.trim() + "'";
				groupby += " t.test_year";
			}else if(NotEmpty(fromWeek)){
				select += ", t.test_week";
				selectElements.add("Test Week");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_week >= '" + fromWeek.trim() + "'";
				groupby += " t.test_week";
				
				if(NotEmpty(fromMonth)){
					select += ", t.test_month";
					selectElements.add("Test Month");
					
					where += "and t.test_month >= '" + fromMonth.trim() + "'";
					groupby += ", t.test_month";
				}
				
				if(NotEmpty(fromYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += "and t.test_year >= '" + fromYear.trim() + "'";
					groupby += ", t.test_year";
				}
			}else if(NotEmpty(fromMonth)){
				select += ", t.test_month";
				selectElements.add("Test Month");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_month >= '" + fromMonth.trim() + "'";
				groupby += " t.test_month";
				
				if(NotEmpty(fromYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += "and t.test_year >= '" + fromYear.trim() + "'";
					groupby += ", t.test_year";
				}
			}else if(NotEmpty(fromYear)){
				select += ", t.test_year";
				selectElements.add("Test Year");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_year >= '" + fromYear.trim() + "'";
				groupby += " t.test_year";
			}else if(NotEmpty(toWeek)){
				select += ", t.test_week";
				selectElements.add("Test Week");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_week < '" + toWeek.trim() + "'";
				groupby += " t.test_week";
				
				if(NotEmpty(toMonth)){
					select += ", t.test_month";
					selectElements.add("Test Month");
					
					where += "and t.test_month < '" + toMonth.trim() + "'";
					groupby += ", t.test_month";
				}
				
				if(NotEmpty(toYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += "and t.test_year < '" + toYear.trim() + "'";
					groupby += ", t.test_year";
				}
			}else if(NotEmpty(toMonth)){
				select += ", t.test_month";
				selectElements.add("Test Month");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_month < '" + toMonth.trim() + "'";
				groupby += " t.test_month";
				
				if(NotEmpty(toYear)){
					select += ", t.test_year";
					selectElements.add("Test Year");
					
					where += "and t.test_year < '" + toYear.trim() + "'";
					groupby += ", t.test_year";
				}
			}else if(NotEmpty(toYear)){
				select += ", t.test_year";
				selectElements.add("Test Year");
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " t.test_year < '" + toYear.trim() + "'";
				groupby += " t.test_year";
			}
		}
		
		String sql = with + select + from;

		sql = (where.length() > 6) ? sql + where: sql;
		sql = (groupby.length() > 10) ? sql + groupby : sql;
		out.println(sql + "<hr>");
		
		conn = getConnection();
		if(conn == null){
			JOptionPane.showMessageDialog(null, "Can't get a connection."
			+" Please try again.");
			response.sendRedirect("olap.jsp");
		}
		
		
		
		try{
			sm = conn.createStatement();
			rs = sm.executeQuery(sql);
		}catch(Exception ex){
			out.println("<hr>Error: " + ex.getMessage() + "<hr>");
		}
		
		out.println("<hr><b>Result: </b><br>");
		out.println("<table border=1>");
		out.println("<tr>");
		for(int i = 0; i < selectElements.size(); i++){
			out.println("<td><p>" + selectElements.get(i) + "<p></a></td>");
		}
		
		while(rs.next() && rs != null){
			out.println("<tr>");
			for(int i = 0; i < selectElements.size(); i++){
				out.println("<td><p>" + rs.getString(i+1) + "<p></a></td>");
			}
		}
		out.println("</table>");
		out.println("<br><hr>");
		
		try{
			conn.close();
		}catch(Exception ex){
			out.println("<hr>Error" + ex.getMessage() + "<hr>");
		}
		
		
		
	}
	
	/*********************************************************************
	 *    				Close Connection								 *
	 *********************************************************************/
	try{
		conn.close();
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}

%>

</BODY>
</HTML>