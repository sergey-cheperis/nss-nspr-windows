@echo off

:: specify the path where you installed the Mozilla Build suite
::    (https://wiki.mozilla.org/MozillaBuild)
SET "MozBuild=c:\mozilla-build"

SET "WorkingDir=%~dp0nss\tests"
:: you may change localhost and localdomain to your actual names
%MozBuild%\msys\bin\bash --login -c "cd '%WorkingDir%'; HOST=localhost DOMSUF=localdomain ./all.sh"
