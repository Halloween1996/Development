@echo off
title chfs
for /f "delims=" %%a in (%cd%\Batch_Environment.ini) do set "%%a"
setlocal enabledelayedexpansion
for %%i in ("C:\Events\Development\chfs\*.ini") do (
	set /a p+=1
	set "n!p!=%%~ni"
	set "path!p!=%%i"
)
if [!p!] == [0] echo No Such thing.&&pause
if !p! equ 1 (
	set abc=1
) else (
	for /l %%l in (1 1 5) do if defined n%%l echo [%%l] !n%%l!
	echo which one?
	set /p abc=
	if not defined n!abc! exit
)
chfs --file="!path%abc%!"