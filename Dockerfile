FROM eclipse-temurin:8-jre

WORKDIR /opt/minecraft

ARG BTA_VERSION
ENV BTA_VERSION=${BTA_VERSION}

ENV JAVA_OPTS="-Xms512M -Xmx2G"

COPY server.properties.template .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

VOLUME /opt/minecraft

ENTRYPOINT ["/opt/minecraft/entrypoint.sh"]
