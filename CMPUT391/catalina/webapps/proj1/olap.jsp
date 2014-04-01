<HEAD>
<TITLE>OLAP: Data Analysis Module</TITLE>
</HEAD>

<BODY>

<script>

	/* 
	 * These javascript functions are mainly responsible for 
	 * determining which input fields should be available 
	 * for a user
	 */
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
		
		/* When user is trying to select a period of time, and clicks
		 * from/to week, from/to month, from/to year will result 
		 * in disabling from/to date fields.
		 */
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
		
		/* When user is trying to select a period of time, and clicks
		 * select week, select month, select year will result 
		 * in disabling select date fields.
		 */
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
				document.getElementById('smonth').value == 'NA';
				document.getElementById('sweek').value == 'NA';
				document.getElementById('syear').value == 'NA';
				document.getElementById('smonth').disabled == true;
				document.getElementById('sweek').disabled == true;
				document.getElementById('syear').disabled == true;
			}else{
				document.getElementById('smonth').disabled == false;
				document.getElementById('sweek').disabled == false;
				document.getElementById('syear').disabled == false;
			}
		};
		
		
	}
	
	/* clear from/to date input field and disable them*/
	function disableDates(){
		document.getElementById('fdate').value = '';
		document.getElementById('tdate').value = "";
		document.getElementById('fdate').disabled = true;
		document.getElementById('tdate').disabled = true;
	}
	
	/* enable the input fields: from/to date*/
	function enableDates(){
		document.getElementById('fdate').disabled = false;
		document.getElementById('tdate').disabled = false;
	}
	
	/* before disable all from/to month, week, year fields,
	 * we need to make sure the values in those fields won't 
	 * effect the data analysis result. Then clearFromTos
	 * comes in and does this job.
	 */
	function clearFromTos(){
		return document.getElementById('tmonth').value == 'NA'
			&& document.getElementById('tweek').value == 'NA'
			&& document.getElementById('tyear').value == 'NA'
			&& document.getElementById('fmonth').value == 'NA'
			&& document.getElementById('fweek').value == 'NA'
			&& document.getElementById('fyear').value == 'NA';;
	}
	
	/* clear select date input field and disable it */
	function disableSdate(){
		document.getElementById('sdate').value = '';
		document.getElementById('sdate').disabled = true;
	}
	/* enable select date input field */
	function enableSdate(){
		document.getElementById('sdate').disabled = false;
	}
	
	/* A helper function that check if all fields starting with select
	 * have null or NA values.*/
	function clearSelect(){
		return document.getElementById('smonth').value == 'NA'
		&& document.getElementById('sweek').value == 'NA'
		&& document.getElementById('syear').value == 'NA';
	}
	
	
	/* A high level and common function that disables fields depending
	 * on user's choice. Specific cases like exact time or time period
	 * are handled by funcitons above.
 	 */
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
	/*
	 * ValidateDate function takes in a string parameter, which is exptected
	 * to be a date. And by applying standard format parse function to see
	 * if the date satisfies the specified date format.
	 */
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
	/*
	 * Empty returns a boolean value that indicates if the value of an
	 * input field is empty or NA.
	 */
	private boolean Empty(String str){
		return (str == null || str.isEmpty() || str.equals("NA"));
	}
%>

<%!
	/*
 	* NotEmpty returns a boolean value that indicates if the value of an
 	* input field is not empty and not NA.
 	*/
	private boolean NotEmpty(String str){
		return (str != null && !str.isEmpty() && !str.equals("NA"));
	}
%>

<%!
	/* getConnection() returns a connection to databse. */
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
<%! 
	/* This helper function is responsible for constructing a string
	 * according to a format.
	 */
	private String getTestdate(String format){
		String selectedDate = "to_char(test_date,'" + format + "')";
		return selectedDate;
	}
%>

<%! 
	/* This helper function is responsible for constructing a string
	 * according to a format.
	 */
	private String getHierTestdate(String date, 
			String oldformat, String newformat){
		String selectedDate = "to_char(to_date('" + date + "', '"
			+ oldformat+"'),'" + newformat + "')";
		return selectedDate;
	}
%>


<%@ page import="java.sql.*,
   javax.portlet.ActionResponse.*,
   javax.swing.*,
   java.util.*,
   java.text.*" %>
<%
	/* As this module requires a signed in user. 
	 * If current session expires or no person_id is available,
	 * the user who is trying to access this page will be directed 
	 * to the login page.
	 */
	Integer person_id = (Integer) session.getAttribute("Person_Id");
	String role = (String) session.getAttribute("PermissionLevel");

	if(person_id == null || !role.equals("a")){
		response.sendRedirect("login.jsp");
		return;
	}

	/* 
	 * As stated in the assignment specification, before executing a 
	 * search, a user should be able to see records that are availeble
	 * to him/her. Thus we need a connection to database and retrieve
	 * the available records and display them.
	 */
	Connection conn = getConnection();	
	if(conn == null){
		JOptionPane.showMessageDialog(null, "Can't get a connection."
		+" Please try again.");
		response.sendRedirect("olap.jsp");
		return;
	}
	
	Statement stmt = null;
	ResultSet rset = null;
	
	/* queries that extract necessary information for user to choose.*/
	String test_types = "select distinct(test_type) from radiology_record";
	String patient_ids = "select distinct(u.person_id), "
		+ "CONCAT(CONCAT(p.first_name, ''), p.last_name) as patient_name "
		+ "from users u, persons p "
		+ "where u.person_id=p.PERSON_ID and u.CLASS='p'"
		+ " and p.first_name is not null and p.last_name is not null"
		+ " order by u.person_id";
	
	/* execute test_types query to get all test types */
	try{
		stmt = conn.createStatement();
		rset = stmt.executeQuery(test_types);
	}catch(Exception ex){
		out.println("<hr>Error: " + ex.getMessage() + "<hr>");
	}
	
	/* retrieve the result and put them in an array list */
	ArrayList<String> types = new ArrayList<String>();
	while(rset != null && rset.next()){
		if(rset.getString(1) != null){
			types.add(rset.getString(1));	
		}
	}
	
	/* execute patient_ids to get all available patients and their ids*/
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
	
	/* UI HEAD */
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

	out.println("<tr><td>");	
	out.println("<p>for each:</p>");
	out.println("<b>patient</b>: <input type=checkbox name=people "
		+"id=patient value=patient>");
	out.println("</a></td>");
	
	out.println("<td>");
	out.println("<p>Or you would like to specify a patient id</p>");
	out.println("<select name=selectPatientId id=spatient "
		+"style='width: 400px'>");
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
	
	out.println("<b>week & month & year</b>: <input type=radio name=timestamp "
			+" id=weekmonthyear value=weekmonthyear required><br>");
	
	out.println("<b>month & year</b>: <input type=radio name=timestamp "
			+" id=monthyear value=monthyear required><br>");
	
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
	out.println("Week&nbsp: <select name=selectWeek id=sweek "
		+"style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 6; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	
	out.println("<br>");
	out.println("Month: <select name=selectMonth id=smonth "
		+"style='width: 100px'>");
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
	
	out.println("Year&nbsp&nbsp: <select name=selectYear id=syear "
		+ "style='width: 150px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 2014; i > 1899; i--){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select><br>");
	
	out.println("<p> Or specify the result by exact date. </p>");
	out.println("Date: <input type=text name=selectDate id=sdate "
		+"maxlength=11>(Eg. 09-AUG-2013)<br>");
	out.println("</select>");
	out.println("<hr>");
	
	out.println("<p> Or choose a time period</p>");
	out.println("From Week&nbsp: <select name=fromWeek id=fweek "
		+"style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 6; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("To Week &nbsp: <select name=toWeek id=tweek "
		+"style='width: 100px'>");
	out.println("<option value='NA'>N/A</option>");
	for(int i = 1; i < 6; i++){
		out.println("<option value="+ i + ">"+i+"</option>");
	}
	out.println("</select>");
	out.println("<br>");
	
	out.println("From Month: <select name=fromMonth id=fmonth "
		+"style='width: 100px'>");
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
	
	out.println("To Month: <select name=toMonth id=tmonth "
		+"style='width: 100px'>");
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
	out.println("</form>");
	out.println("<hr>");
	
	
	/*********************************************************************
	 *    				Close Connection								 *
	 *********************************************************************/
	try{
		conn.close();
	}catch(Exception ex){
		out.println("<hr>Error" + ex.getMessage() + "<hr>");
	}
	
	/*********************************************************************
	 *    				Handle Search Request						     *
	 *********************************************************************/
	if(request.getParameter("generate") != null){
		Statement sm = null;
		ResultSet rs = null;

		/* retrieve user's time period choice */
		String timestamp = (request.getParameter("timestamp")).trim();
		
		/*
		 * Since type and other choices are optional, the strings may be null.
		 * Using trim() function on them is unsafe.
		 */
		String type = request.getParameter("type");
		String selectType = request.getParameter("selectTypes");
	
		String people = request.getParameter("people");
		String selectPeople = request.getParameter("selectPatientId");
		
		/************************************************************
		* 			Query Composition Section
		*************************************************************/
		
		String with = "with fact_comb as (select i.image_id, patient_id, "
				+ "test_type,"
				+ " test_date, count(distinct(i.image_id)) as number_of_images"
				+ " from radiology_record r left join "
				+ " (select record_id, image_id from pacs_images) i "
				+ " on i.record_id = r.record_id"
				+ " group by cube(i.image_id, patient_id, test_type, "
				+ "test_date)) ";
		String select = " select ";		
		String from = " from fact_comb ";
		String where = "where ";
		String groupby = " group by ";
		String format = "";
		
		/* array that records the selected columns */
		ArrayList<String> selectElements = new ArrayList<String>();
		
		/* Since default is to select the number of images, then we 
		 * know that count(distinct(image_id)) would definitely be
		 * in the select caluse 
		 */
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
				(NotEmpty(selectType))){

			select += ", test_type ";
			selectElements.add("Test Type");
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			groupby += "test_type";
			
			if(type != null){
				where += " test_type is not null";
			}else if(type == null && selectType != null
					&& !selectType.equals("NA")){				
				where += " test_type='" + selectType.trim() + "'";	
				where += " and test_type is not null";
			}
		}
		
		/************************************************************
		* 			When a time option is selected 
		************************************************************/
		
		/* show the number of images classified by an exact time*/
		String selectWeek = request.getParameter("selectWeek");
		String selectMonth = request.getParameter("selectMonth");
		String selectYear = request.getParameter("selectYear");
		String selectDate = request.getParameter("selectDate");
		
		String toWeek = request.getParameter("toWeek");
		String fromWeek = request.getParameter("fromWeek");
		
		String fromMonth = request.getParameter("fromMonth");
		String toMonth = request.getParameter("toMonth");
		
		String fromYear = request.getParameter("fYear");
		String toYear = request.getParameter("tYear");
		
		String fromDate = request.getParameter("fdate");
		String toDate = request.getParameter("tdate");
		
		String label = "";
		
		if(timestamp.equals("date")){
			
			/* show the number of images classified by dates */
			select += ", test_date";
			selectElements.add("Test Date");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " test_date is not null ";
			groupby += "test_date";			
			
		}else if (timestamp.equals("week")){
			
			/* show the number of images classified by the weeks in a month */
			select += ", to_char(test_date, 'W') as test_week";
			selectElements.add("Test Week");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " test_date is not null ";			
			groupby += "to_char(test_date, 'W')";
			
		}else if(timestamp.equals("month")){
			
			/* show the number of images classified by the months in a year */
			select += ", to_char(test_date, 'MON') as test_month";
			selectElements.add("Test Month");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " test_date is not null ";			
			groupby += "to_char(test_date, 'MON')";			
		}else if(timestamp.equals("year")){
			
			/* show the number of images classified by years */
			select += ", to_char(test_date, 'YYYY') as test_year";
			selectElements.add("Test Year");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " test_date is not null ";
			groupby += "to_char(test_date, 'YYYY')";	
			
		}else if(timestamp.equals("monthyear")){
			/* show the number of images classified by years */
			select += ", to_char(test_date, 'YYYY-mm') as test_yearmonth";
			selectElements.add("Test Month&Year");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " test_date is not null ";
			groupby += "to_char(test_date, 'YYYY-mm')";	
			
		}else if(timestamp.equals("weekmonthyear")){
			/* show the number of images classified by years */
			select += ", to_char(test_date, 'YYYY-mm-W') as test_yearmonth";
			selectElements.add("Test Week&Month&Year");
			
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			
			where += " test_date is not null ";
			groupby += "to_char(test_date, 'YYYY-mm-W')";	
		}else if(timestamp.equals("exact")){
			
			if((selectDate == null || selectDate.isEmpty()) 
					&& Empty(selectMonth) 
					&& Empty(selectYear)
					&& Empty(selectWeek)){
				
				try{
					JOptionPane.showMessageDialog(null, "Error 3: please make"
						+"sure that you have entered correct time information"
						+" in Week or Month or Year or Date.");
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
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				format = "DD-MON-YYYY";
			}else if(NotEmpty(selectWeek)){
				
				/* first we are sure that we need the number of week
				 * to do the date comparison
				 */
				format = "W";
				
				/* determine the final format:
				 * if year is not empty, change format to YYYY-W
				 * if month is not empty, change format to mm-W
				 * if both are not empty, change format to YYYY-mm-W
				 */
				format = (NotEmpty(selectYear)) ? "YYYY-W" : format;
				format = (NotEmpty(selectMonth)) ? "mm-W" : format;
				format = (NotEmpty(selectMonth) && NotEmpty(selectYear)) ? 
						"YYYY-mm-W" : format;
				
			}else if(NotEmpty(selectMonth)){
				
				/* determine the format
				 * at this step, week is definitely empty, thus possible
				 * formats are mm and YYYY-mm
				 */
				format = "mm";
				format = (NotEmpty(selectYear)) ? "YYYY-mm" : format;
				
			}else if(NotEmpty(selectYear)){
				
				/* The only possible format is YYYY */
				format = "YYYY";
			}
			selectElements.add("Test Time");
			
			where = (where.length() > 6) ? where + " and " : where;				
			groupby = (selectElements.size() > 2) 
					? groupby + "," : groupby;
			
			select += "," + getTestdate(format);
			where += " test_date is not null ";
			
			if(format.equals("W")){
				where += " and " + getTestdate(format) + "='" 
					+ selectWeek.trim() + "'";
			}else if(format.equals("mm")){
				where += " and " + getTestdate(format) + "='" 
						+ selectMonth.trim() + "'";
			}else if(format.equals("YYYY")){
				where += " and " + getTestdate(format) + "='" 
						+ selectYear.trim() + "'";
			}else if(format.equals("mm-W")){
				where += " and " + getTestdate(format) + "='" 
						+ selectMonth.trim() + "-" 
						+ selectWeek.trim() + "'";
			}else if(format.equals("YYYY-W")){
				where += " and " + getTestdate(format) + "='" 
						+ selectYear.trim() + "-" 
						+ selectWeek.trim() + "'";
			}else if(format.equals("YYYY-mm")){
				where += " and " + getTestdate(format) + "='" 
						+ selectYear.trim() + "-" 
						+ selectMonth.trim() + "'";
			}else if(format.equals("YYYY-mm-W")){
				where += " and " + getTestdate(format) + "='" 
						+ selectYear.trim() + "-" 
						+ selectMonth.trim() + "-" 
						+ selectWeek.trim() + "'";
			}else if(format.equals("DD-MON-YYYY")){
				where += " and " + getTestdate(format) + "='"
					+ selectDate.trim() + "'";
			}
				
			groupby += getTestdate(format);
			
		}else if(timestamp.equals("period")){
			
			selectElements.add("Test Time");
			
			/* make sure at least one possible input field is not empty*/
			if(Empty(toWeek) && Empty(fromWeek)
					&& Empty(toMonth) && Empty(fromMonth)
					&& Empty(toYear) && Empty(fromYear)
					&& Empty(fromDate) && Empty(toDate)){
				try{
					JOptionPane.showMessageDialog(null, "Error 3: please make"
						+"sure that you have entered correct time information"
						+" in Week or Month or Year or Date.");
					return;
				}catch(Exception ex){
					out.println("error on display or others");
				}				
			}else if(NotEmpty(fromDate)){
				
				/* Handle from/to or from or to date first. It's the easist.*/
				if(!ValidateDate(fromDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'DD-MON-YYYY, eg. 02-FEB-2012'.");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				
				/* the input date is valid*/
				select += ", test_date";
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " test_date >= '" + fromDate.trim() + "' ";
				groupby += " test_date";
				
				label = "from";
				
				/* if the toDate is not empty*/
				if(NotEmpty(toDate) && !ValidateDate(toDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'DD-MON-YYYY, eg. 02-FEB-2012'.");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}else if(NotEmpty(toDate) && ValidateDate(toDate.trim())){
					where += " and test_date < '" + toDate.trim() + "' ";
					label = "both";
				}
				
				format = "DD-MON-YYYY";
			}else if(NotEmpty(toDate)){
				
				/* when fromDate is empty, check if toDate is empty and 
				 * refine selection based on only toDate
				 */
				if(!ValidateDate(toDate.trim())){
					try{
						JOptionPane.showMessageDialog(null, "Error 1: invalid "
							+ "date format! Please make sure date is in "
							+" 'dd-MON-YYYY, eg. 02-FEB-2012'.");
						return;
					}catch(Exception ex){
						out.println("error on display or others");
					}
				}
				select += ", test_date";
				
				where = (where.length() > 6) ? where + " and " : where;
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " test_date < '" + toDate.trim() + "' ";
				groupby += " test_date";
				
				format = "DD-MON-YYYY";
				label = "to";
			}else if(NotEmpty(fromWeek) && NotEmpty(toWeek)){
				
				/* Hanle situation: from Week x to Week y */
				format = "W";

				where = (where.length() > 6) ? where + " and " : where;
				where += "test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				/* Hanle situation: from Month x to Month y */
				if(NotEmpty(fromMonth) && NotEmpty(toMonth)){
					format = "mm-W";
				}
				
				/* Hanle situation: from year x to year y */
				if(NotEmpty(fromYear) && NotEmpty(toYear)){
					format = "YYYY-mm-W";
				}	
				
				/* based on the resulted date format from above
				 * determine how we are going to edit the where clause*/
				 
				if(format.equals("W")){
					where += " and " + getTestdate(format) + ">='" 
						+ fromWeek.trim() 
						+ "' and " + getTestdate(format) + "<'" + toWeek.trim() 
						+ "' ";
					
				}else if(format.equals("mm-W")){
					where += " and " + getTestdate(format) + ">='" 
							+ fromMonth.trim() + "-" + fromWeek.trim() 
							+ "' and " + getTestdate(format) + "<'" 
							+ toMonth.trim() + "-" + toWeek.trim() + "' ";
					
				}else if(format.equals("YYYY-mm-W")){
					where += " and " + getTestdate(format) + ">='" 
							+ fromYear.trim() 
							+ "-" + fromMonth.trim() 
							+ "-" + fromWeek.trim() 
							+ "' and " + getTestdate(format) + "<'" 
							+ toYear.trim() 
							+ "-" + toMonth.trim() 
							+ "-" + toWeek.trim() + "' ";
				}
				
				select += "," + getTestdate(format);
				groupby += getTestdate(format);
				
				label = "both";
				
			}else if(NotEmpty(fromMonth) && NotEmpty(toMonth)){
				
				format = "mm";

				where = (where.length() > 6) ? where + " and " : where;
				where += "test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				/* chekc if fromYear and toYear are applicable to search*/
				if(NotEmpty(fromYear) && NotEmpty(toYear)){
					format = "YYYY-mm";
				}	
				
				if(format.equals("mm")){
					where += " and " + getTestdate(format) + ">='" 
						+ fromMonth.trim() 
						+ "' and " + getTestdate(format) + "<'" 
						+ toMonth.trim() 
						+ "' ";
					
				}else if(format.equals("YYYY-mm")){
					where += " and " + getTestdate(format) + ">='" 
							+ fromYear.trim() 
							+ "-" + fromMonth.trim() 
							+ "' and " + getTestdate(format) + "<'" 
							+ toYear.trim() 
							+ "-" + toMonth.trim() + "' ";
				}			
				
				select += "," + getTestdate(format);
				groupby += getTestdate(format);
				
				label = "both";
				
			}else if(NotEmpty(fromYear) && NotEmpty(toYear)){
				
				select += ", to_char(test_date, 'YYYY')";
				
				where = (where.length() > 6) ? where + " and " : where;
				where += " test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " and to_char(test_date, 'YYYY') >= '" 
					+ fromYear.trim() + "' ";
				where += " and to_char(test_date,'YYYY') <'" 
					+ toYear.trim() + "'";
				groupby += " to_char(test_date, 'YYYY')";
				
				format = "YYYY";
				
				label = "both";
				
			}else if(NotEmpty(fromWeek)){
				
				format = "W";

				where = (where.length() > 6) ? where + " and " : where;
				where += " test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				if(NotEmpty(fromMonth)){
					format = "mm-W";
				}
				
				if(NotEmpty(fromYear)){
					format = "YYYY-mm-W";
				}	
				
				if(format.equals("W")){
					where += " and " + getTestdate(format) + ">='" 
						+ fromWeek.trim() + "' ";
					
				}else if(format.equals("mm-W")){
					where += " and " + getTestdate(format) + ">='" 
							+ fromMonth.trim() + "-" + fromWeek.trim() + "' ";
					
				}else if(format.equals("YYYY-mm-W")){
					where += " and " + getTestdate(format) + ">='" 
							+ fromYear.trim() 
							+ "-" + fromMonth.trim() 
							+ "-" + fromWeek.trim() 
							+ "' ";
				}
				
				select += "," + getTestdate(format);
				groupby += getTestdate(format);
				
				label = "from";
				
			}else if(NotEmpty(fromMonth)){
				
				format = "mm";

				where = (where.length() > 6) ? where + " and " : where;
				where += "test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				if(NotEmpty(fromYear)){
					format = "YYYY-mm";
				}	
				
				if(format.equals("mm")){
					where += " and " + getTestdate(format) + ">='" 
						+ fromMonth.trim() + "' ";
					
				}else if(format.equals("YYYY-mm")){
					where += " and " + getTestdate(format) + ">='" 
							+ fromYear.trim() 
							+ "-" + fromMonth.trim() + "' ";
				}			
				
				select += "," + getTestdate(format);
				groupby += getTestdate(format);
			
				label = "from";
				
			}else if(NotEmpty(fromYear)){
				
				select += ", to_char(test_date, 'YYYY')";
				
				where = (where.length() > 6) ? where + " and " : where;
				where += " test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " and to_char(test_date, 'YYYY') >= '" 
					+ fromYear.trim() + "' ";
				groupby += " to_char(test_date, 'YYYY')";
				
				format = "YYYY";
				label = "from";
				
			}else if(NotEmpty(toWeek)){
				format = "W";

				where = (where.length() > 6) ? where + " and " : where;
				where += " test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				if(NotEmpty(toMonth)){
					format = "mm-W";
				}
				
				if(NotEmpty(toYear)){
					format = "YYYY-mm-W";
				}	
				
				if(format.equals("W")){
					where += " and " + getTestdate(format) + "<'" 
						+ toWeek.trim() + "' ";
					
				}else if(format.equals("mm-W")){
					where += " and " + getTestdate(format) + "<'" 
							+ toMonth.trim() + "-" + toWeek.trim() + "' ";
					
				}else if(format.equals("YYYY-mm-W")){
					where += " and " + getTestdate(format) + "<'" 
							+ toYear.trim() 
							+ "-" + toMonth.trim() 
							+ "-" + toWeek.trim() 
							+ "' ";
				}
				
				select += "," + getTestdate(format);
				groupby += getTestdate(format);
				label = "to";
				
			}else if(NotEmpty(toMonth)){
				
				format = "mm";

				where = (where.length() > 6) ? where + " and " : where;
				where += "test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				if(NotEmpty(toYear)){
					format = "YYYY-mm";
				}	
				
				if(format.equals("mm")){
					where += " and " + getTestdate(format) + "<'" 
						+ toMonth.trim() + "' ";
					
				}else if(format.equals("YYYY-mm")){
					where += " and " + getTestdate(format) + "<'" 
							+ toYear.trim() 
							+ "-" + toMonth.trim() + "' ";
				}			
				
				select += "," + getTestdate(format);
				groupby += getTestdate(format);
				label = "to";
				
			}else if(NotEmpty(toYear)){
				select += ", to_char(test_date, 'YYYY')";
				
				where = (where.length() > 6) ? where + " and " : where;
				where += " test_date is not null ";
				groupby = (selectElements.size() > 2) ? 
						groupby + "," : groupby;
				
				where += " and to_char(test_date, 'YYYY') < '" 
					+ fromYear.trim() + "' ";
				groupby += " to_char(test_date, 'YYYY')";
				
				format = "YYYY";
				label = "to";
			}
		}
		
		/* combine clauses together */
		String sql = with + select + from;

		/* Just in case the user simple wants the number of images, 
		 * namely, select nothing but "none of above", we do not 
		 * add where and group by clause
		 */
		sql = (where.length() > 6) ? sql + where: sql;
		sql = (groupby.length() > 10) ? sql + groupby : sql;
	

		/* try to get a connection to database */
		conn = getConnection();
		if(conn == null){
			JOptionPane.showMessageDialog(null, "Can't get a connection."
			+" Please try again.");
			return;
		}

		/* execute the search query */
		try{
			sm = conn.createStatement();
			rs = sm.executeQuery(sql);
		}catch(Exception ex){
			try{
				conn.close();
			}catch(Exception ex1){
				out.println("<hr>Error" + ex1.getMessage() + "<hr>");
			}
			out.println("<hr>Error: " + ex.getMessage() + "<hr>");
			return;
		}
		
		/* display the result in the following table */
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

		
		/* close the connection */
		try{
			conn.close();
		}catch(Exception ex){
			out.println("<hr>Error" + ex.getMessage() + "<hr>");
		}
		
		/* provide drill down and roll up operations on tables that created 
		 * based on selecting an exact time or a time period
		 */
		if(timestamp.equals("exact") || timestamp.equals("period")){	
			
			session.setAttribute("selectPeople", selectPeople);
			session.setAttribute("selectType", selectType);
			session.setAttribute("type", type);
			session.setAttribute("people", people);
			session.setAttribute("format", format);
			session.setAttribute("label", label);
			
			out.println("<form action=olap.jsp>");
			if(format.equals("YYYY-mm-W")){	
				out.println("Available operations: <select name=operation "
					+"id=operation style='width: 300px'><br>");
				out.println("<option value='NA'>N/A</option>");
				out.println("<option value='YYYY'>Roll Up: year </option>");
				out.println("<option value='YYYY-mm'>Roll Up: "
					+"year-month</option>");
				out.println("</select>");
				if(timestamp.equals("exact")){
					session.setAttribute("selectYear", selectYear.trim());
					session.setAttribute("selectMonth", selectMonth.trim());
					session.setAttribute("selectWeek", selectWeek.trim());
				}else{
					session.setAttribute("fromYear", fromYear.trim());
					session.setAttribute("fromMonth", fromMonth.trim());
					session.setAttribute("fromWeek", fromWeek.trim());
					session.setAttribute("toYear", toYear.trim());
					session.setAttribute("toMonth", toMonth.trim());
					session.setAttribute("toWeek", toWeek.trim());
				}
			}else if(format.equals("YYYY-mm")){
				out.println("Available operations: <select name=operation "
						+"id=operation style='width: 300px'><br>");
				out.println("<option value='NA'>N/A</option>");
				out.println("<option value='YYYY'>Roll Up: year </option>");
				out.println("<option value='YYYY-mm-W'>Drill Down: "
					+"year-month-week</option>");
				out.println("</select>");
				
				if(timestamp.equals("exact")){
					session.setAttribute("selectYear", selectYear.trim());
					session.setAttribute("selectMonth", selectMonth.trim());					
				}else{
					session.setAttribute("fromYear", fromYear.trim());
					session.setAttribute("fromMonth", fromMonth.trim());					
					session.setAttribute("toYear", toYear.trim());
					session.setAttribute("toMonth", toMonth.trim());
				}		
			}else if(format.equals("YYYY")){
				out.println("Available operations: <select name=operation "
						+"id=operation style='width: 300px'><br>");
				out.println("<option value='NA'>N/A</option>");
				out.println("<option value='YYYY-mm'>Drill Down: year-month"
					+" </option>");
				out.println("<option value='YYYY-mm-W'>Drill Down: "
					+"year-month-week</option>");
				out.println("</select>");
				
				if(timestamp.equals("exact")){
					session.setAttribute("selectYear", selectYear.trim());				
				}else{
					session.setAttribute("fromYear", fromYear.trim());				
					session.setAttribute("toYear", toYear.trim());
				}
				
			}else if(format.equals("DD-MON-YYYY")){
				out.println("Available operations: <select name=operation "
						+"id=operation style='width: 300px'><br>");
				out.println("<option value='NA'>N/A</option>");
				out.println("<option value='YYYY'>Roll Up: year </option>");
				out.println("<option value='YYYY-mm'>Roll Up: year-month"
					+" </option>");
				out.println("<option value='YYYY-mm-W'>Roll Up: "
					+"year-month-week</option>");
				out.println("</select>");
				
				if(timestamp.equals("exact")){
					session.setAttribute("selectDate", selectDate.trim());				
				}else{
					session.setAttribute("fromDate", fromDate.trim());				
					session.setAttribute("toDate", toDate.trim());
				}
				
			}else{
				return;
			}	
			
			if(timestamp.equals("exact")){
				session.setAttribute("timeType", "exact");
			}else{
				session.setAttribute("timeType", "period");
			}
			out.println("<input type=submit name=DrillRoll "
				+"value='Drill Down/Roll Up'><br><br>");
			out.println("</form>");			
		}
	}else if(request.getParameter("DrillRoll") != null){
		
		Statement sm = null;
		ResultSet rs = null;
		
		String timestamp = (String) session.getAttribute("timeType");
		String oldformat = (String) session.getAttribute("format");
		String selectPeople = (String) session.getAttribute("selectPeople");
		String selectType = (String) session.getAttribute("selectType");
		String people = (String) session.getAttribute("people");
		String type = (String) session.getAttribute("type");
		
		String selectWeek = (String) session.getAttribute("selectWeek");
		String selectMonth = (String) session.getAttribute("selectMonth");
		String selectYear = (String) session.getAttribute("selectYear");
		String selectDate = (String) session.getAttribute("selectDate");
		
		String toWeek = (String) session.getAttribute("toWeek");
		String fromWeek = (String) session.getAttribute("fromWeek");
		
		String fromMonth = (String) session.getAttribute("fromMonth");
		String toMonth = (String) session.getAttribute("toMonth");
		
		String fromYear = (String) session.getAttribute("fYear");
		String toYear = (String) session.getAttribute("tYear");
		
		String fromDate = (String) session.getAttribute("fdate");
		String toDate = (String) session.getAttribute("tdate");
		
		String format = (String) request.getParameter("operation");
		
		String testdate = getTestdate(format);
		String label = (String) session.getAttribute("label");

		String with = "with fact_comb as (select i.image_id, patient_id, "
				+ "test_type,"
				+ " test_date, count(distinct(i.image_id)) as number_of_images"
				+ " from radiology_record r left join "
				+ " (select record_id, image_id from pacs_images) i "
				+ " on i.record_id = r.record_id"
				+ " group by cube(i.image_id, patient_id, test_type, "
				+ "test_date)) ";
		String select = " select ";		
		String from = " from fact_comb ";
		String where = "where ";
		String groupby = " group by ";
		
		/* array that records the selected columns */
		ArrayList<String> selectElements = new ArrayList<String>();
		
		/* Since default is to select the number of images, then we 
		 * know that count(distinct(image_id)) would definitely be
		 * in the select caluse 
		 */
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
				(NotEmpty(selectType))){

			select += ", test_type ";
			selectElements.add("Test Type");
			where = (where.length() > 6) ? where + " and " : where;
			groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
			groupby += "test_type";
			
			if(type != null){
				where += " test_type is not null";
			}else if(type == null && selectType != null
					&& !selectType.equals("NA")){				
				where += " test_type='" + selectType.trim() + "'";	
				where += " and test_type is not null";
			}
		}
		
		String olddate = "";
		String toOlddate = "";
		String fromOlddate = "";
		
		selectElements.add("Test Time");
		where = (where.length() > 6) ? where + " and " : where;
		groupby = (selectElements.size() > 2) ? groupby + ", " : groupby;
		
		if(oldformat.equals("YYYY-mm-W")){	
			
			if(timestamp.equals("exact") 
					&& format.equals("YYYY-mm")){
				olddate = session.getAttribute("selectYear") + "-" 
					+ session.getAttribute("selectMonth");
			}else if (timestamp.equals("period") 
					&& format.equals("YYYY-mm")){
				fromOlddate = session.getAttribute("fromYear") + "-"
					+ session.getAttribute("fromMonth");
				
				toOlddate = session.getAttribute("toYear") + "-"
					+ session.getAttribute("toMonth");
			}else if (timestamp.equals("exact") 
					&& format.equals("YYYY")){
				olddate = (String) session.getAttribute("selectYear");
			}else if (timestamp.equals("period")
					&& format.equals("YYYY")){
				fromOlddate = (String) session.getAttribute("fromYear");					
				toOlddate = (String) session.getAttribute("toYear");
			}
			
		}else if(oldformat.equals("YYYY-mm")){

			if(timestamp.equals("exact")){
				olddate = session.getAttribute("selectYear") + "-" 
						+ session.getAttribute("selectMonth");					
			}else{
				fromOlddate = session.getAttribute("fromYear") + "-"
						+ session.getAttribute("fromMonth");
				
				toOlddate = session.getAttribute("toYear") + "-"
						+ session.getAttribute("toMonth");
			}		
		}else if(oldformat.equals("YYYY")){

			if(timestamp.equals("exact")){
				olddate = (String) session.getAttribute("selectYear");			
			}else{
				fromOlddate = (String) session.getAttribute("fromYear");
				toOlddate = (String) session.getAttribute("toYear");
			}
			
		}else if(oldformat.equals("DD-MON-YYYY")){
			
			
			if(timestamp.equals("exact")){
				olddate = (String) session.getAttribute("selectDate");		
			}else{
				fromOlddate = (String) session.getAttribute("fromDate");		
				toOlddate = (String) session.getAttribute("toDate");
			}
			
		}	

		
		String direction = (oldformat.length() > format.length()) ? "up" : "down";
		
		select += "," + getTestdate(format);
		groupby += getTestdate(format);
		
		if(timestamp.equals("exact")){
			if(direction.equals("up") && !oldformat.equals("YYYY-mm-W")){
				where += getTestdate(format) + " = " 
					+ getHierTestdate(olddate, oldformat, format);
			}else if(direction.equals("up") && oldformat.equals("YYYY-mm-W")){
				where += getTestdate(format) + " = "
						+ "'" + olddate + "'";
			}else{
				where += getTestdate(oldformat) + " = " 
					+ "'" + olddate + "'";
			}
		}else {
			if(direction.equals("up") && !oldformat.equals("YYYY-mm-W")){
				if(label.equals("both")){
					where += getTestdate(format) + " >= " 
						+ getHierTestdate(fromOlddate, oldformat, format)
						+ " and " + getTestdate(format) + " < " 
						+ getHierTestdate(toOlddate, oldformat, format);
				}else if(label.equals("from")){
					where += getTestdate(format) + " >= " 
							+ getHierTestdate(fromOlddate, oldformat, format);
				}else if(label.equals("to")){
					where += getTestdate(format) + " < " 
							+ getHierTestdate(toOlddate, oldformat, format);
				}
			}else if(direction.equals("up") && oldformat.equals("YYYY-mm-W")){
				if(label.equals("both")){
					where += getTestdate(format) + " >= "
							+ "'" + fromOlddate + "'" +
							" and " + getTestdate(format) + " < "
							+ "'" + toOlddate + "'";
				}else if(label.equals("from")){
					where += getTestdate(format) + " >= "
							+ "'" + fromOlddate + "'";
				}else if(label.equals("to")){
					where +=  getTestdate(format) + " < "
							+ "'" + toOlddate + "'";
				}
			}else{
				if(label.equals("both")){
					where += getTestdate(oldformat) + " >= " 
						+ "'" + fromOlddate  + "'" + " and "
						+ getTestdate(oldformat) + " < " 
						+ "'" + toOlddate + "'";
				}else if(label.equals("from")){
					where += getTestdate(oldformat) + " >= " 
							+ "'" + fromOlddate  + "'" ;
				}else if(label.equals("to")){
					where += getTestdate(oldformat) + " < " 
							+ "'" + toOlddate + "'";
				}
			}
		}
	
		
		/* combine clauses together */
		String sql = with + select + from;

		/* Just in case the user simple wants the number of images, 
		 * namely, select nothing but "none of above", we do not 
		 * add where and group by clause
		 */
		sql = (where.length() > 6) ? sql + where: sql;
		sql = (groupby.length() > 10) ? sql + groupby : sql;
		
		/* try to get a connection to database */
		conn = getConnection();
		if(conn == null){
			JOptionPane.showMessageDialog(null, "Can't get a connection."
			+" Please try again.");
			return;
		}
		
		try{
			sm = conn.createStatement();
			rs = sm.executeQuery(sql);
		}catch(Exception ex){
			try{
				conn.close();
			}catch(Exception ex1){
				out.println("<hr>Error" + ex1.getMessage() + "<hr>");
			}
			out.println("<hr>Error: " + ex.getMessage() + "<hr>");
			return;
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
	
	

%>

</BODY>
</HTML>