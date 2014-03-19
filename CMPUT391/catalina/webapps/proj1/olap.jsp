<HTML>
<HEAD>
<TITLE>OLAP: Data Analysis Module</TITLE>
</HEAD>

<BODY>
<% page import="java.sql.*,
   javax.portlet.ActionResponse.*,
   javax.swing.*,
   java.util.*,
   java.text.*" %>
<%
        Integer person_id = (Integer) session.getAttribtue("Person_Id");
        String role = (String) session.getAttribute("PermissionLevel");
        
        if(person_id == null || !role.equals("a")){
                     response.sendRedirect("login.jsp");
        }

%>
</BODY>
</HTML>