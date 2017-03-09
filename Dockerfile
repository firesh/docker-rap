FROM tomcat:8.5-jre8-alpine

MAINTAINER wangshaobo <wangshaobo@me.com>

ENV TIMEZONE "Asia/Shanghai"

RUN apk add --no-cache tzdata &&\
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
	echo $TIMEZONE >  /etc/timezone &&\
	apk del tzdata

RUN rm -rf ${CATALINA_HOME}/webapps/ \
  && mkdir -p ${CATALINA_HOME}/webapps/ROOT \
  && wget -O /tmp/RAP.war http://rap.taobao.org/release/RAP-0.14.1-SNAPSHOT.war \
  && unzip /tmp/RAP.war -d ${CATALINA_HOME}/webapps/ROOT

ADD ./run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 8080
CMD ["run"]
