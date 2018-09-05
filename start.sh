#!/bin/bash

if [ ! -z "$PASSWD" ]; then \
  sed -i -e "s/password=\"\([^\"]*\)\"/password=\"${PASSWD}\"/g" $CATALINA_HOME/conf/tomcat-users.xml; \
fi

exec "$@"
