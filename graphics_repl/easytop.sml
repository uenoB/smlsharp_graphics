structure EasyTop =
struct
  open Graphics

  val background =
      Combine
        (Color (Clear, white),
         Color (Grid {interval = 1.0, lineWidth = 1.0}, (0.7, 0.7, 0.7, 1.0)))

  val started = ref false
  fun start f =
      (if !started then switch else (started := true; Graphics.start))
        (fn t => Combine (background, f t))
  fun play f = start (fn t => f (time t))
  fun draw x = start (fn _ => x)

  fun normalReal x = Real.max (0.0, Real.min (1.0, x))
  fun toReal x = normalReal (real x / 255.0)

  val rotReal = Rotate
  fun wideReal (x, y) = Scale (x, (y, 1.0))
  fun tallReal (x, y) = Scale (x, (1.0, y))
  fun downReal (x, y) = Move (x, (0.0, ~y))
  fun upReal (x, y) = Move (x, (0.0, y))
  fun leftReal (x, y) = Move (x, (~y, 0.0))
  fun rightReal (x, y) = Move (x, (y, 0.0))
  val moveReal = Move
  val scaleReal = Scale
  fun colorReal (x, (r, g, b)) =
      Color (x, (normalReal r, normalReal g, normalReal b, 1.0))

  fun rotInt (x, y) = rotReal (x, real y)
  fun wideInt (x, y) = wideReal (x, real y)
  fun tallInt (x, y) = tallReal (x, real y)
  fun downInt (x, y) = downReal (x, real y)
  fun upInt (x, y) = upReal (x, real y)
  fun leftInt (x, y) = leftReal (x, real y)
  fun rightInt (x, y) = rightReal (x, real y)
  fun moveInt (x, (dx, dy)) = moveReal (x, (real dx, real dy))
  fun scaleInt (x, (sx, sy)) = scaleReal (x, (real sx, real sy))
  fun colorInt (x, (r, g, b)) = Color (x, (toReal r, toReal g, toReal b, 1.0))

  val box = Box
  val disk = Disk
  val empty = Empty
  val ++ = Combine

  fun white x = Color (x, Graphics.white)
  fun black x = Color (x, Graphics.black)
  fun red x = Color (x, Graphics.red)
  fun green x = Color (x, Graphics.green)
  fun blue x = Color (x, Graphics.blue)
  fun magenta x = Color (x, Graphics.magenta)
  fun yellow x = Color (x, Graphics.yellow)
  fun cyan x = Color (x, Graphics.cyan)
end

open EasyTop

infix 7 rot wide tall down up left right move scale color
infix 6 ++
