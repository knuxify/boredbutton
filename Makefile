PREFIX ?= /usr
MANDIR ?= $(PREFIX)/share/man

all:
	@echo To install boredbutton, run 'sudo make install'.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@cp -p bored $(DESTDIR)$(PREFIX)/bin/bored
	@cp -p boredconf $(DESTDIR)$(PREFIX)/bin/boredconf
	@cp -p bored.1 $(DESTDIR)$(MANDIR)/man1
	@cp -p boredconf.1 $(DESTDIR)$(MANDIR)/man1
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/bored
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/boredconf

ideainstall:
	@mkdir -p $(HOME)/.config/bored
	@cp -fp ideas $(HOME)/.config/bored/

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/bored
	@rm -rf $(DESTDIR)$(PREFIX)/bin/boredconf
	@rm -rf $(DESTDIR)$(MANDIR)/man1/bored.1*
	@rm -rf $(DESTDIR)$(MANDIR)/man1/boredconf.1*
	@echo To remove configs, remove the \~/config/bored directory.
