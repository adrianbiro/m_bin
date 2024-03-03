#!/bin/bash

ENV_PROPS="$(cut -d "-" -f2 <<<"${1}")"
HEAPDUMP="/app/log/${HOSTNAME}-$(date +"%Y:%m:%d-%H:%M:%S").hprof"

function _chmod() {
    if [[ -f "${HEAPDUMP}" ]]; then
        chmod 644 "${HEAPDUMP}"
    fi
}

trap "_chmod" EXIT

cp -r "config/${ENV_PROPS}/configuration/" configuration/

java -cp postgresql.jar:ojdbc8.jar:tomcat-dbcp.jar:smart-webapp-runner.jar -Dpodname="${HOSTNAME}" -Dpath.app=/app -Dpath.log=/app/log -Dwar.name="${2}" -Dlog4j.configuration=file:/app/configuration/openshift-log4j.xml -Djavax.servlet.request.encoding=UTF-8 -Dfile.encoding=UTF-8 -agentlib:jdwp=transport=dt_socket,server=y,address=8000,suspend=n -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=3000 -Dcom.sun.management.jmxremote.rmi.port=3001 -Djava.rmi.server.hostname=127.0.0.1 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath="${HEAPDUMP}" -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=4 cz.csas.smart.runner.Main "${2}.war" --path "/${2}" --temp-directory /tmp/tomcat