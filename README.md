docker run -d -p 47095:8080 -e Xms=1024m -e Xmx=2048m -e PermSize=128M -e MaxPermSize=256M --privileged -v /data0/tomcat/logs:/logs --name=tomcat --restart always paladintyrion/tomcat:7-jre8-alpine
