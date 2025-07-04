structure GLU =
struct

  type gluQuadricObj = unit ptr

  val gluPerspective =
      _import "gluPerspective"
      : (real, real, real, real) -> ()
  val gluLookAt =
      _import "gluLookAt"
      : (real, real, real, real, real, real, real, real, real) -> ()
  val gluNewQuadric =
      _import "gluNewQuadric"
      : () -> gluQuadricObj
  val gluDeleteQuadric =
      _import "gluDeleteQuadric"
      : gluQuadricObj -> ()
  val gluQuadricDrawStyle =
      _import "gluQuadricDrawStyle"
      : (gluQuadricObj, word) -> ()
  val gluQuadricNormals =
      _import "gluQuadricNormals"
      : (gluQuadricObj, word) -> ()
  val gluQuadricOrientation =
      _import "gluQuadricOrientation"
      : (gluQuadricObj, word) -> ()
  val gluCylinder =
      _import "gluCylinder"
      : (gluQuadricObj, real, real, real, int, int) -> ()
  val gluDisk =
      _import "gluDisk"
      : (gluQuadricObj, real, real, int, int) -> ()
  val gluSphere =
      _import "gluSphere"
      : (gluQuadricObj, real, int, int) -> ()
  val gluBuild2DMipmaps =
      _import "gluBuild2DMipmaps"
      : (word, int, int, int, int, int, Word8Array.array) -> int

  val GLU_FILL = 0w100012
  val GLU_SMOOTH = 0w100000
  val GLU_INSIDE = 0w100021
  val GLU_LINE = 0w100011
  val GLU_FLAT = 0w100001
  val GLU_NONE = 0w100002

end
