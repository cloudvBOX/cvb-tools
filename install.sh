#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Installing cvb-tools..."

# deps
DEPS=(tar gzip coreutils findutils bash sqlite3)
if command -v apt >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y "${DEPS[@]}" || true
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y sqlite coreutils findutils tar gzip || true
fi

# install to /usr/bin and symlink to /usr/local/bin
sudo install -d /usr/bin /usr/local/bin /usr/share/man/man1
sudo install -m 0755 bin/mkold /usr/bin/mkold
sudo install -m 0755 bin/cvbl /usr/bin/cvbl
sudo ln -sf /usr/bin/mkold /usr/local/bin/mkold
sudo ln -sf /usr/bin/cvbl /usr/local/bin/cvbl

# man page
sudo install -m 0644 man/mkold.1 /usr/share/man/man1/mkold.1 || true
echo "[OK] Installed. Try 'mkold --help'"
