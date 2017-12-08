@echo off

:: specify the path where you installed the Mozilla Build suite (https://wiki.mozilla.org/MozillaBuild)
SET "MozBuild=c:\mozilla-build"

:: you may change localhost and localdomain to your actual names
SET Host=localhost
SET Domain=localdomain

:: if on 64-bit platform, test the 64-bit build 
SET WINCURVERKEY=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion
REG QUERY "%WINCURVERKEY%" /v "ProgramFilesDir (x86)" >nul 2>nul
IF NOT ERRORLEVEL 1 SET USE_64=1

SET "WorkingDir=%~dp0nss\tests"
SET "MOZILLABUILD=%MozBuild%\"
%MozBuild%\msys\bin\bash --login -i -c "cd '%WorkingDir%'; HOST=%Host% DOMSUF=%Domain% ./all.sh"
