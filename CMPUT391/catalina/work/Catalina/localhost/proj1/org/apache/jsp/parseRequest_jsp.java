package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;

public final class parseRequest_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\n');
      out.write('\n');
      out.write('\n');

  //Initialization for chunk management.
  boolean bLastChunk = false;
  int numChunk = 0;

  response.setContentType("text/plain");
  try{
    // Get URL Parameters.
    Enumeration paraNames = request.getParameterNames();
    out.println(" ------------------------------ ");
    String pname;
    String pvalue;
    while (paraNames.hasMoreElements()) {
      pname = (String)paraNames.nextElement();
      pvalue = request.getParameter(pname);
      out.println(pname + " = " + pvalue);
      if (pname.equals("jufinal")) {
      	bLastChunk = pvalue.equals("1");
      } else if (pname.equals("jupart")) {
      	numChunk = Integer.parseInt(pvalue);
      }
    }
    out.println(" ------------------------------ ");

    // Directory to store all the uploaded files

    int ourMaxMemorySize  = 10000000;
    int ourMaxRequestSize = 2000000000;

	///////////////////////////////////////////////////////////////////////////////////////////////////////
	//The code below is directly taken from the jakarta fileupload common classes
	//All informations, and download, available here : http://jakarta.apache.org/commons/fileupload/
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Create a factory for disk-based file items
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	// Set factory constraints
	factory.setSizeThreshold(ourMaxMemorySize);
	factory.setRepository(new File(ourTempDirectory));
	
	// Create a new file upload handler
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	// Set overall request size constraint
	upload.setSizeMax(ourMaxRequestSize);
	
	// Parse the request
	List /* FileItem */ items = upload.parseRequest(request);
	// Process the uploaded items
	Iterator iter = items.iterator();
	FileItem fileItem;
    	File fout;
    	out.println(" Let's read input files ...");
	while (iter.hasNext()) {
	    fileItem = (FileItem) iter.next();
	
	    if (fileItem.isFormField()) {
	        //This should not occur, in this example.
	        out.println(" ------------------------------ ");
	        out.println(fileItem.getFieldName() + " = " + fileItem.getString());
	    } else {
	        //Ok, we've got a file. Let's process it.
	        //Again, for all informations of what is exactly a FileItem, please
	        //have a look to http://jakarta.apache.org/commons/fileupload/
	        //


	        out.println(" ------------------------------ ");
	        out.println("FieldName: " + fileItem.getFieldName());
	        out.println("File Name: " + fileItem.getName());
	        out.println("ContentType: " + fileItem.getContentType());
	        out.println("Size (Bytes): " + fileItem.getSize());


/*
	        //If we are in chunk mode, we add ".partN" at the end of the file, where N is the chunk number.
	        String uploadedFilename = fileItem.getName() + ( numChunk>0 ? ".part"+numChunk : "") ;
	        fout = new File(ourTempDirectory + (new File(uploadedFilename)).getName());
	        out.println("File Out: " + fout.toString());
	        // write the file
	        fileItem.write(fout);	        
	        
	        //////////////////////////////////////////////////////////////////////////////////////
	        //Chunk management: if it was the last chunk, let's recover the complete file
	        //by concatenating all chunk parts.
	        //
	        if (bLastChunk) {	        
		        out.println(" Last chunk received: let's rebuild the complete file (" + fileItem.getName() + ")");
		        //First: construct the final filename.
		        FileInputStream fis;
		        FileOutputStream fos = new FileOutputStream(ourTempDirectory + fileItem.getName());
		        int nbBytes;
		        byte[] byteBuff = new byte[1024];
		        String filename;
		        for (int i=1; i<=numChunk; i+=1) {
		        	filename = fileItem.getName() + ".part" + i;
		        	out.println("  Concatenating " + filename);
		        	fis = new FileInputStream(ourTempDirectory + filename);
		        	while ( (nbBytes = fis.read(byteBuff)) >= 0) {
		        		out.println("     Nb bytes read: " + nbBytes);
		        		fos.write(byteBuff, 0, nbBytes);
		        	}
		        	fis.close();
		        }
		        fos.close();

*/
	        }
	        // End of chunk management
	        //////////////////////////////////////////////////////////////////////////////////////
	        
	        fileItem.delete();
	    }
	    out.println("SUCCESS");
	}//while
  }catch(Exception e){
    out.println("Exception e = " + e.toString());
  }
  
  out.close();

    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
