#!/bin/bash

PASSWORD=$(cat /var/jenkins_home/secrets/initialAdminPassword)
#docker exec jenkins java -jar /var/jenkins_home/jenkins-cli.jar -auth 1:1 -s http://127.0.0.1:8080/ install-plugin -f {{

docker exec jenkins java -jar /var/jenkins_home/jenkins-cli.jar -s http://127.0.0.1:8080/ -password $PASSWORD 

# Create new user
#java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ create-user <username> <password>
#
# Disconnect from Jenkins
#java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ logout
