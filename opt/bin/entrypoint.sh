#!/bin/bash
TOMCAT_ADMIN_USER=${TOMCAT_ADMIN_USER:-admin}
TOMCAT_ADMIN_PASSWORD=${TOMCAT_ADMIN_PASSWORD:-tomcat}
MAX_UPLOAD_SIZE=${MAX_UPLOAD_SIZE:-52428800}
CATALINA_OPTS=${CATALINA_OPTS:-"-Xms128m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=256m"}

echo "Setting Catalina env variables"
export CATALINA_OPTS="${CATALINA_OPTS}"

if [ -f "${TOMCAT_HOME}/webapps/manager/WEB-INF/web.xml" ]
then
    echo "Fixing manager web.xml file upload restrictions"
	sed -i "s#.*max-file-size.*#\t<max-file-size>${MAX_UPLOAD_SIZE}</max-file-size>#g" ${TOMCAT_HOME}/webapps/manager/WEB-INF/web.xml
	sed -i "s#.*max-request-size.*#\t<max-request-size>${MAX_UPLOAD_SIZE}</max-request-size>#g" ${TOMCAT_HOME}/webapps/manager/WEB-INF/web.xml
fi

if [ -f "${TOMCAT_HOME}/webapps/conf/tomcat-users.xml" ]
then
    sed -i -e "s/@@TOMCAT_ADMIN_USER@@/${TOMCAT_ADMIN_USER}/" ${TOMCAT_HOME}/conf/tomcat-users.xml
    sed -i -e "s/@@TOMCAT_ADMIN_PASSWORD@@/${TOMCAT_ADMIN_PASSWORD}/" ${TOMCAT_HOME}/conf/tomcat-users.xml
fi

echo "Running Tomcat"
${TOMCAT_HOME}/bin/catalina.sh run
