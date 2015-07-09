FROM cviebig/arch-base

RUN pacman -S --noprogressbar --noconfirm --needed ca-certificates jenkins git subversion cvs

ADD run.sh /var/lib/jenkins/
RUN chown jenkins:jenkins /var/lib/jenkins/run.sh && \
    chmod +x /var/lib/jenkins/run.sh

VOLUME $JENKINS_H/jobs
EXPOSE 8080

CMD ["/var/lib/jenkins/run.sh"]
