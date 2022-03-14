#!/bin/bash

sudo mkdir -p /data_test && sudo mkfs -t xfs /dev/sdf && sudo mount /dev/sdf /data_test

#Install Packages

sudo yum -y install docker; \
 sudo service docker start; \
 sudo usermod -a -G docker ec2-user; \
 sudo chkconfig docker on; \
 sudo curl -L --fail https://raw.githubusercontent.com/linuxserver/docker-docker-compose/master/run.sh -o /usr/local/bin/docker-compose; \
 sudo chmod +x /usr/local/bin/docker-compose

#UP Apache

# aws s3 cp s3://state-lib/webserver/ /home/ec2-user/webserver --recursive && cd /home/ec2-user/webserver && docker-compose up -d 


