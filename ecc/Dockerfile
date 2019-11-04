FROM openjdk:8-jre-alpine

# set activemq version
ENV ACTIVEMQ_VERSION 5.14.3
# set camel version
ENV CAMEL_VERSION 2.16.3

# install some packages
# 1. update index (same as apt-get update on debian)
# 2. install new packages
# 3. clean up index
RUN apk update \
  && apk add rsync \
  && rm -rf /var/cache/akp/*    

WORKDIR /opt

# install activemq
RUN set -e \
  && wget -O - http://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz \
  | tar -xz \
  && mv /opt/apache-activemq-${ACTIVEMQ_VERSION} /opt/activemq-02 \
  && wget https://repo1.maven.org/maven2/org/apache/camel/camel-http/${CAMEL_VERSION}/camel-http-${CAMEL_VERSION}.jar \
  && mv camel-http-${CAMEL_VERSION}.jar /opt/activemq-02/lib/camel/camel-http-${CAMEL_VERSION}.jar \
  && wget https://repo1.maven.org/maven2/org/apache/camel/camel-http-common/${CAMEL_VERSION}/camel-http-common-${CAMEL_VERSION}.jar \
  && mv camel-http-common-${CAMEL_VERSION}.jar /opt/activemq-02/lib/camel/camel-http-common-${CAMEL_VERSION}.jar \
  && wget https://repo1.maven.org/maven2/commons-httpclient/commons-httpclient/3.1/commons-httpclient-3.1.jar \
  && mv commons-httpclient-3.1.jar /opt/activemq-02/lib/optional/commons-httpclient-3.1.jar \
  && cp -R /opt/activemq-02 /opt/.activemq-02_bak

# run.sh copies mounted activemq files and starts activemq
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

VOLUME /execution-core-container-02
VOLUME /opt/activemq-02/data

WORKDIR /opt/activemq-02
ENTRYPOINT ["/app/run.sh"]