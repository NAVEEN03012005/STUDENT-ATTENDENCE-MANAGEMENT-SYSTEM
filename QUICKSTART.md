# 🚀 Quick Start Guide - Student Attendance Management System

## In 5 Minutes ⏱️

### Step 1: Install Docker
Download and install Docker Desktop:
- **Windows/Mac**: https://www.docker.com/products/docker-desktop
- **Linux**: Follow your distribution's package manager

### Step 2: Clone Repository
```bash
git clone https://github.com/NAVEEN03012005/STUDENT-ATTENDENCE-MANAGEMENT-SYSTEM.git
cd STUDENT-ATTENDENCE-MANAGEMENT-SYSTEM
```

### Step 3: Start Application
```bash
# Windows
deploy.bat
# Select option 1

# Linux/Mac
chmod +x deploy.sh
./deploy.sh
# Select option 1

# Or use Docker Compose directly
docker-compose -f docker-compose.deploy.yml up -d
```

### Step 4: Access Application
- **Web App**: http://localhost
- **Database Manager**: http://localhost:8080

Done! ✅

---

## 📚 Key Resources

| Resource | Link |
|----------|------|
| Full Documentation | [DEPLOYMENT.md](DEPLOYMENT.md) |
| Deployment Summary | [DEPLOYMENT_SUMMARY.md](DEPLOYMENT_SUMMARY.md) |
| Docker Docs | https://docs.docker.com |
| GitHub Repository | https://github.com/NAVEEN03012005/STUDENT-ATTENDENCE-MANAGEMENT-SYSTEM |

---

## 🔐 Database Credentials

```
Host: db
User: attendance_user
Password: attendance_password
Database: attendancesystem
```

**PHPMyAdmin Access**:
- URL: http://localhost:8080
- User: root
- Password: root_password

---

## 🛑 Stop Application
```bash
docker-compose -f docker-compose.deploy.yml down
```

---

## ⚡ Common Commands

```bash
# View logs
docker-compose -f docker-compose.deploy.yml logs -f

# Access database
docker exec -it student_attendance_db mysql -uroot -proot_password

# Create backup
docker exec student_attendance_db mysqldump -uroot -proot_password attendancesystem > backup.sql

# View containers
docker ps
```

---

## 🎯 User Roles

| Role | Access |
|------|--------|
| Admin | Full system control |
| Class Teacher | Mark attendance |
| Subject Teacher | Manage subjects |
| Student | View records |

---

## 🐛 Need Help?

1. Check [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions
2. View logs: `docker-compose logs`
3. Ensure Docker is running
4. Check ports are not in use (80, 3306, 8080)

---

**Ready to go!** 🎉
