FROM delucagabriele/execution_core_container_bl:latest
RUN apk add --no-cache bash
COPY ./wait-for-it/test.sh /app/test.sh
RUN chmod +x /app/test.sh
ENTRYPOINT ["/bin/sh","-c","/app/wait-for-it.sh execution_core_container_core:9091 -t 30 --strict -- java -Djava.security.egd=file:/dev/./urandom -jar /market4.0-execution_core_container_business_logic.jar"]
