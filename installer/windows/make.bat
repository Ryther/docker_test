@ECHO OFF
	IF EXIST output (
		RMDIR /S /Q output
	)
	MKDIR output
	CD files
	SET prg_name=intellij-idea
	SET files=lib raiser.bat installer_%prg_name%.ps1 docker_command.ps1 launcher.ps1
	SET icon=icon.ico
	winrar a -r -m0 -ep1 -inul -ibck -y -sfxdefault.sfx -iadm -cfg -x*git* -iicon"..\%icon%" -z"xfs.conf" ..\output\%prg_name%.exe %files%
:EOF
