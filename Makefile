# Unix Makefile for XGlk library

# This generates two files. One, of course, is libxglk.a -- the library
# itself. The other is Make.xglk; this is a snippet of Makefile code
# which locates the xglk library and associated libraries (such as
# curses.)
#
# When you install xglk, you must put libxglk.a in the lib directory,
# and glk.h, glkstart.h, and Make.xglk in the include directory.

# --------------------

# Pick a C compiler.
#CC = cc
CC = gcc

PKG = libpng libjpeg x11

CFLAGS = -O -std=c11 -D_XOPEN_SOURCE=600 $(shell pkg-config $(PKG) --cflags) -Wall -Wmissing-prototypes -Wstrict-prototypes -Wno-unused -Wbad-function-cast
LDFLAGS =
LIBS = $(shell pkg-config $(PKG) --libs)

OBJS = main.o xglk.o xglk_vars.o xglk_prefs.o xglk_loop.o xglk_init.o \
  xglk_scrap.o xglk_msg.o xglk_key.o xglk_weggie.o xglk_pict.o \
  xglk_res.o \
  xg_event.o xg_window.o xg_stream.o xg_fileref.o xg_style.o xg_misc.o \
  xg_gestalt.o xg_win_textbuf.o xg_win_textgrid.o xg_win_graphics.o \
  xg_schan.o \
  gi_dispa.o gi_blorb.o

all: libxglk.a Make.xglk

libxglk.a: $(OBJS)
	ar r libxglk.a $(OBJS)
	ranlib libxglk.a

Make.xglk:
	echo LINKLIBS = $(LIBDIRS) $(LIBS) > Make.xglk
	echo GLKLIB = -lxglk >> Make.xglk

$(OBJS): xglk.h xg_internal.h xglk_option.h glk.h gi_dispa.h gi_blorb.h

xg_win_textgrid.o xg_window.o xglk_key.o: xg_win_textgrid.h

xg_win_textbuf.o xg_window.o xglk_key.o: xg_win_textbuf.h

clean:
	-rm -f *~ *.o libxglk.a Make.xglk
