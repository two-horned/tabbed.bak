# tabbed version
VERSION = 0.6

# Customize below to fit your system

# paths
PREFIX = /usr/local
BINPREFIX = ~/.local/bin
MANPREFIX = ~/.local/man

X11INC = ${PREFIX}/include
X11LIB = ${PREFIX}/lib

# freetype
FREETYPELIBS = -lfontconfig -lXft
# OpenBSD (uncomment)
FREETYPEINC = ${X11INC}/freetype2

# includes and libs
INCS = -I. -I/usr/include -I$(X11INC) -I${FREETYPEINC}
LIBS = -L/usr/lib -lc -L${X11LIB} -lX11 ${FREETYPELIBS} -lXrender

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -D_DEFAULT_SOURCE
CFLAGS = -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS = -s ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
