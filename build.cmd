@echo off

:: configure following 2 vars to make it work:
:: 1. specify the path where vcvars*.bat files are located
SET "VsPath=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
:: 2. specify the path where you installed the Mozilla Build suite
::    (https://wiki.mozilla.org/MozillaBuild)
SET "MozBuild=c:\mozilla-build"


SET "CommonOpt=OS_TARGET=WIN95 USE_STATIC_RTL=1"
SET "ReleaseOpt=BUILD_OPT=1"
SET "DebugOpt=USE_DEBUG_RTL=1"

SET "Bash=%MozBuild%\msys\bin\bash --login -i -c"
SET "SrcDir=%~dp0nss"
SET "Make=make nss_build_all"


:: 32-bit builds
CALL "%VsPath%\vcvars32.bat"
IF %errorlevel% NEQ 0 EXIT %errorlevel%

%BASH% "cd '%SrcDir%'; %CommonOpt% %DebugOpt% %Make%"
IF %errorlevel% NEQ 0 EXIT %errorlevel%

%BASH% "cd '%SrcDir%'; %CommonOpt% %ReleaseOpt% %Make%"
IF %errorlevel% NEQ 0 EXIT %errorlevel%


:: 64-bit builds
SET "CommonOpt=%CommonOpt% USE_64=1"

CALL "%VsPath%\vcvars64.bat"
IF %errorlevel% NEQ 0 EXIT %errorlevel%

%BASH% "cd '%SrcDir%'; %CommonOpt% %DebugOpt% %Make%"
IF %errorlevel% NEQ 0 EXIT %errorlevel%

%BASH% "cd '%SrcDir%'; %CommonOpt% %ReleaseOpt% %Make%"
IF %errorlevel% NEQ 0 EXIT %errorlevel%
