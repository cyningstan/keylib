# ======================================================================
# KeyLib
# A keyboard handler for DOS games.
#
# Copyright (C) Damian Gareth Walker 2021.
#
# Makefile.

# Directories
BINDIR = bin
SRCDIR = src
INCDIR = inc
DOCDIR = doc
OBJDIR = obj
OMSDIR = $(OBJDIR)/ms
OMMDIR = $(OBJDIR)/mm
OMCDIR = $(OBJDIR)/mc
OMLDIR = $(OBJDIR)/ml
OMHDIR = $(OBJDIR)/mh
TGTDIR = keylib

# Tool commands and their options
CC = wcc
LIB = wlib
LD = wcl
COPTS = -q -0 -W4 -I=$(INCDIR)
LOPTS = -q
!ifdef __LINUX__
CP = cp
!else
CP = copy
!endif

# Whole project
all : &
	$(TGTDIR)/demo.exe &
	$(TGTDIR)/key-ms.lib &
	$(TGTDIR)/key-mm.lib &
	$(TGTDIR)/key-mc.lib &
	$(TGTDIR)/key-ml.lib &
	$(TGTDIR)/key-mh.lib &
	$(TGTDIR)/keylib.h &
	$(TGTDIR)/keylib.txt

# Executables
$(TGTDIR)/demo.exe : $(OMSDIR)/demo.o $(TGTDIR)/key-ms.lib
	$(LD) $(LOPTS) -fe=$@ $<

# Libraries
$(TGTDIR)/key-ms.lib : &
	$(OMSDIR)/keylib.o
	$(LIB) $(LIBOPTS) $@ +-$(OMSDIR)/keylib.o
$(TGTDIR)/key-mm.lib : &
	$(OMMDIR)/keylib.o
	$(LIB) $(LIBOPTS) $@ +-$(OMMDIR)/keylib.o
$(TGTDIR)/key-mc.lib : &
	$(OMCDIR)/keylib.o
	$(LIB) $(LIBOPTS) $@ +-$(OMCDIR)/keylib.o
$(TGTDIR)/key-ml.lib : &
	$(OMLDIR)/keylib.o
	$(LIB) $(LIBOPTS) $@ +-$(OMLDIR)/keylib.o
$(TGTDIR)/key-mh.lib : &
	$(OMHDIR)/keylib.o
	$(LIB) $(LIBOPTS) $@ +-$(OMHDIR)/keylib.o

# Header files in target directory
$(TGTDIR)/keylib.h : $(INCDIR)/keylib.h
	$(CP) $< $@

# Documentation in target directory
$(TGTDIR)/keylib.txt : $(DOCDIR)/keylib.txt
	$(CP) $< $@

# Object files for the demonstration
$(OMSDIR)/demo.o : $(SRCDIR)/demo.c $(INCDIR)/keylib.h
	$(CC) $(COPTS) -ms -fo=$@ $[@

# Object files for the library module
$(OMSDIR)/keylib.o : $(SRCDIR)/keylib.c $(INCDIR)/keylib.h
	$(CC) $(COPTS) -ms -fo=$@ $[@
$(OMMDIR)/keylib.o : $(SRCDIR)/keylib.c $(INCDIR)/keylib.h
	$(CC) $(COPTS) -mm -fo=$@ $[@
$(OMCDIR)/keylib.o : $(SRCDIR)/keylib.c $(INCDIR)/keylib.h
	$(CC) $(COPTS) -mc -fo=$@ $[@
$(OMLDIR)/keylib.o : $(SRCDIR)/keylib.c $(INCDIR)/keylib.h
	$(CC) $(COPTS) -ml -fo=$@ $[@
$(OMHDIR)/keylib.o : $(SRCDIR)/keylib.c $(INCDIR)/keylib.h
	$(CC) $(COPTS) -mh -fo=$@ $[@
