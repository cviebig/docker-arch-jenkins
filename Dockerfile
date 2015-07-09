FROM cviebig/arch-base

RUN pacman -S --noprogressbar --noconfirm --needed ca-certificates jenkins git subversion cvs

EXPOSE 8080

USER jenkins
CMD ["java","-jar","/usr/share/java/jenkins/jenkins.war"]
