check_TomcatApplication
=======================

Updated version from 
http://exchange.nagios.org/directory/Plugins/Java-Applications-and-Servers/Apache-Tomcat/check_TomcatApplication/details



./check_TomcatApplication.sh -u USER -p PASS -H HOST -P 8081 -a myapp


myapp_JVM_OK:|myapp_JVM_free=263281744MB;;;0 myapp_JVM_total=1063714816MB;;;0 myapp_JVM_max=1063714816MB;;;0


myapp_http-8081 OK:|http-8081_maxTime=260ms;;;0 http-8081_processingTime=6108ms;;;0 http-8081_requestCount=5857ms;;;0 http-8081_errorCount=2925ms;;;0 http-8081_bytesReceived=0ms;;;0 http-8081_bytesSent=12998001ms;;;0


myapp_jk-8010 OK:|jk-8010_maxTime=66555ms;;;0 jk-8010_processingTime=3570368ms;;;0 jk-8010_requestCount=15171ms;;;0 jk-8010_errorCount=2ms;;;0 jk-8010_bytesReceived=0ms;;;0 jk-8010_bytesSent=113444017ms;;;0


The output is as above and this should now produce graphs for each port as well as memory usage
