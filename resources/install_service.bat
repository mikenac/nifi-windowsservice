@echo off

set NIFI_VERSION=1.11.4

call nifi-env.bat
set LIB_DIR=%NIFI_ROOT%\lib\bootstrap
set CONF_DIR=%NIFI_ROOT%\conf

set BOOTSTRAP_CONF_FILE=%CONF_DIR%\bootstrap.conf
set SRV_BIN=%cd%\nifi-service.exe
set SVC_NAME=nifi-service
set SVC_DISPLAY="Apache NiFi"
set SVC_DESCRIPTION="Apache NiFi Data Integration Engine"
set JVM=auto
set PR_JVMMS=128
set PR_JVMMX=512
set PR_JVMSS=4000
set START_MODE=jvm
set STOP_MODE=jvm
set STOP_TIMEOUT=10
set STARTUP=auto
set JAVA_ARGS=-Dorg.apache.nifi.bootstrap.config.log.dir="%NIFI_LOG_DIR%";-Dorg.apache.nifi.bootstrap.config.pid.dir="%NIFI_PID_DIR%";-Dorg.apache.nifi.bootstrap.config.file="%BOOTSTRAP_CONF_FILE%"
SET JAVA_PARAMS=-cp %CONF_DIR%;%LIB_DIR%\* -Xms12m -Xmx24m %JAVA_ARGS% org.apache.nifi.bootstrap.RunNiFi
set START_CLASS=org.apache.nifi.bootstrap.WindowsService
set START_METHOD=start
set STOP_CLASS=org.apache.nifi.bootstrap.WindowsService
set STOP_METHOD=stop
REM START_PARAMS=-verbose
set START_PARAMS=
REM STOP_PARAMS=-verbose
set STOP_PARAMS=
set CLASS_PATH=lib\bootstrap\nifi-windowsservice-%NIFI_VERSION%.jar;%CONF_DIR%;%LIB_DIR%\*;
set LOG_PATH="%NIFI_ROOT%\logs"
set LOG_PREFIX=nifi-service.log

"%SRV_BIN%" //IS//%SVC_NAME% ^
--DisplayName=%SVC_DISPLAY% ^
--Description=%SVC_DESCRIPTION% ^
--Install="%SRV_BIN%" ^
--Jvm="%JVM%" ^
--JvmMs="%PR_JVMMS%" ^
--JvmMx="%PR_JVMMX%" ^
--JvmSs="%PR_JVMSS%" ^
--StartMode="%START_MODE%" ^
--StopMode="%STOP_MODE%" ^
--Startup="%STARTUP%" ^
--StartClass="%START_CLASS%" ^
--StopClass="%STOP_CLASS%" ^
--StartParams="%START_PARAMS%" ^
--StopParams="%STOP_PARAMS%" ^
--StartMethod="%START_METHOD%" ^
--StopMethod="%STOP_METHOD%" ^
--StopTimeout="%STOP_TIMEOUT%" ^
--Classpath="%CLASS_PATH%" ^
--JvmOptions="%JAVA_ARGS%" ^
--LogLevel=ERROR ^
--LogPath="%LOG_PATH%" ^
--LogPrefix="%LOG_PREFIX%" ^
--StdOutput=auto ^
--StdError=auto

REM Start the service after installation
"%SRV_BIN%" //ES//%SVC_NAME%
