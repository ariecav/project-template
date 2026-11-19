# Project Name

One-line description of the project.

## Setup

```bash
git clone <repo-url>
cd <folder>
./setup.sh
```

## Database (if applicable)

Database files are **not tracked in git** (see `.gitignore`). Each device/environment sets up or generates its own local database. If the connection target (IP/port, remote DB) differs between machines, configure it locally instead of hardcoding it in committed code.

## Notes

- Edit `setup.sh` per project: keep only the toolchain sections this project needs.
- `.gitattributes` normalizes line endings (LF) across Windows/Linux.
