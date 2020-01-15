FROM rdlabengpa/execution_core_container_bl:v1.0.1
RUN apk add --no-cache bash
COPY ./wait-for-it/wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh
ENTRYPOINT ["/bin/sh","-c","/app/wait-for-it.sh execution_core_container_core:9091 --strict -- java -Djava.security.egd=file:/dev/./urandom -jar /market4.0-execution_core_container_business_logic.jar"]
