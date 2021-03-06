@echo off
@setlocal enableextensions
@cd /d "%~dp0"
call variables.bat

IF NOT EXIST P: GOTO NODRIVE
IF NOT EXIST "%arma3_dir%" GOTO NOARMA3DIR
echo "Run this script as administrator!"

mkdir P:\z
mkdir "%arma3_dir%\z"

mklink /D "%arma3_dir%\z\hehu" "%source_dir%"
mklink /D "P:\z\hehu" "%source_dir%"

pause
exit 0

:NODRIVE
echo "OMFG. Set up the P: drive!"
pause
exit 1

:NOARMA3DIR
echo You don't have a %arma3_dir% directory. Please adjust the path in this script!
pause
exit 1
