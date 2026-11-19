#!/usr/bin/env bash
set -euo pipefail

echo "== project setup =="

# --- 1. System packages ---
# Edit this list per project (e.g. add libsqlite3-dev, libssl-dev, etc).
if command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y build-essential pkg-config curl
else
  echo "apt not found - install build tools manually" >&2
fi

# --- 2. Toolchain (pick what this project needs, delete the rest) ---

# Rust
if [ -f Cargo.toml ] && ! command -v cargo >/dev/null 2>&1; then
  echo "Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
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

echo "== setup complete =="
