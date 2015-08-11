#!/bin/bash
# script for deploying war files to tomcat

echo "Hello World!"

if [ "$#" -ne 6 ]; then
  
   	echo "Incorrect number of arguments."
	echo "Usage example: ./tomcat-deploy.sh -warpath /path/to/war -tomcatdirectory /path/to/tomcat/install -warname name.war"
	echo "Arguments"
	echo "Usage:-w or -warpath "
	echo "		The warpath argument is required.  This should be the full path to the war file that needs to be deployed to the tomcat webapps directory."
	echo "Usage: -t or -tomcatdirectory "
	echo "		The tomcatdirectory argument is required.  This should be the full path to the tomcat webapps directory."
 	echo "Usage: -wn or --warname "
	echo "The warname argument is required.  This should be the full name of the war file that needs to be deployed."

	exit 1
fi



    WARPATH="$2"
    TOMCATPATH="$4"
    WARNAME="$6"
 


set -- "$WARNAME" 
IFS="."; declare -a Array=($*) 
echo "${Array[@]}" 
echo "${Array[0]}" 
echo "${Array[1]}" 
DELETEFILE="${Array[0]}*"
FULLWARFILE="$WARPATH$WARNAME"
echo "$WARPATH and $TOMCATPATH and $WARNAME"
IFS="";

cd $WARPATH
cd ..
mvn clean install
echo "$TOMCATPATH"
#cd /Users/Matt/Documents/Servers/apache-tomcat-7.0.57/logs
cd $TOMCATPATH
./../bin/shutdown.sh
rm -rf $DELETEFILE
cp $FULLWARFILE  .
./../bin/startup.sh
