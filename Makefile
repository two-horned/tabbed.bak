# tabbed - tabbing interface
# See LICENSE file for copyright and license details.

include config.mk

SRC = tabbed.c xembed.c
OBJ = ${SRC:.c=.o}
BIN = ${OBJ:.o=}

all: options ${BIN}

options:
	@echo tabbed build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

.o:
	@echo CC -o $@
	@${CC} -o $@ $< ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f ${BIN} ${OBJ} tabbed-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p tabbed-${VERSION}
	@cp -R LICENSE Makefile README config.def.h config.mk \
		tabbed.1 arg.h ${SRC} tabbed-${VERSION}
	@tar -cf tabbed-${VERSION}.tar tabbed-${VERSION}
	@gzip tabbed-${VERSION}.tar
	@rm -rf tabbed-${VERSION}

install: all
	@echo installing executable files to ${BINPREFIX}
	@mkdir -p "${BINPREFIX}"
	@cp -f ${BIN} "${BINPREFIX}"
	@chmod 700 "${BINPREFIX}/tabbed"
	@echo installing manual pages to ${MANPREFIX}/man1
	@mkdir -p "${MANPREFIX}/man1"
	@sed "s/VERSION/${VERSION}/g" < tabbed.1 > "${MANPREFIX}/man1/tabbed.1"
	@chmod 600 "${MANPREFIX}/man1/tabbed.1"
	@sed "s/VERSION/${VERSION}/g" < xembed.1 > "${MANPREFIX}/man1/xembed.1"
	@chmod 600 "${MANPREFIX}/man1/xembed.1"

uninstall:
	@echo removing executable files from ${BINPREFIX}
	@rm -f "${BINPREFIX}/tabbed"
	@rm -f "${BINPREFIX}/xembed"
	@echo removing manual pages from ${MANPREFIX}/man1
	@rm -f "${MANPREFIX}/man1/tabbed.1"
	@rm -f "${MANPREFIX}/man1/xembed.1"

.PHONY: all options clean dist install uninstall
