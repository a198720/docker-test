FROM openjdk:8

ENV JAVA_OPTS -Xms256m -Xmx4096m
ADD *.jar /app.jar
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
EXPOSE 8761
ENTRYPOINT ["bin/bash","docker-entrypoint.sh"]
