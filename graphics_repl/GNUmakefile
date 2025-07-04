SMLSHARP_SRCDIR =
ifeq ($(SMLSHARP_SRCDIR),)
SMLSHARP = smlsharp
else
SMLSHARP = $(SMLSHARP_SRCDIR)/src/compiler/smlsharp -B$(SMLSHARP_SRCDIR)/src
endif
SMLFLAGS = -O2

ifeq ($(shell uname),Darwin)
GLLIBS = -Wl,-framework,OpenGL,-framework,GLUT  # for macOS
else
GLLIBS = -lGL -lGLU -lglut  # for Linux
endif

ifneq ($(SMLSHARP_SRCDIR),)
include $(SMLSHARP_SRCDIR)/config.mk
endif
COMPILER_SUPPORT_OBJECTS = $(SMLSHARP_SRCDIR)/src/runtime/signal.o

LIB_SOURCES = \
../graphics/gl.sml \
../graphics/glu.sml \
../graphics/glut.sml \
../graphics/libc.sml \
../graphics/react.sml \
../graphics/graphics.sml \
easytop.sml
BIN_SOURCES = \
compiler.sml

all: smlsharp_graphics_repl

clean:
	-rm -f $(LIB_SOURCES:.sml=.o) $(BIN_SOURCES:.sml=.o)
	-rm -rf smlsharp_graphics_repl

depend:
	@$(SMLSHARP) -MM $(LIB_SOURCES) $(BIN_SOURCES)

.SUFFIXES: .o .sml .smi

.sml.o:
	$(SMLSHARP) $(SMLFLAGS) -c -o $@ $<

smlsharp_graphics_repl: $(LIB_SOURCES:.sml=.o) $(BIN_SOURCES:.sml=.o)
	$(SMLSHARP) $(SMLFLAGS) $(RDYNAMIC_SMLFLAGS) \
	$(COMPILER_SUPPORT_OBJECTS) compiler.smi $(GLLIBS) -o $@

../graphics/gl.o: ../graphics/gl.sml ../graphics/gl.smi
../graphics/glu.o: ../graphics/glu.sml ../graphics/glu.smi
../graphics/glut.o: ../graphics/glut.sml ../graphics/glut.smi
../graphics/libc.o: ../graphics/libc.sml ../graphics/libc.smi
../graphics/react.o: ../graphics/react.sml ../graphics/react.smi
../graphics/graphics.o: ../graphics/graphics.sml ../graphics/gl.smi \
 ../graphics/glu.smi ../graphics/glut.smi ../graphics/libc.smi \
 ../graphics/react.smi ../graphics/graphics.smi
easytop.o: easytop.sml ../graphics/gl.smi ../graphics/glu.smi \
 ../graphics/glut.smi ../graphics/libc.smi ../graphics/react.smi \
 ../graphics/graphics.smi easytop.smi
compiler.o: compiler.sml ../graphics/gl.smi ../graphics/glu.smi \
 ../graphics/glut.smi ../graphics/libc.smi ../graphics/react.smi \
 ../graphics/graphics.smi easytop.smi toplevel.smi compiler.smi
