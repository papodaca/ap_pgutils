PG_HOME=	/usr/local/postgres64
PG_BIN=		$(PG_HOME)/bin/postgres

MODULE_big=	ap_pgutils
OBJS=		ap_pgutils.o
SHLIB_LINK=	-L argon2 -largon2
DATA=		ap_pgutils.sql
EXTRA_CLEAN=	argon2

#COMMON_CFLAGS=	-g -O3
COMMON_CFLAGS=	-g -O0

PG_CPPFLAGS=	$(COMMON_CFLAGS) -Iargon2/include

PG_CONFIG = $(PG_HOME)/bin/pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

ap_pgutils.o:: argon2/libargon2.a

argon2:
	git clone -b nothreads https://github.com/Apsalar/phc-winner-argon2 argon2

ARGON_CFLAGS=	-fPIC -D_REENTRANT \
		-std=c89 -pthread $(COMMON_CPPFLAGS) -Wall -Iinclude -Isrc
argon2/libargon2.a: argon2
	(cd argon2; $(MAKE) CC=gcc LIB_EXT=a CFLAGS="$(ARGON_CFLAGS)" libargon2.a)

PGT=	|$(PG_BIN) --single -D testdata postgres
test: ap_pgutils.so
	-@printf '\033[1;31m%s\033[0m\n' 'init DB'
	-rm -rf testdata
	$(PG_HOME)/bin/initdb testdata >/dev/null 2>&1
	-@printf '\033[1;31m%s\033[0m\n' 'load extension'
	tr '\n' ' ' < ap_pgutils.sql|sed -e s@.libdir@`pwd`@g$(PGT)
	@echo ""
	-@printf '\033[1;31m%s\033[0m\n' 'test extension'
	echo 'select gethostname();'$(PGT)
	echo "select argon2('password', 'somesalt', 2, 16, 24, 'i');"$(PGT)
	echo "select argon2('password', 'somesalt', 2, 16, 24, 'i', 4);"$(PGT)
