#!/bin/sh
set -eu

PORT_VALUE="${PORT:-8080}"

sed -i -E "0,/Connector port=\"[0-9]+\" protocol=\"HTTP\/1\.1\"/{s//Connector port=\"${PORT_VALUE}\" protocol=\"HTTP\/1.1\"/}" /usr/local/tomcat/conf/server.xml

echo "Starting Tomcat on port ${PORT_VALUE}"
exec catalina.sh run
