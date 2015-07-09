#!/bin/sh
wrapdocker &
chown -R jenkins:jenkins /var/lib/jenkins/.jenkins/jobs
chmod -R 750 /var/lib/jenkins/.jenkins/jobs
su -c "java -jar /usr/share/java/jenkins/jenkins.war \"$@\"" - jenkins
