PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
VERSION := 0.01
PKG := cvb-tools

all:
	@echo "Targets: install, check, dist, deb, rpm, clean"

check:
	sh scripts/check-cockpit-v2.sh

install:
	install -d $(DESTDIR)$(BINDIR) $(DESTDIR)$(PREFIX)/local/bin $(DESTDIR)$(MANDIR)/man1
	install -m 0755 bin/mkold $(DESTDIR)$(BINDIR)/mkold
	install -m 0755 bin/cvbl  $(DESTDIR)$(BINDIR)/cvbl
	ln -sf $(BINDIR)/mkold $(DESTDIR)$(PREFIX)/local/bin/mkold || true
	ln -sf $(BINDIR)/cvbl  $(DESTDIR)$(PREFIX)/local/bin/cvbl || true
	install -m 0644 man/mkold.1 $(DESTDIR)$(MANDIR)/man1/mkold.1

dist:
	tar -czf ../$(PKG)-v$(VERSION).tar.gz .

deb:
	debuild -us -uc -b

rpm:
	@mkdir -p packaging/rpm
	@echo "Run rpmbuild manually pointing to tarball or craft a spec here."

clean:
	rm -f ../$(PKG)-v$(VERSION).tar.gz
