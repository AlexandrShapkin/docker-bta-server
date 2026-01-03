FROM eclipse-temurin:8-jre

WORKDIR /opt/minecraft

ARG BTA_VERSION

ENV JAVA_OPTS="-Xms512M -Xmx2G"

RUN curl -fsSL \
  -o /opt/minecraft/server.jar \
  https://github.com/Better-than-Adventure/bta-download-repo/releases/download/${BTA_VERSION}/bta.${BTA_VERSION}.server.jar

COPY server.properties.template .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

VOLUME /data

ENTRYPOINT ["/opt/minecraft/entrypoint.sh"]
