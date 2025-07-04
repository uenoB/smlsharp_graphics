structure Libc =
struct

  type time_t = Int64.int  (* platform dependent *)

  val gettimeofday =
      _import "gettimeofday"
      : __attribute__((fast)) (time_t array, int array) -> int

  exception GetTime

  fun getTime () =
      let
        val tv = Array.array (2, 0)
        val tz = Array.array (2, 0)
        val n = gettimeofday (tv, tz)
        val _ = if n <> 0 then raise GetTime else ()
        val sec = Array.sub (tv, 0)
        val usec = Array.sub (tv, 1)
        val real = SMLSharp_Builtin.Real64.fromInt64
      in
        real sec + real usec / 1000000.0
      end

end
