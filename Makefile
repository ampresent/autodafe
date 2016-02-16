#
# autodafe Makefile.in 
#

prefix		= /usr/local
sysconfdir	= ${prefix}/etc
bindir		= $(prefix)/bin
mandir		= ${datarootdir}/man
datarootdir	= ${prefix}/share

CC		= gcc
#CFLAGS		= -Wall -W -g -O2 -I/usr/include/libxml2
CFLAGS		= -Wall  -g -O2 -I/usr/include/libxml2
LIBS		= -lz -lxml2 -lutil -lpthread -lm 
XML_CFLAGS	= -I/usr/include/libxml2

INSTALL		= /usr/bin/install -c
INSTALL_FILE	= $(INSTALL) -p    -o root -g root -m 644
INSTALL_PROGRAM	= $(INSTALL) -p    -o root -g root -m 755
INSTALL_SCRIPT	= $(INSTALL) -p    -o root -g root -m 755
INSTALL_DIR	= $(INSTALL) -p -d -o root -g root -m 755

default:	all

all: 		autodafe adbg adc pdml2ad 
autodafe:	src/autodafe/debug.o src/autodafe/file.o src/autodafe/dbg.o src/autodafe/output.o src/autodafe/chrono.o src/autodafe/network.o src/autodafe/transmit.o src/autodafe/hash.o src/autodafe/opcode.o src/autodafe/engine.o src/autodafe/autodafe.o
		$(CC) $(CFLAGS) $(LIBS) $^ -o src/autodafe/$@

adbg:		src/adbg/debug.o src/adbg/gdb.o src/adbg/network.o src/adbg/adbg.o
		$(CC) $(CFLAGS) $(LIBS) $^ -o src/adbg/$@

adc:		
		(cd src/adc; ${MAKE})

pdml2ad:	src/pdml2ad/debug.o src/pdml2ad/output.o src/pdml2ad/recover.o src/pdml2ad/xml.o src/pdml2ad/pdml2ad.o
		$(CC) $(CFLAGS) $(LIBS) $^ -o src/pdml2ad/$@ 

scripts:	
		(cd ./etc/generator; ./generator.sh $(prefix)/etc; cd ../..)

clean:
		(cd src/autodafe; rm -f *.o autodafe; cd ../..)
		(cd src/adbg; rm -f *.o adbg; cd ../..)
		(cd src/adc; rm -f *.o adc parser.c parser.h y.output; cd ../..)
		(cd src/pdml2ad; rm -f *.o pdml2ad; cd ../..)


install:	all scripts
		$(INSTALL_PROGRAM) src/autodafe/autodafe $(bindir)
		cp -r ./etc/generator/autodafe $(prefix)/etc
		$(INSTALL_PROGRAM) src/adbg/adbg $(bindir)
		$(INSTALL_PROGRAM) src/adc/adc $(bindir)
		$(INSTALL_PROGRAM) src/pdml2ad/pdml2ad $(bindir)
