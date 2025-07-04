SMLSHARP = smlsharp
SMLFLAGS = -O2

ifeq ($(shell uname),Darwin)
LIBS = -Wl,-framework,OpenGL,-framework,GLUT  # for macOS
else
LIBS = -lGL -lGLU -lglut  # for Linux
endif

all: main
main: graphics/gl.smi graphics/glu.smi graphics/glut.smi graphics/libc.smi \
 graphics/react.smi graphics/graphics.smi graphics.smi main.smi graphics/gl.o \
 graphics/glu.o graphics/glut.o graphics/libc.o graphics/react.o \
 graphics/graphics.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
graphics/gl.o: graphics/gl.sml graphics/gl.smi
	$(SMLSHARP) $(SMLFLAGS) -o graphics/gl.o -c graphics/gl.sml
graphics/glu.o: graphics/glu.sml graphics/glu.smi
	$(SMLSHARP) $(SMLFLAGS) -o graphics/glu.o -c graphics/glu.sml
graphics/glut.o: graphics/glut.sml graphics/glut.smi
	$(SMLSHARP) $(SMLFLAGS) -o graphics/glut.o -c graphics/glut.sml
graphics/libc.o: graphics/libc.sml graphics/libc.smi
	$(SMLSHARP) $(SMLFLAGS) -o graphics/libc.o -c graphics/libc.sml
graphics/react.o: graphics/react.sml graphics/react.smi
	$(SMLSHARP) $(SMLFLAGS) -o graphics/react.o -c graphics/react.sml
graphics/graphics.o: graphics/graphics.sml graphics/gl.smi graphics/glu.smi \
 graphics/glut.smi graphics/libc.smi graphics/react.smi graphics/graphics.smi
	$(SMLSHARP) $(SMLFLAGS) -o graphics/graphics.o -c graphics/graphics.sml
main.o: main.sml graphics/gl.smi graphics/glu.smi graphics/glut.smi \
 graphics/libc.smi graphics/react.smi graphics/graphics.smi graphics.smi \
 main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
