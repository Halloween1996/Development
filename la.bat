@echo off
title quick_Launcing_CMD
set "env=C:\Events\Development"
cd %env%
echo current enviorment: %env%
@setlocal enabledelayedexpansion
:top
echo.
echo.
set p=0
set /p ddc=I would like to activate 
if "!ddc!"=="" goto top
For /f "tokens=1,2 delims= " %%a in ("!ddc!") do if not "%%b"=="" call !ddc!&&goto top
for %%i in ("%env%\%ddc%*") do (
	set /a p+=1
	set "n!p!=%%~ni"
	set "path!p!=%%i"
)
if [!p!] == [0] echo No Such thing.&&goto top
if !p! equ 1 (
	set abc=1
) else (
	for /l %%l in (1 1 5) do if defined n%%l echo [%%l] !n%%l!
	echo which one?
	set /p abc=
	if not defined n!abc! goto top
)
start "" "!path%abc%! "&& echo Launching !n%abc%!...
IF not "%ERRORLEVEL%"=="0" exit /b
goto top