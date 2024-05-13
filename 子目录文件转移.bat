@echo off
:all
cls
echo %cd%
echo all-file mode, ".single" to switch to single-file mode.
echo warning! ALL FILES ARE NOTE RESERVABLE! Be sure no files in any subfolder has the same name with others!
set /p ddc=what kind of file extension(s) would be except: 
if "%ddc%"==".single" goto single
for %%d in (%ddc%) do set .%%~d=exception
for /r "%CD%" %%i in (*) do if not defined %%~xi move "%%i" "%Cd%"
if "%ddc%"=="" for /d /r "%cd%" %%b in (*) do rd %%b
exit
:single
cls
echo %cd%
echo single-file mode, ".all" switch to all-file mode.
echo warning! ALL FILES ARE NOTE RESERVABLE! Be sure no files in any subfolder has the same name with others!
set /p gjc=The file extension that you want to transfer to current dir.: 
if "%gjc%"==".all" goto all
for %%a in (%gjc%) do (
	for /r "%CD%" %%i in (*.%%a) do (
		move "%%i" "%CD%"
	)
)
exit