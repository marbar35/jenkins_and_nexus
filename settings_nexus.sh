#!/bin/bash

PASSWORD="$(docker exec nexus head -n 1 /nexus-data/admin.password)"
URL="http://127.0.0.1:8081/service/rest/v1"
#задайте пароль в переменную PASSWORDNEW для пользователя admin
PASSWORDNEW="admin"
USERNAME="admin"

curl -X PUT "$URL/security/users/admin/change-password" -u "$USERNAME:$PASSWORD" -H "Content-Type: text/plain" -d "$PASSWORDNEW"
if [ $? -eq 0 ]
then
  echo "***************************************************перволначальный пароль для пользователя admin изменен*****************************"
else
  echo "**************************************************первоначальный пароль для пользователя admin НЕ изменен*****************************"
fi


curl -u "$USERNAME:$PASSWORDNEW" -X PUT "${URL}/security/anonymous" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"enabled\": true, \"userId\": \"anonymous\", \"realmName\": \"NexusAuthorizingRealm\"}"
if [ $? -eq 0 ]
then
  echo "***************************************анонимный доступп разрешен**************************************************************"
else
  echo "**************************************анонимный доступ НЕ разрешен*************************************************************"
fi


curl -u "$USERNAME:$PASSWORDNEW" -X POST "${URL}/repositories/docker/hosted" -H 'accept: application/json' -H 'Content-Type: application/json' -d '{
    "name": "jenkins-repo",
    "url": "http://127.0.0.1:8081/repository/for-docker",
    "online": true,
    "storage": {
        "blobStoreName": "default",
        "strictContentTypeValidation": true,
        "writePolicy": "ALLOW"
    },
    "cleanup": null,
    "docker": {
        "v1Enabled": true,
        "forceBasicAuth": false,
        "httpPort": 8085,
        "httpsPort": null
    },
    "negativeCache": {
        "enabled": true,
        "timeToLive": 1440
    },
    "httpClient": {
        "blocked": false,
        "autoBlock": true,
        "connection": {
            "retries": null,
            "userAgentSuffix": null,
            "timeout": null,
            "enableCircularRedirects": false,
            "enableCookies": false,
            "useTrustStore": false
        },
        "authentication": null
    },
    "format": "docker"
}'

if [ $? -eq 0 ]
then
  echo "***************************************репозиторий docker создан**************************************************************"
else
  echo "Провал*********************************репозиторий docker НЕ создан**************************************************************"
fi


    curl -u "$USERNAME:$PASSWORDNEW" -X 'POST' \
        "${URL}/repositories/docker/group" \
        -H 'accept: application/json' \
        -H 'Content-Type: application/json' \
        -d '{
    "name": "docker-group",
    "url": "http://localhost:8081/repository/docker-group",
    "online": true,
    "storage": {
        "blobStoreName": "default",
        "strictContentTypeValidation": false
    },
    "group": {
        "memberNames": [
            "docker-hub",
            "docker-ecrpublic"
        ]
    },
    "docker": {
        "v1Enabled": false,
        "forceBasicAuth": false,
        "httpPort": 8082,
        "httpsPort": null
    },
    "format": "docker",
    "type": "group"
}'

if [ $? -eq 0 ]
then
  echo "***************************************группа docker создана**************************************************************"
else
  echo "Провал*********************************группа docker НЕ создана**************************************************************"
fi


    curl -u "$USERNAME:$PASSWORDNEW" -X 'POST' \
        "${URL}/security/users" \
        -H 'accept: application/json' \
        -H 'Content-Type: application/json' \
        -d '{
  "userId" : "jenkins",
  "firstName" : "jenkins",
  "lastName" : "jenkins",
  "emailAddress" : "jenkins@domain.com",
  "password" : "jenkins",
  "status" : "active",
  "roles" : [ "nx-admin" ]
}'


if [ $? -eq 0 ]
then
  echo "***************************************пользователь docker создан**************************************************************"
else
  echo "Провал*********************************пользователь docker НЕ создан**************************************************************"
fi
