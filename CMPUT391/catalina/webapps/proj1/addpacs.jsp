<html>
<head> 
<title>Create a New Radiology Record</title> 
</head>
<body> 



<p>
<hr>
Please input or select the path of the image!
<form name="upload-image" method="POST" enctype="multipart/form-data" action="servlet/UploadImage">
<table>
  <tr>
    <th>File path: </th>
    <td><input name="file-path" type="file" size="30" ></input></td>
  </tr>
  <tr>
    <td ALIGN=CENTER COLSPAN="2"><input type="submit" name=".submit" 
     value="Upload"></td>
  </tr>
</table>
</form>
</body> 
</html>
