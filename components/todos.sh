!/bin/bash

source components/common.sh
OS_PREREQ


Head "Installing Dependency"
sudo apt install npm -y &>>$LOG
stat $?

Head "Downloading COMPONENT"
cd /root/
git clone https://github.com/swathi-zelarsoft680/todo.git &>>$LOG && cd todo && rm -rf /etc/systemd/system/todo.service && mv systemd.service /etc/systemd/system/todo.service
sed -i -e "s/REDIS_ENDPOINT/redis.swathi.host/" /etc/systemd/system/todo.service
stat $?

Head "Buliding the code"
npm install &>>$LOG && npm run build &>>$LOG
stat $?

Head "Starting the service"
systemctl daemon-reload &>>$LOG && systemctl start todo && systemctl enable todo &>>$LOG
systemctl status todo
