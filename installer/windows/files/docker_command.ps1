# Script non eseguibile singolarmente [intellij-idea_installer.ps1]
docker run -tdi --name=$dkrApp --net=`"host`" --privileged=true -e DISPLAY=${env:COMPUTERNAME}:0.0 -v ${dkrApp}_workdir:/home/developer -v ${dkrApp}_data:/home/developer/.IdeaIC$dkrAppVer ${imgVar}:latest
if ($?) {
	exit 0
} else {
	exit 1
}