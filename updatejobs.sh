#!/bin/sh
mkdir -v -p /var/lib/jenkins/.jenkins/jobs
cd /var/lib/jenkins/.jenkins/jobs
git init
git remote add origin https://github.com/cviebig/jenkins-jobs.git || true
git pull -f origin master

