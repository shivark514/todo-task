#!/bin/bash
source componets/common.sh

OS_PREREQ

Head "Install Nginx"
apt install nginx -y &>>${LOG}
Head "Start Nginx"
systemctl start nginx
Head "Install Nodejs"
apt-get npm install nodejs -y &>>${LOG}

Head "Install Npm"
apt npm install &>>${LOG}
Stat $?

Head "Change directory and make vue directory and switch to vue directory"
cd /var/www/html && mkdir vue &&
cd vue || exit
Stat $?

Head "Clone code from Github"
git clone https://github.com/zelar-soft-todoapp/frontend.git &>>$LOG && cd frontend
Stat $?

Head "Run build"
npm install &>>$LOG && npm run build &>>$LOG
Stat $?

Head "Change root path in nginx"
cd /etc/nginx/sites-available || exit
vi default
Stat $?

Head "Update index.js file with todo app & login ip"
cd /var/www/html/vue/frontend &&
cd config || exit
vi index.js
Stat $?

Head "Restart Nginx"
systemctl restart nginx
Stat $

Head "run Npm Service"
npm start
Stat $?
