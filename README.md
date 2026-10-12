# cvb-tools v0.01

**cvb-tools** is a collection of small utilities by **cloudvBOX Computing Ltda** to help Linux admins.

Included tools:
- **mkold** (v0.02): quick backups/restore for files or directories with timestamped archives
- **cvbl** (v0.01): cloudvBOX ASCII banner

## Install (generic)
```bash
sudo ./install.sh
```

## Build packages
```bash
# Tarball
make dist

# Debian .deb
make deb

# RPM
make rpm
```

## APT publication
Use the provided GitHub Actions workflow (`.github/workflows/release.yml`) or follow the on-prem steps
we documented in the repository to publish to an APT repository (signed with GPG) and serve via nginx.

## Cockpit v2
The only UI here (`index.html`, the public APT/YUM page) follows the cloudvBOX DS v2 palette (graphite +
accent-ink `#3FD1B9` / `#0E6E66`, replacing the v1 cyan `#55FCFF` and teal `#006D6F`). The tools themselves have no
relation to the Cockpit beyond the visual identity. Details, palette and open decisions (in Portuguese):
[`docs/cockpit-v2.md`](docs/cockpit-v2.md). Gate: `make check` (`scripts/check-cockpit-v2.sh`).

## License
MIT © cloudvBOX Computing Ltda
