structure GL =
struct

  type float = Real32.real
  val glClearColor =
      _import "glClearColor"
      : (float, float, float, float) -> ()
  val glEnable =
      _import "glEnable"
      : word -> ()
  val glFrontFace =
      _import "glFrontFace"
      : word -> ()
  val glLightfv =
      _import "glLightfv"
      : (word, word, float * float * float * float) -> ()
  val glClear =
      _import "glClear"
      : word -> ()
  val glFlush =
      _import "glFlush"
      : () -> ()
  val glViewport =
      _import "glViewport"
      : (int, int, int, int) -> ()
  val glLoadIdentity =
      _import "glLoadIdentity"
      : () -> ()
  val glMatrixMode =
      _import "glMatrixMode"
      : word -> ()
  val glPushMatrix =
      _import "glPushMatrix"
      : () -> ()
  val glPopMatrix =
      _import "glPopMatrix"
      : () -> ()
  val glRotated =
      _import "glRotated"
      : (real, real, real, real) -> ()
  val glTranslated =
      _import "glTranslated"
      : (real, real, real) -> ()
  val glMaterialfv =
      _import "glMaterialfv"
      : (word, word, float * float * float * float) -> ()
  val glMaterialiv =
      _import "glMaterialiv"
      : (word, word, int * int * int * int) -> ()
  val glBegin =
      _import "glBegin"
      : word -> ()
  val glEnd =
      _import "glEnd"
      : () -> ()
  val glNormal3dv =
      _import "glNormal3dv"
      : (real * real * real) -> ()
  val glVertex3dv =
      _import "glVertex3dv"
      : (real * real * real) -> ()
  val glVertex2d =
      _import "glVertex2d"
      : (real, real) -> ()
  val glVertex3d =
      _import "glVertex3d"
      : (real, real, real) -> ()
  val glCullFace =
      _import "glCullFace"
      : word -> ()
  val glColor4i =
      _import "glColor4i"
      : (word, word, word, word) -> ()
  val glColor3d =
      _import "glColor3d"
      : (real, real, real) -> ()
  val glColor4f =
      _import "glColor4f"
      : (float, float, float, float) -> ()
  val glColor4fv =
      _import "glColor4fv"
      : (float * float * float * float) -> ()
  val glColor4d =
      _import "glColor4d"
      : (real, real, real, real) -> ()
  val glBlendFunc =
      _import "glBlendFunc"
      : (word, word) -> ()
  val glOrtho =
      _import "glOrtho"
      : (real, real, real, real, real, real) -> ()
  val glBindTexture =
      _import "glBindTexture"
      : (word, word) -> ()
  val glGenTextures =
      _import "glGenTextures"
      : (int, word array) -> ()
  val glTexCoord2d =
      _import "glTexCoord2d"
      : (real, real) -> ()
  val glPixelStorei =
      _import "glPixelStorei"
      : (word, int) -> ()
  val glTexParameteri =
      _import "glTexParameteri"
      : (word, int, int) -> ()
  val glNormal3d =
      _import "glNormal3d"
      : (real, real, real) -> ()
  val glScaled =
      _import "glScaled"
      : (real, real, real) -> ()
  val glDisable =
      _import "glDisable"
      : word -> ()
  val glTexImage2D =
      _import "glTexImage2D"
      : (word, int, word, int, int, int, int, int, Word8Array.array)
        -> ()
  val glMaterialf =
      _import "glMaterialf"
      : (word, word, float) -> ()
  val glGetMaterialfv =
      _import "glGetMaterialfv"
      : (word, word, float array) -> ()
  val glFrustum =
      _import "glFrustum"
      : (real, real, real, real, real, real) -> ()
  val glDepthMask =
      _import "glDepthMask"
      : int -> ()
  val glLineWidth =
      _import "glLineWidth"
      : (float) -> ()
  val glShadeModel =
      _import "glShadeModel"
      : int -> ()

  val GL_PROJECTION = 0w5889
  val GL_DEPTH_TEST = 0w2929
  val GL_CULL_FACE = 0w2884
  val GL_BACK = 0w1029
  val GL_FRONT_AND_BACK = 0w1032
  val GL_FRONT = 0w1028
  val GL_CW = 0w2304
  val GL_LIGHTING = 0w2896
  val GL_LIGHT0 = 0w16384
  val GL_LIGHT1 = 0w16385
  val GL_DIFFUSE = 0w4609
  val GL_SPECULAR = 0w4610
  val GL_AMBIENT = 0w4608
  val GL_COLOR_BUFFER_BIT = 0w16384
  val GL_DEPTH_BUFFER_BIT = 0w256
  val GL_MODELVIEW = 0w5888
  val GL_QUADS = 0w7
  val GL_POSITION = 0w4611
  val GL_LINE_LOOP = 0w2
  val GL_LINES = 0w1
  val GL_POLYGON = 0w9
  val GL_LINE_SMOOTH = 0w2848
  val GL_POLYGON_SMOOTH = 0w2881
  val GL_BLEND = 0w3042
  val GL_MULTISAMPLE = 0w32925
  val GL_SRC_ALPHA = 0w770
  val GL_ONE_MINUS_SRC_ALPHA = 0w771
  val GL_UNSIGNED_BYTE = 5121
  val GL_RGBA = 6408
  val GL_RGB = 6407
  val GL_TEXTURE_2D = 0w3553
  val GL_UNPACK_ALIGNMENT = 0w3317
  val GL_TEXTURE_MIN_FILTER = 10241
  val GL_TEXTURE_MAG_FILTER = 10240
  val GL_LINEAR = 9729
  val GL_NONE = 0
  val GL_TRUE = 1
  val GL_FALSE = 0
  val GL_EMISSION = 0w5632
  val GL_SHININESS = 0w5633
  val GL_TRIANGLE_FAN = 0w6
  val GL_SMOOTH = 7425
  val GL_FLAT = 7424

end
