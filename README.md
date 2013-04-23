check_TomcatApplication
=======================

Updated version from 
http://exchange.nagios.org/directory/Plugins/Java-Applications-and-Servers/Apache-Tomcat/check_TomcatApplication/details



./check_TomcatApplication.sh -u USER -p PASS -H HOST -P 8081 -a myapp
myapp_http-8081 OK:|http-8081_maxTime=260ms;;;0 http-8081_processingTime=5975ms;;;0 http-8081_requestCount=5673ms;;;0 http-8081_errorCount=2833ms;;;0 http-8081_bytesReceived=0ms;;;0 http-8081_bytesSent=12587609ms;;;0
myapp_jk-8010 OK:|jk-8010_maxTime=66555ms;;;0 jk-8010_processingTime=3513131ms;;;0 jk-8010_requestCount=14938ms;;;0 jk-8010_errorCount=2ms;;;0 jk-8010_bytesReceived=0ms;;;0 jk-8010_bytesSent=111861255ms;;;0


The output is as above and this should now produce graphs 
