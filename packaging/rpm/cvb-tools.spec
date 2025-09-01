Name:           cvb-tools
Version:        0.01
Release:        1%{?dist}
Summary:        cloudvBOX Linux admin tools
License:        MIT
URL:            https://github.com/cloudvBOX/cvb-tools
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash, coreutils, tar, gzip, findutils, sqlite

%description
Small helpers for Linux admins (mkold, cvbl).

%prep
%setup -q

%build
# no build

%install
mkdir -p %{buildroot}/usr/bin %{buildroot}/usr/local/bin %{buildroot}/usr/share/man/man1
install -m 0755 bin/mkold %{buildroot}/usr/bin/mkold
install -m 0755 bin/cvbl  %{buildroot}/usr/bin/cvbl
ln -s /usr/bin/mkold %{buildroot}/usr/local/bin/mkold
ln -s /usr/bin/cvbl  %{buildroot}/usr/local/bin/cvbl
install -m 0644 man/mkold.1 %{buildroot}/usr/share/man/man1/mkold.1

%files
/usr/bin/mkold
/usr/bin/cvbl
/usr/local/bin/mkold
/usr/local/bin/cvbl
/usr/share/man/man1/mkold.1

%changelog
* Thu Aug 28 2025 cloudvBOX <opensource@cloudvbox.com> - 0.01-1
- Initial package
