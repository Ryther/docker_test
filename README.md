
# INTELLIJ/IDEA 2017.2.5 docker container
--------------------------------
### Container Docker con GUI per l'IDE Intellij Idea con plugins principlai preinstallati
Container sviluppato con l'obbiettivo di unificare l'ambiente di sviluppo di tutti i programmatori Gamba Bruno S.p.A.
Per creare il container utilizzare il seguente comando:
|OS|CREATION COMMAND|
|:-:|:--------------|
- Windows:
>`docker run -tdi --name=intellij-idea --net="host" --privileged=true -e DISPLAY=%COMPUTERNAME%:0.0 -v intellij-idea_workdir:/home/developer -v intellij_idea_data:/home/developer/.IdeaIC2017.2 ryther/intellij-idea:latest`
- Linux:
>`sudo docker run -tdi --name=intellij-idea --net="host" --privileged=true -e DISPLAY=$DISPLAY -v intellij-idea_workdir:/home/developer -v /tmp/.X11-unix:/tmp/.X11-unix -v intellij-idea_config:/home/developer/.IdeaIC2017.2 ryther/intellij-idea:latest`
---------------------------------
Una volta creato il container, per eseguirlo nuovamente utilizzare il comando:  
`docker start intellij-idea`

|DOCKERFILE NAME|VERSION|VERSION ID|NAME|DL LINK|
|:------------------|:-----------:|:--------------:|:-------|:------:|
|VSTS_VER		|	1.123.0		|	38535	|	Visual Studio Team Services	|	https://plugins.jetbrains.com/plugin/download?updateId=38535|
|MARKD_SUP_VER	|	173.2696.26	|	39197	|	Markdown support			|	https://plugins.jetbrains.com/plugin/download?updateId=39197|
|GAUGE_VER 		|	0.3.7		|	39072	|	Gauge						|	https://plugins.jetbrains.com/plugin/download?updateId=39072|
|BASHS_VER		|	1.6.12.172	|	38357	|	BashSupport 				|	https://plugins.jetbrains.com/plugin/download?updateId=38357|
|BATCH_VER		|	1.0.7		|	22567	|	Batch Scripts Support 		|	https://plugins.jetbrains.com/plugin/download?updateId=22567|
|CMDSUPP_VER	|	1.0.5		|	18875	|	CMD Support 				|	https://plugins.jetbrains.com/plugin/download?updateId=18875|
|CHECKSTYLE_VER	|	5.10.2		|	39392	|	CheckStyle-IDEA 			|	https://plugins.jetbrains.com/plugin/download?updateId=39392|
|DBNAV_VER		|	3.0.7621.0	|	38969	|	Database Navigator			|	https://plugins.jetbrains.com/plugin/download?updateId=38969|
|DCKER_VER		|	172.3968.28	|	38244	|	Docker integration 			|	https://plugins.jetbrains.com/plugin/download?updateId=38244|
|MATERIAL_VER	|	1.0.1		|	39459	|	Material Theme UI			|	https://plugins.jetbrains.com/plugin/download?updateId=39459|
|CODEGLANCE_VER	|	1.5.2		|	33731	|	CodeGlance 					|	https://plugins.jetbrains.com/plugin/download?updateId=33731|
|YAML_VER		|	0.9.5		|	35585	|	YAML/Ansible support 		|	https://plugins.jetbrains.com/plugin/download?updateId=35585|
|SONARLINT_VER	|	3.0.0.2041	|	36564	|	SonarLint 					|	https://plugins.jetbrains.com/plugin/download?updateId=36564|
|KEYPROMX_VER	|	5.10		|	38839	|	Key Promoter X 				|	https://plugins.jetbrains.com/plugin/download?updateId=38839|


> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTkyODIyNjMyXX0=
-->