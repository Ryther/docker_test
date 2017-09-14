@ECHO OFF
	CD files
	7Z a files ^
		batch_utils.cmd ^
		intellij-idea_installer.bat ^
		starter.bat
	MKDIR ..\output
	COPY /b 7zSD.sfx + config.txt + files.7z ..\output\intellij-idea.exe