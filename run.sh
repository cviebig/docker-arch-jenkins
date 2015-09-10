#!/bin/sh
export PORT=4243
wrapdocker &
if [ -d "/root/config-ssh" ]; then
    cp -R /root/config-ssh /var/lib/jenkins/.ssh
    chown -R jenkins:jenkins /var/lib/jenkins/.ssh
fi
chown -R jenkins:jenkins /var/lib/jenkins/.jenkins/jobs
chmod -R 750 /var/lib/jenkins/.jenkins/jobs
su -c "sh updatejobs.sh" - jenkins
su -c "java -jar /usr/share/java/jenkins/jenkins.war \"$@\"" - jenkins
