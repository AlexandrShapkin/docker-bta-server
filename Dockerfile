FROM eclipse-temurin:8-jre

WORKDIR /opt/minecraft

ARG BTA_VERSION
ENV BTA_VERSION=${BTA_VERSION}
ENV JAVA_OPTS="-Xms512M -Xmx2G"

COPY entrypoint.sh /entrypoint.sh
COPY server.properties.template /opt/minecraft/server.properties.template

RUN chmod +x /entrypoint.sh

VOLUME /data

ENTRYPOINT ["/entrypoint.sh"]
