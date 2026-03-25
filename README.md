# oss-audit-[24MIP10181]

**Open Source Audit — Capstone Project**
Course: Open Source Software | VITyarthi
Student: Ansh Choubey | Roll Number: 24MIP10181
Software Audited: **Python** (PSF License)

---

## About This Project

This repository is part of the Open Source Software capstone project. The audit examines Python — its origin, license, Linux footprint, ecosystem, and comparison with proprietary alternatives. Five shell scripts demonstrate practical Linux and shell scripting skills covered in Units 1–5 of the course.

---

## Repository Structure

```
oss-audit-[rollnumber]/
├── README.md                          ← This file
├── script1_system_identity.sh         ← System welcome screen
├── script2_package_inspector.sh       ← FOSS package checker
├── script3_disk_permission_auditor.sh ← Directory permissions & disk usage
├── script4_log_analyzer.sh            ← Log file keyword analyzer
└── script5_manifesto_generator.sh     ← Interactive manifesto generator
```

---

## Scripts Overview

### Script 1 — System Identity Report
Displays a formatted welcome screen showing the Linux distribution, kernel version, logged-in user, home directory, system uptime, current date/time, and a note about the OS license.

**Concepts used:** Variables, `echo`, command substitution `$()`, string formatting, `uname`, `whoami`, `uptime`, `date`, `hostname`.

---

### Script 2 — FOSS Package Inspector
Checks whether Python (`python3`) is installed on the system, displays its version and license information, and uses a `case` statement to print a philosophy note about the chosen package and several others.

**Concepts used:** `if-then-else`, `case` statement, `rpm -qi` / `dpkg -s`, pipe with `grep`, `command -v`.

---

### Script 3 — Disk and Permission Auditor
Loops through a list of important Linux system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/usr/lib`, `/var`) and reports permissions, ownership, and disk usage for each. Also checks Python's specific installation directories.

**Concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, directory existence check with `[ -d ]`.

---

### Script 4 — Log File Analyzer
Reads a log file line by line, counts how many lines contain a specified keyword (default: `error`), and prints a summary with the last 5 matching lines. Includes a retry loop if the file is missing or empty.

**Concepts used:** `while read` loop, `if-then`, counter variables, command-line arguments (`$1`, `$2`), arrays, do-while style retry logic, `grep -iq`.

**Usage:**
```bash
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/messages WARNING
```

---

### Script 5 — Open Source Manifesto Generator
Asks the user three interactive questions and generates a personalised open source philosophy statement using their answers. Saves the output to a timestamped `.txt` file.

**Concepts used:** `read` for user input, string concatenation (`+=`), `>` and `>>` for file writing, `cat`, `date`, `whoami`, aliases (demonstrated with comments), input validation loop.

---

## How to Run the Scripts on Linux

### Step 1 — Clone the repository
```bash
git clone https://github.com/[your-github-username]/oss-audit-[rollnumber].git
cd oss-audit-[rollnumber]
```

### Step 2 — Make all scripts executable
```bash
chmod +x *.sh
```

### Step 3 — Run each script

**Script 1:**
```bash
./script1_system_identity.sh
```

**Script 2:**
```bash
./script2_package_inspector.sh
```

**Script 3:**
```bash
./script3_disk_permission_auditor.sh
```

**Script 4** (requires a log file path as argument):
```bash
./script4_log_analyzer.sh /var/log/syslog error
# On RHEL/Fedora:
./script4_log_analyzer.sh /var/log/messages error
# To search for a different keyword:
./script4_log_analyzer.sh /var/log/syslog python
```

**Script 5:**
```bash
./script5_manifesto_generator.sh
```
> Script 5 is interactive — it will ask you three questions and save your manifesto to a `.txt` file in the current directory.

---

## Dependencies

| Dependency | Purpose | Install command |
|------------|---------|-----------------|
| `bash` | Run all scripts | Pre-installed on all Linux distros |
| `python3` | Inspected by Script 2 | `sudo apt install python3` or `sudo dnf install python3` |
| `rpm` or `dpkg` | Package info in Script 2 | Pre-installed (distro-dependent) |
| `awk` | Field extraction in Scripts 1, 3 | Pre-installed (part of `gawk`) |
| `grep` | Pattern matching in Scripts 2, 4 | Pre-installed on all Linux distros |

All scripts are written in standard POSIX-compatible bash and use only tools available by default on any mainstream Linux distribution (Ubuntu, Fedora, Debian, RHEL, CentOS).

---

## Tested On

- Ubuntu 22.04 LTS
- Fedora 39
- Debian 12

---

## License

These scripts are released under the **MIT License** — use, modify, and share freely with attribution.

---

*VITyarthi | Open Source Software Course | Capstone Project*
