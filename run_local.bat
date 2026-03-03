@echo off
setlocal

cd /d "%~dp0"

echo ==============================================
echo Online Exam - Local Run Script
echo ==============================================
echo Project: %CD%
echo.

where mvn >nul 2>nul
if errorlevel 1 goto noMaven

echo [1/2] Building project...
call mvn -DskipTests package
if errorlevel 1 goto buildFail

if not defined CATALINA_HOME (
  if exist "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\startup.bat" set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0"
)

if defined CATALINA_HOME if exist "%CATALINA_HOME%\bin\startup.bat" goto startTomcat

echo.
echo [WARN] Tomcat home not found. Falling back to Maven runner.
echo Open: http://localhost:8080/exam/
echo Press Ctrl + C in this window to stop server.
echo.
call mvn tomcat7:run-war
goto done

:startTomcat
echo.
echo [2/2] Deploying WAR to Tomcat...
copy /Y "target\untitled-1.0-SNAPSHOT.war" "%CATALINA_HOME%\webapps\exam.war" >nul
if errorlevel 1 goto copyFail
call "%CATALINA_HOME%\bin\startup.bat"
echo.
echo App should be available at: http://localhost:8080/exam/
echo If this is first start, wait 15-30 seconds.
goto done

:noMaven
echo [ERROR] Maven not found in PATH.
pause
goto done

:buildFail
echo [ERROR] Build failed. Check output above.
pause
goto done

:copyFail
echo [ERROR] Could not copy WAR to Tomcat webapps. Check permissions.
pause

:done
endlocal
