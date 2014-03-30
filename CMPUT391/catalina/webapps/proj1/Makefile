JCC = javac

default: GetOnePic.class GetBigPic.class UploadImage.class

GetOnePic.class: ./WEB-INF/classes/GetOnePic.java
	$(JCC) ./WEB-INF/classes/GetOnePic.java
GetBigPic.class: ./WEB-INF/classes/GetBigPic.java
	$(JCC) ./WEB-INF/classes/GetBigPic.java
UploadImage.class: ./WEB-INF/classes/UploadImage.java
	$(JCC) ./WEB-INF/classes/UploadImage.java


clean: 
	rm -f *.class

