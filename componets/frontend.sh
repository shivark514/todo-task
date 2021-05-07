#!/bin/bash
source componets/common.sh

OS_PREREQ
Head "Set hostname & update repo"
REPEAT

Head "Install Nginx"
apt install nginx -y >>"${LOG}"
Head "Start Nginx"
systemctl start nginx
Head "Install Node & Nginx"
NPM
STAT $?

Head "Change directory and make vue directory and switch to vue directory"
cd /var/www/html && mkdir vue &&
cd vue || exit
STAT $?

Head "Clone code from Github"
git clone https://github.com/zelar-soft-todoapp/frontend.git &>>$LOG && cd frontend
STAT $?

Head "Install Npm"
npm install >>"${LOG}"
STAT $?

Head "Run build"
npm run build >>"${LOG}"
Killall node >>"${LOG}"
npm run build
STAT $?

Head "Change root path in nginx"
cd /etc/nginx/sites-available || exit
vi default
STAT $?

Head "Update index.js file with todo app & login ip"
cd /var/www/html/vue/frontend &&
cd config || exit
vi index.js
STAT $?

Head "Restart Nginx"
systemctl restart nginx
STAT $

Head "run Npm Service"
npm start
STAT $?
