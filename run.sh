#!/bin/sh
export PORT=4243
wrapdocker &
rm -rf /var/lib/jenkins/.ssh
if [ -d "/root/config-ssh" ]; then
    cp -R /root/config-ssh /var/lib/jenkins/.ssh
    chown -R jenkins:jenkins /var/lib/jenkins/.ssh
fi
su -c "sh updatejobs.sh" - jenkins
su -c "java -jar /usr/share/java/jenkins/jenkins.war \"$@\"" - jenkins
