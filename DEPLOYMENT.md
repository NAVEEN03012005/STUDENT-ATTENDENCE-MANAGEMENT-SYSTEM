# Student Attendance Management System - Deployment Guide

## Quick Start with Docker

### Prerequisites
- Docker and Docker Compose installed on your system
- Git (for cloning the repository)

### Deployment Steps

#### 1. **Using Docker Compose (Recommended)**

```bash
cd Student-Attendance-System
docker-compose -f docker-compose.deploy.yml up -d
```

This will start:
- **Web Server**: Apache + PHP on `http://localhost`
- **Database**: MySQL on `localhost:3306`
- **PHPMyAdmin**: Database management tool on `http://localhost:8080`

#### 2. **Access the Application**

- **Web Application**: http://localhost
- **PHPMyAdmin**: http://localhost:8080
  - Username: `root`
  - Password: `root_password`

#### 3. **Database Credentials**

```
Database Host: db
Database Name: attendancesystem
Database User: attendance_user
Database Password: attendance_password
MySQL Root Password: root_password
```

### Default Login Credentials

After database initialization, use these credentials:

- **Admin**: Default username/password (check database)
- **Class Teacher**: Default username/password (check database)
- **Subject Teacher**: Default username/password (check database)
- **Student**: Default username/password (check database)

### File Structure

```
Student-Attendance-System/
├── Admin/                    # Admin Dashboard
├── ClassTeacher/             # Class Teacher Module
├── SubjectTeacher/           # Subject Teacher Module
├── Student/                  # Student Module
├── DATABASE FILE/            # Database setup files
├── Includes/                 # Shared PHP files (dbcon.php, session.php)
├── TCPDF/                    # PDF generation library
├── vendor/                   # Composer dependencies
├── docker-compose.deploy.yml # Docker deployment configuration
└── README.md                 # Documentation
```

### Key Features

✅ **User Roles**:
- Admin (Full System Control)
- Class Teachers (Mark Attendance)
- Subject Teachers (Manage Subjects)
- Students (View Records)

✅ **Features**:
- Attendance Marking & Tracking
- Student Management
- Class & Subject Management
- PDF Report Generation
- Session & Term Management
- User Authentication & Authorization
- CSRF Protection
- Session Management (30-minute timeout)
- Password Hashing (bcrypt)

### Stopping the Application

```bash
docker-compose -f docker-compose.deploy.yml down
```

### Viewing Logs

```bash
docker-compose -f docker-compose.deploy.yml logs -f web
```

### Database Management

To access MySQL container:
```bash
docker exec -it student_attendance_db mysql -uroot -proot_password
```

To backup database:
```bash
docker exec student_attendance_db mysqldump -uroot -proot_password attendancesystem > backup.sql
```

### Environment Configuration

Edit the following in `docker-compose.deploy.yml` to change:
- Database credentials
- MySQL root password
- Port mappings

### Troubleshooting

**Port Already in Use**:
```bash
# Change ports in docker-compose.deploy.yml
# e.g., change "80:80" to "8000:80"
```

**Database Connection Error**:
1. Ensure MySQL container is running: `docker ps`
2. Check logs: `docker-compose logs db`
3. Verify hostname is `db` (not localhost)

**Permission Issues**:
```bash
docker-compose exec -u root web chown -R www-data:www-data /var/www/html
```

### Production Deployment Considerations

For production deployment:
1. Update `MYSQL_ROOT_PASSWORD` and `MYSQL_PASSWORD` to strong values
2. Use environment file: Create `.env` file for secrets
3. Set up HTTPS with SSL certificates
4. Configure backup strategies
5. Use health checks
6. Implement monitoring and logging
7. Set resource limits

### Support & Documentation

For more information, refer to:
- [PHP Official Documentation](https://www.php.net/manual/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Docker Documentation](https://docs.docker.com/)
