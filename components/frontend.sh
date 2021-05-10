#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing Dependency"
sudo apt install nginx -y &>>$LOG
sudo apt-get install nodejs -y &>>$LOG
sudo apt install npm -y &>>$LOG
Stat $?

Head "Downloading COMPONENT"
cd /var/www/html && git clone https://github.com/swathi-zelarsoft680/frontend.git &>>$LOG && cd frontend

Head "Building the Code"
npm install &>>$LOG && npm run build &>>$LOG


Head "Moving Conf file"
mv frontend.conf /etc/nginx/sites-enabled/default
sed -i -e "s/LOGIN_ENDPOINT/login.swathi.host/" -e "s/TODO_ENDPOINT/todo.swathi.host/" /etc/nginx/sites-enabled/default
stat $?

Head "Exporting Ip's"
export AUTH_API_ADDRESS=http://login.swathi.host:8080
export TODOS_API_ADDRESS=http://todo.swathi.host:8080

Head "Restart nginx"
systemctl restart nginx
systemctl enable nginx


cd /var/www/html/frontend/
Head "Starting Npm Service"
npm start