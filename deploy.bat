@echo off
REM Student Attendance Management System - Deployment Script
REM This script helps deploy the application using Docker

echo.
echo ================================
echo Student Attendance System
echo Deployment Script
echo ================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not installed or not in PATH
    echo Please install Docker Desktop from https://www.docker.com/products/docker-desktop
    echo.
    pause
    exit /b 1
)

REM Check if Docker Compose is available
docker compose version >nul 2>&1
if errorlevel 1 (
    REM Try docker-compose command
    docker-compose --version >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Docker Compose is not installed
        echo Please install Docker Compose
        pause
        exit /b 1
    )
    set COMPOSE_CMD=docker-compose
) else (
    set COMPOSE_CMD=docker compose
)

echo.
echo Select deployment option:
echo 1. Start application (up)
echo 2. Stop application (down)
echo 3. View logs
echo 4. Rebuild containers
echo 5. Access MySQL CLI
echo 6. View container status
echo 7. Exit
echo.

set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" (
    echo.
    echo Starting application...
    %COMPOSE_CMD% -f docker-compose.deploy.yml up -d
    if errorlevel 0 (
        echo.
        echo Application started successfully!
        echo.
        echo Access points:
        echo - Web Application: http://localhost
        echo - PHPMyAdmin: http://localhost:8080
        echo.
        echo Database Credentials:
        echo - Host: db
        echo - User: attendance_user
        echo - Password: attendance_password
        echo.
    )
    pause
) else if "%choice%"=="2" (
    echo.
    echo Stopping application...
    %COMPOSE_CMD% -f docker-compose.deploy.yml down
    echo Application stopped!
    pause
) else if "%choice%"=="3" (
    echo.
    echo Displaying logs (press Ctrl+C to exit)...
    %COMPOSE_CMD% -f docker-compose.deploy.yml logs -f
    pause
) else if "%choice%"=="4" (
    echo.
    echo Rebuilding containers...
    %COMPOSE_CMD% -f docker-compose.deploy.yml build --no-cache
    echo.
    echo Containers rebuilt!
    pause
) else if "%choice%"=="5" (
    echo.
    echo Connecting to MySQL CLI...
    docker exec -it student_attendance_db mysql -uroot -proot_password
    pause
) else if "%choice%"=="6" (
    echo.
    echo Container Status:
    docker ps -a
    echo.
    pause
) else if "%choice%"=="7" (
    exit /b 0
) else (
    echo Invalid choice!
    pause
    goto start
)

goto start
