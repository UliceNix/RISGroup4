JCC = javac

default: GetOnePic.class UploadImage.class

GetOnePic.class: ./WEB-INF/classes/GetOnePic.java
	$(JCC) ./WEB-INF/classes/GetOnePic.java

UploadImage.class: ./WEB-INF/classes/UploadImage.java
	$(JCC) ./WEB-INF/classes/UploadImage.java


clean: 
	rm -f *.class

