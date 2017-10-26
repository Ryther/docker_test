@ECHO OFF
	IF EXIST output (
		RMDIR /S /Q output
	)
	MKDIR output
	CD files
	SET files=lib raiser.bat installer_intellij-idea.ps1 docker_command.ps1 launcher.ps1
	SET icon=intellij-idea.ico
	winrar a -r -m0 -ep1 -inul -ibck -y -sfxdefault64.sfx -iadm -cfg -x*git* -iicon"..\%icon%" -z"xfs.conf" ..\output\intellij-idea.exe %files%
:EOF