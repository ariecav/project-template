#!/usr/bin/env bash
set -euo pipefail

# --- 0. Detect environment ---
detect_env() {
  case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
    Linux)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      elif [ -n "${PREFIX:-}" ] && [[ "$PREFIX" == *com.termux* ]]; then
        echo "termux"
      else
        echo "linux"
      fi
      ;;
    *) echo "unknown" ;;
  esac
}
ENV_TYPE=$(detect_env)
echo "== project setup (detected: $ENV_TYPE) =="

# --- 1. System packages ---
# Edit the apt package list per project (e.g. add libsqlite3-dev, libssl-dev, etc).
case "$ENV_TYPE" in
  termux|wsl|linux)
    if command -v apt >/dev/null 2>&1; then
      sudo apt update
      sudo apt install -y build-essential pkg-config curl
    else
      echo "apt not found - install build tools manually" >&2
    fi
    ;;
  windows)
    if command -v winget >/dev/null 2>&1; then
      winget install --id Git.Git -e --silent || true
    else
      echo "winget not found - install build tools (Visual Studio Build Tools, etc) manually" >&2
    fi
    ;;
  *)
    echo "Unknown environment - install build tools manually" >&2
    ;;
esac

# --- 2. Toolchain (pick what this project needs, delete the rest) ---

# Rust
if [ -f Cargo.toml ] && ! command -v cargo >/dev/null 2>&1; then
  if [ "$ENV_TYPE" = "windows" ]; then
    echo "Installing Rust (rustup-init.exe)..."
    curl -o /tmp/rustup-init.exe https://win.rustup.rs/x86_64
    /tmp/rustup-init.exe -y
  else
    echo "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
fi

# Node
if [ -f package.json ] && command -v npm >/dev/null 2>&1; then
  npm install
fi

# Python
if [ -f requirements.txt ] && command -v pip >/dev/null 2>&1; then
  pip install -r requirements.txt
fi

# --- 3. Build ---
if [ -f Cargo.toml ]; then
  cargo build
fi

echo "== setup complete ($ENV_TYPE) =="
