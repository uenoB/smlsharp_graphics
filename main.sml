open Graphics

val mouseLeftButton =
    stream (fn (t, _, b) => case mouseLeft t of NONE => b | SOME b => b) false

fun addVec ((x1, y1), (x2, y2)) = (x1 + x2, y1 + y2)

fun mulVec ((x, y), n) = (x * n, y * n)

val objectPos =
    stream
      (fn (t, t2, {pos as (x, y), vel as (vx, vy)}) =>
          if mouseLeftButton t
          then {pos = mousePos t, vel = vel}
          else if (x < ~3.0 orelse x > 3.0) andalso Real.sign x = Real.sign vx
          then {pos = pos, vel = (~vx, vy)}
          else if (y < ~3.0 orelse y > 3.0) andalso Real.sign y = Real.sign vy
          then {pos = pos, vel = (vx, ~vy)}
          else {pos = addVec (pos, mulVec (vel, time t - time t2)),
                vel = vel})
      {pos = (0.0, 0.0), vel = (2.0, 0.6)}

fun foreground t = Move (Rotate (Box, 30.0 * time t), #pos (objectPos t))

val background = Scale (Color (Box, yellow), (6.0, 6.0))

fun movie t = Combine (background, foreground t)

val _ = start movie
