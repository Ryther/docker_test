# FROM ubuntu:latest
FROM phusion/baseimage:latest

LABEL maintainer="edoardo.zanoni@gambabruno.it"

# Variabili della build
ENV	LANG=C.UTF-8 \
	INTELLIJ_VER=2017.2 \
	INTELLIJ_MINVER=6 \
	OLD_JDK1_VER=1.3.1_20 \
	OLD_JDK2_VER=1.4.2_18 \
	OLD_JDK3_VER=1.6.0_45

# Aggiornamento ed installazione delle applicazioni di base
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update -qq && \
    echo 'Installing OS dependencies' && \
    apt-get install -qq -y --fix-missing sudo \
		software-properties-common \
		libxext-dev \
		libxrender-dev \
		libxslt1.1 \
		libxtst-dev \
		libgtk2.0-0 \
		libcanberra-gtk-module \
		libsecret-1-0 \
		lib32z1 \
		git \
		gnome-keyring \
		unzip \
		wget \
		openjdk-8-jdk && \
    echo 'Cleaning up' && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y &&  \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Creazione utente principale (developer)
RUN echo 'Creating user: developer' && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    sudo echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    sudo chmod 0440 /etc/sudoers.d/developer && \
    sudo chown developer:developer -R /home/developer && \
    sudo chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo

# Creazione directory principali per opzioni e plugins
RUN mkdir -p /home/developer/.IdeaIC${INTELLIJ_VER}/config/options && \
    mkdir -p /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins

# Impostazione dell'owner della cartella (developer)
RUN chown developer:developer -R /home/developer/.IdeaIC${INTELLIJ_VER}

# Installazione versioni obsolete di Java
RUN wget https://github.com/Ryther/intellij-idea/raw/master/docker/jvm/jdk${OLD_JDK1_VER}.tar -O /tmp/jdk${OLD_JDK1_VER}.tar -q && \
	wget https://github.com/Ryther/intellij-idea/raw/master/docker/jvm/j2sdk${OLD_JDK2_VER}.tar -O /tmp/j2sdk${OLD_JDK2_VER}.tar -q && \
	wget https://github.com/Ryther/intellij-idea/raw/master/docker/jvm/jdk${OLD_JDK3_VER}.tar -O /tmp/jdk${OLD_JDK3_VER}.tar -q && \
	tar -xzvf /tmp/jdk${OLD_JDK1_VER}.tar -C /usr/lib/jvm/ && \
	tar -xzvf /tmp/j2sdk${OLD_JDK2_VER}.tar -C /usr/lib/jvm/ && \
	tar -xzvf /tmp/jdk${OLD_JDK3_VER}.tar -C /usr/lib/jvm/ && \
	rm -rf /tmp/* && \
# Attivazione JDK 3
	sudo update-alternatives --install "/usr/bin/java" "java" \
	"/usr/lib/jvm/jdk${OLD_JDK1_VER}/bin/java" 1 && \
	sudo update-alternatives --install "/usr/bin/javac" "javac" \
	"/usr/lib/jvm/jdk${OLD_JDK1_VER}/bin/javac" 1 && \
# Attivazione JDK 4	
	sudo update-alternatives --install "/usr/bin/java" "java" \
	"/usr/lib/jvm/j2sdk${OLD_JDK2_VER}/bin/java" 1 && \
	sudo update-alternatives --install "/usr/bin/javac" "javac" \
	"/usr/lib/jvm/j2sdk${OLD_JDK2_VER}/bin/javac" 1 && \
# Attivazione JDK 6
	sudo update-alternatives --install "/usr/bin/java" "java" \
	"/usr/lib/jvm/jdk${OLD_JDK3_VER}/bin/java" 1 && \
	sudo update-alternatives --install "/usr/bin/javac" "javac" \
	"/usr/lib/jvm/jdk${OLD_JDK3_VER}/bin/javac" 1 && \
	sudo update-alternatives --install "/usr/bin/javaws" "javaws" \
	"/usr/lib/jvm/jdk${OLD_JDK3_VER}/bin/javaws" 1

# Download ed installazione di IntelliJ IDEA
RUN echo 'Downloading IntelliJ IDEA' && \
    wget http://download-cf.jetbrains.com/idea/ideaIC-${INTELLIJ_VER}.${INTELLIJ_MINVER}.tar.gz -O /tmp/intellij.tar.gz -q && \
    echo 'Installing IntelliJ IDEA' && \
    mkdir -p /opt/intellij && \
	sudo chown developer:developer -R /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz

ENV	VSTS_VER=38535 \
	MARKD_SUP_VER=39782 \
	GAUGE_VER=39072 \
	BASHS_VER=38357 \
	BATCH_VER=22567 \
	CMDSUPP_VER=18875 \
	CHECKSTYLE_VER=40357 \
	DBNAV_VER=38969 \
	DCKER_VER=38244 \
	MATERIAL_VER=40479 \
	CODEGLANCE_VER=33731 \
	YAML_VER=35585 \
	SONARLINT_VER=36564 \
	KEYPROMX_VER=38839 \
	GITLAB_VER=39157

# Installazione plugins
RUN echo 'Installing Visual Studio Team Serivces Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
    wget https://plugins.jetbrains.com/plugin/download?updateId=${VSTS_VER} -O ${VSTS_VER}.zip -q && \
    unzip -q ${VSTS_VER}.zip && \
    rm ${VSTS_VER}.zip

RUN echo 'Installing Markdown Support Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${MARKD_SUP_VER} -O ${MARKD_SUP_VER}.zip -q && \
    unzip -q ${MARKD_SUP_VER}.zip && \
    rm ${MARKD_SUP_VER}.zip
	
RUN echo 'Installing Gauge Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${GAUGE_VER} -O ${GAUGE_VER}.zip -q && \
	unzip -q ${GAUGE_VER}.zip && \
	rm ${GAUGE_VER}.zip

RUN echo 'Installing BashSupport Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${BASHS_VER} -O ${BASHS_VER}.zip -q && \
	unzip -q ${BASHS_VER}.zip && \
	rm ${BASHS_VER}.zip

RUN echo 'Installing Batch Scripts support Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${BATCH_VER} -O ${BATCH_VER}.zip -q && \
	unzip -q ${BATCH_VER}.zip && \
	rm ${BATCH_VER}.zip
	
RUN echo 'Installing CMD Support Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${CMDSUPP_VER} -O ${CMDSUPP_VER}.zip -q && \
	unzip -q ${CMDSUPP_VER}.zip && \
	rm ${CMDSUPP_VER}.zip

RUN echo 'Installing CheckStyle-IDEA Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${CHECKSTYLE_VER} -O ${CHECKSTYLE_VER}.zip -q && \
	unzip -q ${CHECKSTYLE_VER}.zip && \
	rm ${CHECKSTYLE_VER}.zip

RUN echo 'Installing Database Navigator Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${DBNAV_VER} -O ${DBNAV_VER}.zip -q && \
	unzip -q ${DBNAV_VER}.zip && \
	rm ${DBNAV_VER}.zip

RUN echo 'Installing Docker Integration Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${DCKER_VER} -O ${DCKER_VER}.zip -q && \
	unzip -q ${DCKER_VER}.zip && \
	rm ${DCKER_VER}.zip

RUN echo 'Installing Material Theme UI Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${MATERIAL_VER} -O ${MATERIAL_VER}.zip -q && \
	unzip -q ${MATERIAL_VER}.zip && \
	rm ${MATERIAL_VER}.zip

RUN echo 'Installing CodeGlance Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${CODEGLANCE_VER} -O ${CODEGLANCE_VER}.zip -q && \
	unzip -q ${CODEGLANCE_VER}.zip && \
	rm ${CODEGLANCE_VER}.zip

RUN echo 'Installing YAML/Ansible support Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${YAML_VER} -O ${YAML_VER}.zip -q && \
	unzip -q ${YAML_VER}.zip && \
	rm ${YAML_VER}.zip

RUN echo 'Installing SonarLint Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${SONARLINT_VER} -O ${SONARLINT_VER}.zip -q && \
	unzip -q ${SONARLINT_VER}.zip && \
	rm ${SONARLINT_VER}.zip

RUN echo 'Installing Key Promoter X Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${KEYPROMX_VER} -O ${KEYPROMX_VER}.zip -q && \
	unzip -q ${KEYPROMX_VER}.zip && \
	rm ${KEYPROMX_VER}.zip
	
RUN echo 'Installing GitLab Projects Plugin' && \
	cd /home/developer/.IdeaIC${INTELLIJ_VER}/config/plugins/ && \
	wget https://plugins.jetbrains.com/plugin/download?updateId=${GITLAB_VER} -O ${GITLAB_VER}.zip -q && \
	unzip -q ${GITLAB_VER}.zip && \
	rm ${GITLAB_VER}.zip

# Impostazione dell'owner della cartella (developer)
RUN sudo chown developer:developer -R /home/developer

# Creazione dei mounting point
VOLUME [ "/home/developer/.IdeaIC${INTELLIJ_VER}" ]
VOLUME [ "/home/developer" ]
VOLUME [ "/tmp/.X11-unix" ]

# Operazioni finali
USER developer
ENV HOME /home/developer
WORKDIR /home/developer
ENTRYPOINT [ "/opt/intellij/bin/idea.sh" ]
