
## Auto Shutdown
Automatically shut down the system **if it remains in sleep (suspend mode) for more than 2.5 hours**.

---

Instead, this solution:
1. Schedules a hardware timer (RTC wake) at the moment system sleeps  
2. If the user does not wake it manually before that time  
3. System wakes automatically  
4. Shutdown happens immediately  

---

## 🔧 Installation Steps

### 1. Create script (run as root or with sudo)
```bash
sudo nano /lib/systemd/system-sleep/auto_shutdown.sh
```

### 2. Make it executable
```bash
sudo chmod +x /lib/systemd/system-sleep/auto_shutdown.sh
```
