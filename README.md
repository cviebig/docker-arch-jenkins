How to use:

docker create -v /var/lib/jenkins/.jenkins/jobs --name jenkinsjobs cviebig/scratch null
docker run --volumes-from jenkinsjobs --privileged cviebig/arch-jenkins &

Access configured jobs as follows:

docker inspect --format '{{ .Volumes }}' jenkinsjobs
docker inspect --format '{{ index .Volumes "/var/lib/jenkins/.jenkins/jobs" }}' jenkinsjobs
sudo ls -la $(docker inspect --format '{{ index .Volumes "/var/lib/jenkins/.jenkins/jobs" }}' jenkinsjobs)

Alternatively you can also explicitly specify a directory that should
be used to store the volume for the job configurations:

docker create -v $(pwd)/jenkinsjobs:/var/lib/jenkins/.jenkins/jobs --name jenkinsjobs cviebig/scratch null
