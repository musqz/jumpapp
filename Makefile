PREFIX = /usr/local

BIN	= $(DESTDIR)/$(PREFIX)/bin
MAN	= $(DESTDIR)/$(PREFIX)/share/man

VERSION			= 1.2.2
PACKAGE_DIR		= jumpapp-$(VERSION)
PACKAGE_FILE		= jumpapp_$(VERSION).tar.bz2

AUTHOR	= Michael Kropat <mail@michael.kropat.name>
DATE	= Mar 18, 2022
FILES	= t README.md LICENSE.txt Makefile jumpapp jumpappify-desktop-entry

.PHONY: all
all: jumpapp.1

jumpapp.1: README.man.md
	@hash pandoc 2>/dev/null || { echo "ERROR: can't find pandoc. Have you installed it?" >&2; exit 1; }
	pandoc --from=markdown --standalone --output="$@" "$<"

README.man.md: README.md
	echo '% JUMPAPP(1) jumpapp | $(VERSION)' >"$@"
	echo '% $(AUTHOR)' >>"$@"
	echo '% $(DATE)' >>"$@"
	perl -ne 's/^##/#/; print if ! (/^# Installation/ ... /^# /) || /^# (?!Installation)/' "$<" >>"$@"

.PHONY: check test
check: test
test:
	-shellcheck --exclude=SC2016,SC2034 jumpappify-desktop-entry
	-checkbashisms jumpappify-desktop-entry
	t/test_jumpapp

.PHONY: install
install:
	mkdir -p "$(BIN)"
	cp jumpapp jumpappify-desktop-entry "$(BIN)"

	mkdir -p "$(MAN)/man1"
	cp jumpapp.1 "$(MAN)/man1/"

.PHONY: uninstall
uninstall:
	-rm -f "$(BIN)/jumpapp" "$(BIN)/jumpappify-desktop-entry"
	-rm -f "$(MAN)/man1/jumpapp.1"

.PHONY: clean
clean:
	-rm -f README.man.md
	-rm -f jumpapp*.tar.bz2
	-rm -f jumpapp.1


##### make dist #####

.PHONY: dist
dist: $(PACKAGE_FILE)

$(PACKAGE_FILE): $(FILES)
	tar --transform 's,^,$(PACKAGE_DIR)/,S' -cjf "$@" $^
