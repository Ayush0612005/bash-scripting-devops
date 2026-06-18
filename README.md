# 🐚 Bash Scripting for DevOps

A collection of Bash scripts written while learning shell scripting for DevOps. Covers system monitoring, automation, user management, and utilities — all practical, real-world patterns used in DevOps workflows.

---

## 📁 Repository Structure

```
bash-scripting-devops/
├── system-monitoring/
│   ├── cpu_memory_monitor.sh     # Monitor CPU and RAM usage with alerts
│   └── disk_space_monitor.sh     # Check disk usage across all partitions
│
├── file-log-automation/
│   ├── log_cleanup.sh            # Delete log files older than N days
│   └── backup_files.sh           # Create timestamped compressed backups
│
├── user-management/
│   ├── create_user.sh            # Create a new Linux user with group
│   └── list_users.sh             # List all non-system users on the machine
│
└── utilities/
    └── system_info.sh            # Print full system summary
```

---

## 🚀 How to Run Any Script

**1. Clone the repo**
```bash
git clone https://github.com/Ayush0612005/bash-scripting-devops.git
cd bash-scripting-devops
```

**2. Make a script executable**
```bash
chmod +x script-name.sh
```

**3. Run it**
```bash
bash script-name.sh
# or
./script-name.sh
```

---

## 📂 Script Details

### 🖥️ System Monitoring

| Script | Description | Usage |
|--------|-------------|-------|
| `cpu_memory_monitor.sh` | Shows current CPU & RAM usage. Triggers an alert if either exceeds 80% | `bash cpu_memory_monitor.sh` |
| `disk_space_monitor.sh` | Lists disk usage for all partitions. Alerts if any exceeds 80% | `bash disk_space_monitor.sh` |

---

### 📄 File & Log Automation

| Script | Description | Usage |
|--------|-------------|-------|
| `log_cleanup.sh` | Deletes `.log` files older than N days in a given directory | `bash log_cleanup.sh /path/to/logs 7` |
| `backup_files.sh` | Creates a `.tar.gz` backup of a directory with a timestamp | `bash backup_files.sh /source /destination` |

---

### 👤 User Management

| Script | Description | Usage |
|--------|-------------|-------|
| `create_user.sh` | Creates a new Linux user, assigns a group, and sets a password | `sudo bash create_user.sh username groupname` |
| `list_users.sh` | Lists all non-system users with home directory and shell info | `bash list_users.sh` |

---

### 🛠️ Utilities

| Script | Description | Usage |
|--------|-------------|-------|
| `system_info.sh` | Displays hostname, OS, kernel, CPU, RAM, disk, uptime, and IP | `bash system_info.sh` |

---

## 🧠 Concepts Covered

- Variables, conditionals, loops, and functions
- Reading and parsing files (`/etc/passwd`, `/proc/cpuinfo`)
- Working with common tools: `awk`, `grep`, `sed`, `find`, `df`, `free`, `top`
- Exit codes and error handling
- Command-line arguments (`$1`, `$2`)
- `find` with `-mtime` for time-based file operations
- User and group management via `useradd`, `groupadd`, `passwd`

---

## 🗺️ Learning Roadmap

This repo is part of my DevOps learning journey:

```
Linux → Git/GitHub → Bash ✅ → Docker → Kubernetes → CI/CD → Terraform
```

**Next up:** Docker — containerizing applications and writing Dockerfiles.

---

## 👨‍💻 Author

**Ayush Kulshreshtha**
- GitHub: [@Ayush0612005](https://github.com/Ayush0612005)
- B.Tech CSE @ SRM Institute of Science and Technology (2025–2029)
