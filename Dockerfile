#
# Dockerfile for Debian + Tomcat Server
#

FROM sismics/debian-java:7.79.1
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Download and install Tomcat
ENV DEBIAN_FRONTEND noninteractive
ENV TOMCAT_VERSION 7.0.53
ENV TOMCAT_HOME /opt/tomcat
RUN mkdir -p $TOMCAT_HOME && \
    curl -SL http://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
	| tar xz --strip-components=1 --directory=/opt/tomcat

# Add Tomcat user
RUN useradd tomcat -U -s /bin/false \
    && chown -R tomcat:tomcat ${TOMCAT_HOME}

# Clean Tomcat
RUN rm -rf ${TOMCAT_HOME}/webapps/* \
    && mkdir -p ${TOMCAT_HOME}/conf/Catalina/localhost

COPY opt /opt
WORKDIR /opt/tomcat
EXPOSE 8080

CMD ["/opt/bin/entrypoint.sh"]
