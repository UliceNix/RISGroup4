<html>
<head> 
<title>Upload Medical Images</title> 
</head>
<body> 

<%@ page import="java.sql.*,javax.portlet.ActionResponse.*, javax.swing.*, java.util.*, java.lang.*, java.io.*, java.text.*, java.net.*" %>
<% 
String node = InetAddress.getLocalHost().getHostName();
String URL = "http://" + node +".cs.ualberta.ca:16500/proj1/parseRequest.jsp?URLParam=URL+Parameter+Value";

out.println("<applet code='applet-basic_files/wjhk.JUploadApplet' name='JUpload' archive='applet-basic_files/wjhk.jar' mayscript='' height='300' width='640'>");

out.println("<param name='CODE' value='wjhk.jupload2.JUploadApplet'>");
out.println("<param name='ARCHIVE' value='wjhk.jupload.jar'>");
out.println("<param name='type' value='application/x-java-applet;version=1.4'>");
out.println("<param name='scriptable' value='false'>");    
out.println("<param name='postURL'value='" + URL + "'>");
out.println("<param name='nbFilesPerRequest' value='2'>");    
out.println("</applet>");

%>


</form>
</body> 
</html>
