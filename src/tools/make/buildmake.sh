#! /bin/sh
#	$NetBSD: buildmake.sh.in,v 1.8 2006/08/26 22:17:48 christos Exp $
#
# buildmake.sh.in - Autoconf-processed shell script for building make(1).
#

: ${HOST_CC="gcc"}
: ${HOST_CFLAGS=" -g -O2"}
: ${HOST_LDFLAGS=" "}
: ${runcmd=""}

docmd () {
	echo "$1"
	$1 || exit 1
}

MKSRCDIR=./../../usr.bin/make

for f in $MKSRCDIR/*.c $MKSRCDIR/lst.lib/*.c; do
	docmd "${HOST_CC} ${HOST_CFLAGS} -DDEFSHELL_CUSTOM=\"/bin/sh\" -DHAVE_SETENV=1 -DHAVE_STRDUP=1 -DHAVE_STRERROR=1 -DHAVE_STRFTIME=1 -DHAVE_VSNPRINTF=1  -c $f"
done

docmd "${HOST_CC} ${HOST_CFLAGS} -o ${_TOOL_PREFIX:-nb}make *.o ${HOST_LDFLAGS}"
