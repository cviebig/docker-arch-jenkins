FROM cviebig/arch-docker

RUN pacman -S --noprogressbar --noconfirm --needed jenkins git subversion cvs openssh

# Update all plugins and download
# - git
# - cmakebuilder
# - docker-plugin
# - mercurial
# - publish-over-ssh
# - multiple-scms
# List retrieved from a fully updated instance
# ls /var/lib/jenkins/.jenkins/plugins ls -1 | sed -e 's/\..*$//' | sort | uniq
# also see http://stackoverflow.com/questions/13676108
# https://registry.hub.docker.com/u/pavelgopanenko/jenkins/dockerfile/raw
# https://github.com/jenkinsci/docker
# https://issues.jenkins-ci.org/browse/JENKINS-19927
# https://github.com/jenkinsci/docker/blob/master/plugins.sh
# http://stackoverflow.com/questions/14843696

ENV JENKINS_U https://updates.jenkins-ci.org/latest
ENV JENKINS_H /var/lib/jenkins/.jenkins
ENV JENKINS_P $JENKINS_H/plugins

RUN mkdir -v -p $JENKINS_P

RUN curl -L $JENKINS_U/ant.hpi -o $JENKINS_P/ant.hpi && \
    curl -L $JENKINS_U/antisamy-markup-formatter.hpi -o $JENKINS_P/antisamy-markup-formatter.hpi && \
    curl -L $JENKINS_U/authentication-tokens.hpi -o $JENKINS_P/authentication-tokens.hpi && \
    curl -L $JENKINS_U/credentials.hpi -o $JENKINS_P/credentials.hpi && \
    curl -L $JENKINS_U/cmakebuilder.hpi -o $JENKINS_P/cmakebuilder.hpi && \
    curl -L $JENKINS_U/cvs.hpi -o $JENKINS_P/cvs.hpi && \
    curl -L $JENKINS_U/docker-plugin.hpi -o $JENKINS_P/docker-plugin.hpi && \
    curl -L $JENKINS_U/durable-task.hpi -o $JENKINS_P/durable-task.hpi && \
    curl -L $JENKINS_U/external-monitor-job.hpi -o $JENKINS_P/external-monitor-job.hpi && \
    curl -L $JENKINS_U/git.hpi -o $JENKINS_P/git.hpi && \
    curl -L $JENKINS_U/git-client.hpi -o $JENKINS_P/git-client.hpi && \
    curl -L $JENKINS_U/javadoc.hpi -o $JENKINS_P/javadoc.hpi && \
    curl -L $JENKINS_U/junit.hpi -o $JENKINS_P/junit.hpi && \
    curl -L $JENKINS_U/ldap.hpi -o $JENKINS_P/ldap.hpi && \
    curl -L $JENKINS_U/mailer.hpi -o $JENKINS_P/mailer.hpi && \
    curl -L $JENKINS_U/mapdb-api.hpi -o $JENKINS_P/mapdb-api.hpi && \
    curl -L $JENKINS_U/matrix-auth.hpi -o $JENKINS_P/matrix-auth.hpi && \
    curl -L $JENKINS_U/matrix-project.hpi -o $JENKINS_P/matrix-project.hpi && \
    curl -L $JENKINS_U/maven-plugin.hpi -o $JENKINS_P/maven-plugin.hpi && \
    curl -L $JENKINS_U/mercurial.hpi -o $JENKINS_P/mercurial.hpi && \
    curl -L $JENKINS_U/multiple-scms.hpi -o $JENKINS_P/multiple-scms.hpi && \
    curl -L $JENKINS_U/pam-auth.hpi -o $JENKINS_P/pam-auth.hpi && \
    curl -L $JENKINS_U/publish-over-ssh.hpi -o $JENKINS_P/publish-over-ssh.hpi && \
    curl -L $JENKINS_U/scm-api.hpi -o $JENKINS_P/scm-api.hpi && \
    curl -L $JENKINS_U/script-security.hpi -o $JENKINS_P/script-security.hpi && \
    curl -L $JENKINS_U/ssh-credentials.hpi -o $JENKINS_P/ssh-credentials.hpi && \
    curl -L $JENKINS_U/ssh-slaves.hpi -o $JENKINS_P/ssh-slaves.hpi && \
    curl -L $JENKINS_U/subversion.hpi -o $JENKINS_P/subversion.hpi && \
    curl -L $JENKINS_U/token-macro.hpi -o $JENKINS_P/token-macro.hpi && \
    curl -L $JENKINS_U/translation.hpi -o $JENKINS_P/translation.hpi && \
    curl -L $JENKINS_U/windows-slaves.hpi -o $JENKINS_P/windows-slaves.hpi && \
    touch $JENKINS_P/ant.hpi.pinned && \
    touch $JENKINS_P/antisamy-markup-formatter.hpi.pinned && \
    touch $JENKINS_P/authentication-tokens.hpi.pinned && \
    touch $JENKINS_P/credentials.hpi.pinned && \
    touch $JENKINS_P/cmakebuilder.hpi.pinned && \
    touch $JENKINS_P/cvs.hpi.pinned && \
    touch $JENKINS_P/docker-plugin.hpi.pinned && \
    touch $JENKINS_P/durable-task.hpi.pinned && \
    touch $JENKINS_P/external-monitor-job.hpi.pinned && \
    touch $JENKINS_P/git.hpi.pinned && \
    touch $JENKINS_P/git-client.hpi.pinned && \
    touch $JENKINS_P/javadoc.hpi.pinned && \
    touch $JENKINS_P/junit.hpi.pinned && \
    touch $JENKINS_P/ldap.hpi.pinned && \
    touch $JENKINS_P/mailer.hpi.pinned && \
    touch $JENKINS_P/mapdb-api.hpi.pinned && \
    touch $JENKINS_P/matrix-auth.hpi.pinned && \
    touch $JENKINS_P/matrix-project.hpi.pinned && \
    touch $JENKINS_P/maven-plugin.hpi.pinned && \
    touch $JENKINS_P/mercurial.hpi.pinned && \
    touch $JENKINS_P/multiple-scms.hpi.pinned && \
    touch $JENKINS_P/pam-auth.hpi.pinned && \
    touch $JENKINS_P/publish-over-ssh.hpi.pinned && \
    touch $JENKINS_P/scm-api.hpi.pinned && \
    touch $JENKINS_P/script-security.hpi.pinned && \
    touch $JENKINS_P/ssh-credentials.hpi.pinned && \
    touch $JENKINS_P/ssh-slaves.hpi.pinned && \
    touch $JENKINS_P/subversion.hpi.pinned && \
    touch $JENKINS_P/translation.hpi.pinned && \
    touch $JENKINS_P/token-macro.hpi.pinned && \
    touch $JENKINS_P/windows-slaves.hpi.pinned

ADD org.jenkinsci.plugins.dockerbuildstep.DockerBuilder.xml $JENKINS_H/

RUN chown -R jenkins:jenkins $JENKINS_H

RUN gpasswd -a jenkins docker

ADD run.sh /var/lib/jenkins/

ADD updatejobs.sh /var/lib/jenkins/

RUN chown jenkins:jenkins /var/lib/jenkins/run.sh && \
    chmod +x /var/lib/jenkins/run.sh && \
    chown jenkins:jenkins /var/lib/jenkins/updatejobs.sh && \
    chmod +x /var/lib/jenkins/updatejobs.sh

EXPOSE 8080

CMD ["/var/lib/jenkins/run.sh"]
