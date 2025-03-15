#!/bin/bash
yum update -y >> /var/log/user-data.log 2>&1
yum upgrade -y >> /var/log/user-data.log 2>&1
yum install -y docker >> /var/log/user-data.log 2>&1
systemctl enable docker >> /var/log/user-data.log 2>&1
systemctl start docker >> /var/log/user-data.log 2>&1
sleep 10
docker run --name mynginx1 -p 80:80 -d nginx >> /var/log/user-data.log 2>&1