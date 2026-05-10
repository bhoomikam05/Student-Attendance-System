@echo off
title Student Management System
color 0A

set "JAVA_HOME=C:\Program Files\Java\jdk-17.0.18"
set "JRE_HOME=C:\Program Files\Java\jdk-17.0.18"
set "CATALINA_HOME=C:\Users\ayush\OneDrive\Desktop\student.java\apache-tomcat-10.1.30"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\student\WEB-INF\classes"
set "SERVLET_JAR=%CATALINA_HOME%\lib\servlet-api.jar"
set "SRC=C:\Users\ayush\OneDrive\Desktop\student.java\src"
set "WEB=C:\Users\ayush\OneDrive\Desktop\student.java\WebContent"

echo.
echo ============================================
echo   Student Management System - Launching...
echo ============================================
echo.

:: Compile
echo [1/4] Compiling...
"%JAVA_HOME%\bin\javac.exe" -source 17 -target 17 -cp "%SERVLET_JAR%" -d "%DEPLOY_DIR%" "%SRC%\com\student\model\Student.java" "%SRC%\com\student\dao\StudentDAO.java" "%SRC%\com\student\servlet\StudentServlet.java" "%SRC%\com\student\servlet\StudentAPIServlet.java"
if %ERRORLEVEL% NEQ 0 ( echo [ERROR] Compile failed! & pause & exit /b 1 )
echo [OK] Compiled!

:: Deploy files
echo [2/4] Deploying web files...
copy /Y "%WEB%\index.jsp" "%CATALINA_HOME%\webapps\student\index.jsp"
copy /Y "%WEB%\view.jsp" "%CATALINA_HOME%\webapps\student\view.jsp"
xcopy /E /Y /I "%WEB%\leave-system" "%CATALINA_HOME%\webapps\student\leave-system\"
echo [OK] Files deployed!

:: Kill old Tomcat
echo [3/4] Killing old Tomcat (if any)...
taskkill /F /IM "java.exe" /FI "WINDOWTITLE eq Tomcat*" >nul 2>&1
timeout /t 2 /nobreak >nul

:: Start Tomcat
echo [4/4] Starting Tomcat...
start "Tomcat Server" "%CATALINA_HOME%\bin\catalina.bat" run

echo.
echo Waiting for Tomcat to start...
timeout /t 7 /nobreak >nul

echo.
echo ============================================
echo   App is RUNNING at:
echo   http://localhost:8080/student/
echo ============================================
echo.
start "" "http://localhost:8080/student/"

echo Press any key to STOP Tomcat and exit...
pause >nul

echo Stopping Tomcat...
"%CATALINA_HOME%\bin\shutdown.bat"
timeout /t 2 /nobreak >nul
echo Bye!
