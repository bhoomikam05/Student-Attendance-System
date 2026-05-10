@echo off
title Student Management System - Runner
color 0A

echo ============================================
echo   Student Management System - Auto Runner
echo ============================================
echo.

:: ---- CONFIG ----
set "JAVA_HOME=C:\Program Files\Java\jdk-17.0.18"
set "CATALINA_HOME=%~dp0apache-tomcat-10.1.30"
set "PROJECT_DIR=%~dp0"
set "SRC_DIR=%PROJECT_DIR%src"
set "DEPLOY_DIR=%CATALINA_HOME%\webapps\student\WEB-INF\classes"
set "SERVLET_JAR=%CATALINA_HOME%\lib\servlet-api.jar"
set "JRE_HOME=%JAVA_HOME%"

echo [INFO] JAVA_HOME  = %JAVA_HOME%
echo [INFO] CATALINA_HOME = %CATALINA_HOME%
echo.

:: ---- VERIFY JAVA ----
if not exist "%JAVA_HOME%\bin\javac.exe" (
    echo [ERROR] Java not found at: %JAVA_HOME%
    echo Please install JDK 17 or update JAVA_HOME path in this script.
    pause
    exit /b 1
)
echo [OK] Java found!

:: ---- VERIFY TOMCAT ----
if not exist "%CATALINA_HOME%\bin\startup.bat" (
    echo [ERROR] Tomcat not found at: %CATALINA_HOME%
    pause
    exit /b 1
)
echo [OK] Tomcat found!
echo.

:: ---- STEP 1: Compile Java files ----
echo [1/3] Compiling Java source files...
"%JAVA_HOME%\bin\javac.exe" -source 17 -target 17 ^
  -cp "%SERVLET_JAR%" ^
  -d "%DEPLOY_DIR%" ^
  "%SRC_DIR%\com\student\model\Student.java" ^
  "%SRC_DIR%\com\student\dao\StudentDAO.java" ^
  "%SRC_DIR%\com\student\servlet\StudentServlet.java" ^
  "%SRC_DIR%\com\student\servlet\StudentAPIServlet.java"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed! Check your Java code.
    pause
    exit /b 1
)
echo [OK] Compilation successful!
echo.

:: ---- STEP 1.5: Copy JSP + HTML files to Tomcat webapps ----
echo [Deploy] Copying JSP and HTML files to Tomcat...
copy /Y "%PROJECT_DIR%WebContent\index.jsp"  "%CATALINA_HOME%\webapps\student\index.jsp"  >nul
copy /Y "%PROJECT_DIR%WebContent\view.jsp"   "%CATALINA_HOME%\webapps\student\view.jsp"   >nul
xcopy /E /Y /I "%PROJECT_DIR%WebContent\leave-system" "%CATALINA_HOME%\webapps\student\leave-system\" >nul
echo [Deploy] Done!
echo.

:: ---- STEP 2: Stop Tomcat if already running ----
echo [2/3] Stopping any existing Tomcat instance...
taskkill /F /IM "tomcat*.exe" >nul 2>&1
taskkill /F /FI "WINDOWTITLE eq Tomcat" >nul 2>&1
timeout /t 3 /nobreak >nul

:: ---- STEP 3: Start Tomcat via helper ----
echo [3/3] Starting Tomcat server...
start "Tomcat Server" "%~dp0start_tomcat_helper.bat"
timeout /t 6 /nobreak >nul

:: ---- OPEN BROWSER ----
echo.
echo ============================================
echo   App is running!
echo   Opening: http://localhost:8080/student/
echo ============================================
echo.
start http://localhost:8080/student/

echo Press any key to STOP the server...
pause >nul

:: ---- STOP TOMCAT ----
echo Stopping Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat" >nul 2>&1
echo Done. Goodbye!
timeout /t 2 /nobreak >nul
