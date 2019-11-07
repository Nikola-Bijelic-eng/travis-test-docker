FROM ubuntu:trusty
 
RUN apt-get update && apt-get install -yq curl && apt-get clean
 
WORKDIR /app
 
ADD test.sh /app/run.sh
 
CMD ["bash", "run.sh"]