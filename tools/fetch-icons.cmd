@echo off
setlocal
set SHORTS=%1
if "%SHORTS%"=="" set SHORTS=%~dp0..\IRM_Shortnames.txt
powershell -ExecutionPolicy Bypass -File "%~dp0fetch-icons.ps1" -ShortnamesPath "%SHORTS%"
endlocal
