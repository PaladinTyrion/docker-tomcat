FROM tomcat:7-jre8-alpine
MAINTAINER paladintyrion<paladintyrion@gmail.com>

ENV CATALINA_HOME /usr/local/tomcat
WORKDIR $CATALINA_HOME

COPY ./start.sh $CATALINA_HOME/bin/start.sh

RUN set -ex \
    && apk update \
    && apk add --no-cache tzdata bash \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && mkdir -p /data1/base/tomcat/logs \
    && user_conf='  <role rolename="manager"/> \
  <role rolename="tomcat"/> \
  <role rolename="admin"/> \
  <role rolename="role1"/> \
  <user username="both" password="tomcat" roles="tomcat,role1"/> \
  <user username="tomcat" password="tomcat" roles="tomcat"/> \
  <user username="admin" password="admin" roles="manager,admin,manager-gui,manager-script,manager-status,manager-jmx"/> \
  <user username="role1" password="tomcat" roles="role1"/> \
</tomcat-users>' \
    && mkdir /logs \
    && sed -i -e '1,/directory="logs"/{s#directory="logs"#directory="/logs"#}' $CATALINA_HOME/conf/server.xml \
    && sed -i -e "/<\/tomcat-users>/d" $CATALINA_HOME/conf/tomcat-users.xml \
    && echo "$user_conf" >> $CATALINA_HOME/conf/tomcat-users.xml \
    && sed -i -e 2'i\JAVA_OPTS="-server -Xms${Xms:-4096m} -Xmx${Xmx:-10240m} -XX:PermSize=${PermSize:-256M} -XX:MaxPermSize=${MaxPermSize:-512M}"' $CATALINA_HOME/bin/catalina.sh \
    && chmod +x $CATALINA_HOME/bin/start.sh

EXPOSE 8080 80

ENTRYPOINT ["/usr/local/tomcat/bin/start.sh"]
CMD ["catalina.sh", "run"]
