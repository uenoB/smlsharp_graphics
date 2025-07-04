structure GLUT =
struct

  val glutInit =
      _import "glutInit"
      : (int ref, string vector) -> ()

  val glutInit =
      fn s => glutInit (ref 1, Vector.fromList [s])

  val glutInitDisplayMode =
      _import "glutInitDisplayMode"
      : word -> ()
  val glutInitWindowSize =
      _import "glutInitWindowSize"
      : (int, int) -> ()
  val glutCreateWindow =
      _import "glutCreateWindow"
      : string -> ()
  val glutDisplayFunc =
      _import "glutDisplayFunc"
      : (()->()) -> ()
  val glutReshapeFunc =
      _import "glutReshapeFunc"
      : ((int, int)->()) -> ()
  val glutMouseFunc =
      _import "glutMouseFunc"
      : ((int, int, int, int) -> ()) -> ()
  val glutMotionFunc =
      _import "glutMotionFunc"
      : ((int, int) -> ()) -> ()
  val glutPassiveMotionFunc =
      _import "glutPassiveMotionFunc"
      : ((int, int) -> ()) -> ()
  val glutKeyboardFunc =
      _import "glutKeyboardFunc"
      : ((char, int, int)->()) -> ()
  val glutTimerFunc =
      _import "glutTimerFunc"
      : (int, int->(), int) -> ()
  val glutMainLoop =
      _import "glutMainLoop"
      : () -> ()
  val glutSwapBuffers =
      _import "glutSwapBuffers"
      : () -> ()
  val glutPostRedisplay =
      _import "glutPostRedisplay"
      : () -> ()
  val glutExtensionSupported =
      _import "glutExtensionSupported"
      : string -> int
  val glutSolidTeapot =
      _import "glutSolidTeapot"
      : real -> ()

  val GLUT_RGBA = 0w0
  val GLUT_DOUBLE = 0w2
  val GLUT_DEPTH = 0w16
  val GLUT_MULTISAMPLE = 0w128
  val GLUT_LEFT_BUTTON = 0
  val GLUT_RIGHT_BUTTON = 2
  val GLUT_DOWN = 0
  val GLUT_UP = 1

  val displayFunc = ref (fn _ => ())
  val glutDisplayFunc =
      fn f => (displayFunc := f;
               glutDisplayFunc (fn x => !displayFunc x))

  val reshapeFunc = ref (fn _ => ())
  val glutReshapeFunc =
      fn f => (reshapeFunc := f;
               glutReshapeFunc (fn x => !reshapeFunc x))

  val mouseFunc = ref (fn _ => ())
  val glutMouseFunc =
      fn f => (mouseFunc := f;
               glutMouseFunc (fn x => !mouseFunc x))

  val motionFunc = ref (fn _ => ())
  val glutMotionFunc =
      fn f => (motionFunc := f;
               glutMotionFunc (fn x => !motionFunc x))

  val passiveMotionFunc = ref (fn _ => ())
  val glutPassiveMotionFunc =
      fn f => (passiveMotionFunc := f;
               glutPassiveMotionFunc (fn x => !passiveMotionFunc x))

  val keyboardFunc = ref (fn _ => ())
  val glutKeyboardFunc =
      fn f => (keyboardFunc := f;
               glutKeyboardFunc (fn x => !keyboardFunc x))

  val timerFunc = ref (fn _ => ())
  val glutTimerFunc =
      fn (x, f, y) =>
         (timerFunc := f;
          glutTimerFunc (x, fn x => !timerFunc x, y))

end
