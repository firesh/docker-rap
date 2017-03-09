#!/bin/sh
ROOT_DEF_CONFIG_PATH="${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes/_config.properties"
ROOT_CONFIG_PATH="${CATALINA_HOME}/webapps/ROOT/WEB-INF/classes/config.properties"

cp ${ROOT_CONFIG_PATH} ${ROOT_DEF_CONFIG_PATH}

sed -e "s/mysql\\\:\/\/localhost\\\:3306\/rap_db/mysql\\\:\/\/${MYSQL_PORT_3306_TCP_ADDR:-localhost}\\\:${MYSQL_PORT_3306_TCP_PORT:-3306}\/${MYSQL_DB_NAME:-rap_db}/g" ${ROOT_DEF_CONFIG_PATH} > ${ROOT_CONFIG_PATH}
sed -i -e "s/jdbc\.username\=root/jdbc\.username\=${MYSQL_USERNAME:-root}/g" ${ROOT_CONFIG_PATH}
sed -i -e "s/jdbc\.password\=/jdbc\.password\=${MYSQL_PASSWORD}/g" ${ROOT_CONFIG_PATH}
sed -i -e "s/redis\.host\=localhost/redis\.host\=${REDIS_PORT_6379_TCP_ADDR:-localhost}/g" ${ROOT_CONFIG_PATH}
sed -i -e "s/redis\.port\=6379/redis\.port\=${REDIS_PORT_6379_TCP_PORT:-6379}/g" ${ROOT_CONFIG_PATH}

/bin/sh -e ${CATALINA_HOME}/bin/catalina.sh run
