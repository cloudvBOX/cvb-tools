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

## License
MIT © cloudvBOX Computing Ltda
