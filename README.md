# Project Name

One-line description of the project.

## Setup

### Starting a new project from this template

```bash
git clone https://github.com/ariecav/project-template.git nama-project-baru
cd nama-project-baru
rm -rf .git && git init   # putus dari history template, mulai history baru
```

### Setup environment (new project or existing clone)

```bash
git clone <repo-url>
cd <folder>
./setup.sh
```

## Database (if applicable)

Database files are **not tracked in git** (see `.gitignore`). Each device/environment sets up or generates its own local database. If the connection target (IP/port, remote DB) differs between machines, configure it locally instead of hardcoding it in committed code.

## Notes

- `setup.sh` auto-detects the environment (Termux, WSL, generic Linux, or Windows) and runs the matching steps.
- **On Windows**, run it from **Git Bash** (bundled with Git for Windows) — `.sh` scripts do not run in CMD/PowerShell directly:
  ```bash
  bash setup.sh
  ```
- Edit `setup.sh` per project: keep only the toolchain sections this project needs.
- `.gitattributes` normalizes line endings (LF) across Windows/Linux.
