#!/bin/bash

# Student Attendance Management System - Deployment Script
# This script helps deploy the application using Docker

clear

echo "================================"
echo "Student Attendance System"
echo "Deployment Script"
echo "================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed or not in PATH"
    echo "Please install Docker from https://www.docker.com/"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "ERROR: Docker Compose is not installed"
    echo "Please install Docker Compose"
    exit 1
fi

# Determine compose command
if command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    COMPOSE_CMD="docker compose"
fi

echo ""
echo "Select deployment option:"
echo "1. Start application (up)"
echo "2. Stop application (down)"
echo "3. View logs"
echo "4. Rebuild containers"
echo "5. Access MySQL CLI"
echo "6. View container status"
echo "7. Create database backup"
echo "8. Restore from backup"
echo "9. Exit"
echo ""

read -p "Enter your choice (1-9): " choice

case $choice in
    1)
        echo ""
        echo "Starting application..."
        $COMPOSE_CMD -f docker-compose.deploy.yml up -d
        if [ $? -eq 0 ]; then
            echo ""
            echo "Application started successfully!"
            echo ""
            echo "Access points:"
            echo "- Web Application: http://localhost"
            echo "- PHPMyAdmin: http://localhost:8080"
            echo ""
            echo "Database Credentials:"
            echo "- Host: db"
            echo "- User: attendance_user"
            echo "- Password: attendance_password"
            echo ""
        fi
        ;;
    2)
        echo ""
        echo "Stopping application..."
        $COMPOSE_CMD -f docker-compose.deploy.yml down
        echo "Application stopped!"
        ;;
    3)
        echo ""
        echo "Displaying logs (press Ctrl+C to exit)..."
        $COMPOSE_CMD -f docker-compose.deploy.yml logs -f web
        ;;
    4)
        echo ""
        echo "Rebuilding containers..."
        $COMPOSE_CMD -f docker-compose.deploy.yml build --no-cache
        echo ""
        echo "Containers rebuilt!"
        ;;
    5)
        echo ""
        echo "Connecting to MySQL CLI..."
        docker exec -it student_attendance_db mysql -uroot -proot_password
        ;;
    6)
        echo ""
        echo "Container Status:"
        docker ps -a | grep student_attendance
        echo ""
        ;;
    7)
        echo ""
        BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"
        echo "Creating backup to $BACKUP_FILE..."
        docker exec student_attendance_db mysqldump -uroot -proot_password attendancesystem > "$BACKUP_FILE"
        echo "Backup created successfully!"
        ;;
    8)
        echo ""
        read -p "Enter backup filename to restore: " backup_file
        if [ -f "$backup_file" ]; then
            echo "Restoring from $backup_file..."
            docker exec -i student_attendance_db mysql -uroot -proot_password attendancesystem < "$backup_file"
            echo "Restore completed!"
        else
            echo "Error: Backup file not found!"
        fi
        ;;
    9)
        exit 0
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
