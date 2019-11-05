# Execution Core Container

Execution Core Container for Market4.0 project based on the IDS Base Connector. <br/>


![Execution Core Container Architecture](connector_schema_v1.1.PNG?raw=true "Execution Core Container Architecture")

## How to Configurate and Run

The configuration should be performed customizing the following variables in the **docker-compose** file:
* **DATA_APP_SSL_CERT_FILE=/cert/ssl-server.jks** relative path for the DataAPP self-signed certificate, CN of the certificate should be equal to the IP/hostname server address (communication will be established only over https)
* **DATA_APP_SSL_CERT_PWD=changeit** password of the certificate
* **DATA_APP_ENDPOINT=192.168.56.1:8083/incoming-data-app/dataAppIncomingMessageReceiver** DataAPP endpoint for receiveing data (F endpoint in the above picture)
* Edit external port if need (default values: **8090 http** and **8450 https**)

Moreover, DAPS Server should be configured (tested using Fraunhofer AISEC DAPS Server): 
* Put **DAPS certificates** into the cert folder and edit related settings (i.e., *application.keyStoreName*, *application.keyStorePassword*) into the *resources/application.properties* file

Finally, run the application:

*  Execute `docker-compose up &`

<br/>

## Endpoints
The Execution Core Container will use two ports (http and https) as described by the Docker Compose File.<br/>
It will expose the following endpoints (both over https):
```
* /incoming-data-app/MultipartMessage to receive data (MultiPartMessage) from Data App (the A endpoint in the above picture)
* /incoming-data-channel/receivedMessage to receive data (IDS Message) from a sender connector (the B endpoint in the above picture)
```
Furthermore, just for testing it will expose (http and https):
```
* /about/version returns business logic version 
```


## Configuration


## How to Test
The reachability could be verified using the following endpoints:
*  **http://{IP_ADDRESS}:{PORT}/about/version**
*  **https://{IP_ADDRESS}:{HTTPS_PORT}/about/version**


The sender DataApp should send a request using the following schema, specifing in the Forward-To header the destination connector URL:
```
curl -X POST \
  http://{IPADDRESS}:{HTTPS_PORT}/incoming-data-app/MultipartMessage \ 
  -H 'Accept: */*' \
  -H 'Content-Type: multipart/mixed; boundary=CQWZRdCCXr5aIuonjmRXF-QzcZ2Kyi4Dkn6;charset=UTF-8' \
  -H 'Forward-To: https://{RECEIVER_IP_ADDRESS}:{HTTPS_PORT}/incoming-data-channel/receivedMessage' \
  -D 'MULTIPART MESSAGE DATA' 
 
```
An example of Multipart Message data (aligned to the IDS Information Model) can be found in the examples folder.

The receiver connector will receive the request to the specified "*Forward-To*" URL, process data and finally send data to the *DATA_APP_ENDPOINT* as specificed in its docker-compose.



