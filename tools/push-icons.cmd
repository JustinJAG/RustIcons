@echo off
setlocal
cd /d "%~dp0.."
git add icons
if not "%1"=="" (set MSG=%*) else (set MSG=Update icons)
git commit -m "%MSG%"
git push
endlocal
