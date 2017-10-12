# INTELLIJ/IDEA 2017.2.5 docker container
--------------------------------
### Container Docker con GUI per l'IDE Intellij Idea con plugins principlai preinstallati
Container sviluppato con l'obbiettivo di unificare l'ambiente di sviluppo di tutti i programmatori Gamba Bruno S.p.A.
Per creare il container utilizzare il seguente comando:
- Windows:
`docker run -tdi --name=intellij-idea --net="host" --privileged=true -e DISPLAY=%COMPUTERNAME%:0.0 -v intellij_idea_data:/home/developer/.IdeaIC2017.2 ryther/intellij-idea:latest`
- Linux:
`sudo docker run -tdi --name=intellij-idea --net="host" --privileged=true -e DISPLAY=$DISPLAY -v intellij-idea_workdir:/home/developer -v /tmp/.X11-unix:/tmp/.X11-unix -v intellij-idea_config:/home/developer/.IdeaIC2017.2 ryther/intellij-idea:latest`
---------------------------------
Una volta creato il container, per eseguirlo nuovamente utilizzare il comando:  
`docker start intellij-idea`
