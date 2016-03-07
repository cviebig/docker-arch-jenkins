FROM cviebig/arch-docker

RUN pacman -S --noprogressbar --noconfirm --needed jenkins git subversion cvs openssh

# Update all plugins and download
# - git
# - docker-plugin
# - docker-build-step
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

RUN curl -L $JENKINS_U/ant.jpi -o $JENKINS_P/ant.jpi && \
    curl -L $JENKINS_U/antisamy-markup-formatter.jpi -o $JENKINS_P/antisamy-markup-formatter.jpi && \
    curl -L $JENKINS_U/authentication-tokens.jpi -o $JENKINS_P/authentication-tokens.jpi && \
    curl -L $JENKINS_U/cmakebuilder.hpi -o $JENKINS_P/cmakebuilder.hpi && \
    curl -L $JENKINS_U/credentials.jpi -o $JENKINS_P/credentials.jpi && \
    curl -L $JENKINS_U/cvs.jpi -o $JENKINS_P/cvs.jpi && \
    curl -L $JENKINS_U/docker-build-step.jpi -o $JENKINS_P/docker-build-step.jpi && \
    curl -L $JENKINS_U/docker-commons.jpi -o $JENKINS_P/docker-commons.jpi && \
    curl -L $JENKINS_U/docker-plugin.hpi -o $JENKINS_P/docker-plugin.hpi && \
    curl -L $JENKINS_U/durable-task.hpi -o $JENKINS_P/durable-task.hpi && \
    curl -L $JENKINS_U/external-monitor-job.jpi -o $JENKINS_P/external-monitor-job.jpi && \
    curl -L $JENKINS_U/git-client.hpi -o $JENKINS_P/git-client.hpi && \
    curl -L $JENKINS_U/git.hpi -o $JENKINS_P/git.hpi && \
    curl -L $JENKINS_U/icon-shim.jpi -o $JENKINS_P/icon-shim.jpi && \
    curl -L $JENKINS_U/javadoc.jpi -o $JENKINS_P/javadoc.jpi && \
    curl -L $JENKINS_U/junit.jpi -o $JENKINS_P/junit.jpi && \
    curl -L $JENKINS_U/ldap.jpi -o $JENKINS_P/ldap.jpi && \
    curl -L $JENKINS_U/mailer.jpi -o $JENKINS_P/mailer.jpi && \
    curl -L $JENKINS_U/mapdb-api.hpi -o $JENKINS_P/mapdb-api.hpi && \
    curl -L $JENKINS_U/matrix-auth.jpi -o $JENKINS_P/matrix-auth.jpi && \
    curl -L $JENKINS_U/matrix-project.jpi -o $JENKINS_P/matrix-project.jpi && \
    curl -L $JENKINS_U/maven-plugin.jpi -o $JENKINS_P/maven-plugin.jpi && \
    curl -L $JENKINS_U/mercurial.hpi -o $JENKINS_P/mercurial.hpi && \
    curl -L $JENKINS_U/multiple-scms.hpi -o $JENKINS_P/multiple-scms.hpi && \
    curl -L $JENKINS_U/pam-auth.jpi -o $JENKINS_P/pam-auth.jpi && \
    curl -L $JENKINS_U/publish-over-ssh.hpi -o $JENKINS_P/publish-over-ssh.hpi && \
    curl -L $JENKINS_U/scm-api.hpi -o $JENKINS_P/scm-api.hpi && \
    curl -L $JENKINS_U/script-security.jpi -o $JENKINS_P/script-security.jpi && \
    curl -L $JENKINS_U/ssh-credentials.jpi -o $JENKINS_P/ssh-credentials.jpi && \
    curl -L $JENKINS_U/ssh-slaves.jpi -o $JENKINS_P/ssh-slaves.jpi && \
    curl -L $JENKINS_U/subversion.jpi -o $JENKINS_P/subversion.jpi && \
    curl -L $JENKINS_U/token-macro.hpi -o $JENKINS_P/token-macro.hpi && \
    curl -L $JENKINS_U/translation.jpi -o $JENKINS_P/translation.jpi && \
    curl -L $JENKINS_U/windows-slaves.jpi -o $JENKINS_P/windows-slaves.jpi && \
    touch $JENKINS_P/ant.jpi.pinned && \
    touch $JENKINS_P/antisamy-markup-formatter.jpi.pinned && \
    touch $JENKINS_P/authentication-tokens.jpi.pinned && \
    touch $JENKINS_P/cmakebuilder.hpi.pinned && \
    touch $JENKINS_P/credentials.jpi.pinned && \
    touch $JENKINS_P/cvs.jpi.pinned && \
    touch $JENKINS_P/docker-build-step.jpi.pinned && \
    touch $JENKINS_P/docker-commons.jpi.pinned && \
    touch $JENKINS_P/docker-plugin.hpi.pinned && \
    touch $JENKINS_P/durable-task.hpi.pinned && \
    touch $JENKINS_P/external-monitor-job.jpi.pinned && \
    touch $JENKINS_P/git-client.hpi.pinned && \
    touch $JENKINS_P/git.hpi.pinned && \
    touch $JENKINS_P/icon-shim.jpi.pinned && \
    touch $JENKINS_P/javadoc.jpi.pinned && \
    touch $JENKINS_P/junit.jpi.pinned && \
    touch $JENKINS_P/ldap.jpi.pinned && \
    touch $JENKINS_P/mailer.jpi.pinned && \
    touch $JENKINS_P/mapdb-api.hpi.pinned && \
    touch $JENKINS_P/matrix-auth.jpi.pinned && \
    touch $JENKINS_P/matrix-project.jpi.pinned && \
    touch $JENKINS_P/maven-plugin.jpi.pinned && \
    touch $JENKINS_P/mercurial.hpi.pinned && \
    touch $JENKINS_P/multiple-scms.hpi.pinned && \
    touch $JENKINS_P/pam-auth.jpi.pinned && \
    touch $JENKINS_P/publish-over-ssh.hpi.pinned && \
    touch $JENKINS_P/scm-api.hpi.pinned && \
    touch $JENKINS_P/script-security.jpi.pinned && \
    touch $JENKINS_P/ssh-credentials.jpi.pinned && \
    touch $JENKINS_P/ssh-slaves.jpi.pinned && \
    touch $JENKINS_P/subversion.jpi.pinned && \
    touch $JENKINS_P/token-macro.hpi.pinned && \
    touch $JENKINS_P/translation.jpi.pinned && \
    touch $JENKINS_P/windows-slaves.jpi.pinned

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
