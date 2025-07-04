structure Graphics =
struct

  infix ++
  val op ++ = Word.orb

  val toReal32 = SMLSharp_Builtin.Real32.fromReal64

  type color = real * real * real * real

  val white = (1.0, 1.0, 1.0, 1.0) : color
  val black = (0.0, 0.0, 0.0, 1.0) : color
  val red = (1.0, 0.0, 0.0, 1.0) : color
  val green = (0.0, 1.0, 0.0, 1.0) : color
  val blue = (0.0, 0.0, 1.0, 1.0) : color
  val magenta = (1.0, 0.0, 1.0, 1.0) : color
  val yellow = (1.0, 1.0, 0.0, 1.0) : color
  val cyan = (0.0, 1.0, 1.0, 1.0) : color

  type env = {color: color option}
  val initialEnv : env = {color = NONE}

  datatype graphics =
      Empty
    | Box
    | Disk
    | Combine of graphics * graphics
    | Scale of graphics * (real * real)
    | Move of graphics * (real * real)
    | Rotate of graphics * real
    | Color of graphics * color
    | Clear
    | Grid of {interval: real, lineWidth: real}

  val frustumParams =
      {nearDepth = 1.0,
       focusDepth = 10.0,
       farDepth = 110.0,
       width = 8.0,
       aspect = 1.0}

  val windowWidth = ref 512
  val windowHeight = ref 384

  fun eval env graphics =
      case graphics of
        Empty => ()
      | Box =>
        (GL.glBegin GL.GL_QUADS;
         GL.glColor4d (case #color env of SOME c => c | NONE => blue);
         GL.glVertex3d (~0.5, ~0.5, 0.0);
         GL.glVertex3d (0.5, ~0.5, 0.0);
         GL.glVertex3d (0.5, 0.5, 0.0);
         GL.glVertex3d (~0.5, 0.5, 0.0);
         GL.glEnd ())
      | Disk =>
        let
          val quad = GLU.gluNewQuadric ()
        in
          GL.glColor4d (case #color env of SOME c => c | NONE => red);
          GLU.gluQuadricDrawStyle (quad, GLU.GLU_FILL);
          GLU.gluQuadricNormals (quad, GLU.GLU_FLAT);
          GLU.gluDisk (quad, 0.0, 0.5, 32, 32);
          GLU.gluDeleteQuadric quad
        end
      | Combine (Empty, graphics) => eval env graphics
      | Combine (Combine (x, y), z) =>
        eval env (Combine (x, Combine (y, z)))
      | Combine (graphics1, graphics2) =>
        (GL.glPushMatrix ();
         eval env graphics1;
         GL.glPopMatrix ();
         eval env graphics2)
      | Scale (graphics, (x, y)) =>
        (GL.glScaled (x, y, 0.0);
         eval env graphics)
      | Move (graphics, (x, y)) =>
        (GL.glTranslated (x, y, 0.0);
         eval env graphics)
      | Rotate (graphics, rot) =>
        (GL.glRotated (rot, 0.0, 0.0, 1.0);
         eval env graphics)
      | Color (graphics, color) =>
        (case #color env of
           SOME _ => eval env graphics
         | NONE => eval (env # {color = SOME color}) graphics)
      | Clear =>
        let
          val (r, g, b, a) = case #color env of SOME c => c | NONE => black
        in
          GL.glClearColor (toReal32 r, toReal32 g, toReal32 b, toReal32 a);
          GL.glClear GL.GL_COLOR_BUFFER_BIT
        end
      | Grid {interval, lineWidth} =>
        let
          val w = #width frustumParams / 2.0
          val h = w / real (!windowWidth) * real (!windowHeight)
          fun loop i limit f =
              case real i * interval of
                r => if r <= limit then (f r; loop (i + 1) limit f) else ()
        in
          GL.glLineWidth (toReal32 lineWidth);
          GL.glBegin GL.GL_LINES;
          GL.glColor4d (case #color env of SOME c => c | NONE => black);
          loop 0 w (fn x => (GL.glVertex2d (x, h);
                             GL.glVertex2d (x, ~h);
                             GL.glVertex2d (~x, h);
                             GL.glVertex2d (~x, ~h)));
          loop 0 h (fn y => (GL.glVertex2d (w, y);
                             GL.glVertex2d (~w, y);
                             GL.glVertex2d (w, ~y);
                             GL.glVertex2d (~w, ~y)));
          GL.glEnd ()
        end

  fun frustum {nearDepth, focusDepth, farDepth, width, aspect} =
      let
        val right = nearDepth * width / 2.0 / focusDepth
        val top = right / aspect
      in
        GL.glFrustum (~right, right, ~top, top, nearDepth, farDepth)
      end

  type time = React.time
  val epoch = React.epoch
  val stream = React.stream
  val event = React.event

  val initialMovie = ref (fn (_ : time) => Empty)
  val movie = ref initialMovie
  val newMovie = ref initialMovie (* may be updated by other threads *)
  val startTime = ref 0.0
  val scene = ref Empty

  fun elapsedTime () = Libc.getTime () - !startTime
  val time = stream (fn _ => elapsedTime ()) 0.0
  val (timer, setTimer) = event ()
  val (mouseMove, setMouseMove) = event ()
  val (mouseLeft, setMouseLeft) = event ()
  val (mouseRight, setMouseRight) = event ()
  val (keyboard, setKeyboard) = event ()
  val mousePos = stream (fn (t, _, z) => getOpt (mouseMove t, z)) (0.0, 0.0)

  (* may be called from other threads *)
  fun switch f = newMovie := ref f

  fun draw t =
      let
        val m = !movie
        val n = !newMovie
      in
        if m = n
        then scene := !m t
        else (movie := n;
              startTime := Libc.getTime ();
              React.lastTime := epoch;
              scene := !n epoch)
      end

  fun onDisplay () =
      (GL.glLoadIdentity ();
       GL.glTranslated (0.0, 0.0, ~(#focusDepth frustumParams));
       eval initialEnv (Combine (Clear, !scene));
       GLUT.glutSwapBuffers ())

  fun onTimer (n : int) =
      (draw (setTimer ());
       GLUT.glutPostRedisplay ();
       GLUT.glutTimerFunc (33, onTimer, 0))

  fun onKeyboard (key, _ : int, _ : int) =
      ignore (setKeyboard key)

  fun onMotion (x, y) =
      let
        val width = real (!windowWidth)
        val height = real (!windowHeight)
        val mx = (real x / width - 0.5) * #width frustumParams
        val my = (height / 2.0 - real y) * #width frustumParams / width
      in
        ignore (setMouseMove (mx, my))
      end

  fun buttonToBool button =
      if button = GLUT.GLUT_LEFT_BUTTON then SOME true
      else if button = GLUT.GLUT_RIGHT_BUTTON then SOME false
      else NONE

  fun stateToBool state =
      if state = GLUT.GLUT_DOWN then SOME true
      else if state = GLUT.GLUT_UP then SOME false
      else NONE

  fun onMouse (button, state, _ : int, _ : int) =
      case (buttonToBool button, stateToBool state) of
        (SOME true, SOME b) => ignore (setMouseLeft b)
      | (SOME false, SOME b) => ignore (setMouseRight b)
      | _ => ()

  fun onResize (width, height) =
      let
        val aspect = real width / real height
        val w = #width frustumParams
      in
        windowWidth := width;
        windowHeight := height;
        GL.glViewport (0, 0, width, height);
        GL.glMatrixMode GL.GL_PROJECTION;
        GL.glLoadIdentity ();
        frustum (frustumParams # {aspect = aspect});
        GL.glMatrixMode GL.GL_MODELVIEW
      end

  fun initGlut (progname, width, height) =
      (GLUT.glutInit progname;
       GLUT.glutInitDisplayMode
         (GLUT.GLUT_RGBA ++ GLUT.GLUT_DOUBLE ++ GLUT.GLUT_MULTISAMPLE);
       GLUT.glutInitWindowSize (width, height);
       GLUT.glutCreateWindow progname;
       GLUT.glutDisplayFunc onDisplay;
       GLUT.glutReshapeFunc onResize;
       GLUT.glutKeyboardFunc onKeyboard;
       GLUT.glutMotionFunc onMotion;
       GLUT.glutPassiveMotionFunc onMotion;
       GLUT.glutMouseFunc onMouse;
       GLUT.glutTimerFunc (33, onTimer, 0);
       GL.glEnable GL.GL_BLEND;
       GL.glBlendFunc (GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA))

  fun start f =
      (initGlut ("smlsharp", !windowWidth, !windowHeight);
       switch f;
       draw epoch;
       GLUT.glutMainLoop ())

end
