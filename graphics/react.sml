structure React =
struct
  type time = (unit -> unit) array

  val epoch = Array.fromList nil

  val updaters = ref (Vector.fromList nil)

  fun addToVector v x =
(*
    Vector.fromList (Vector.foldr (op ::) [x] v)
*)
    let
      val len = Vector.length v
      fun valueOf i = if i < len then Vector.sub (v, i) else x
    in
      Vector.tabulate (len + 1, valueOf)
    end

  fun newTime (t2 : time) =
    let
      val len = Vector.length (!updaters)
      val t1 = Array.array (len, fn () => ())
      fun lazyUpdate id () =
        case Vector.sub (!updaters, id) (t1, t2) of
          f => (Array.update (t1, id, f); f ())
    in
      Array.modifyi (fn (id, _) => lazyUpdate id) t1;
      t1
    end

  fun newStream update init =
    let
      val id = Vector.length (!updaters)
      val ret = ref init
      fun get (time : time) =
        if id < Array.length time
        then (Array.sub (time, id) (); !ret)
        else init
      fun set (t2, value) =
        let
          val t1 = newTime t2
        in
          Array.update (t1, id, fn () => ret := value);
          Array.app (fn f => f ()) t1;
          t1
        end
      fun update' (t1, t2) =
        case update (t1, t2, get t2) of
          v => fn () => ret := v
    in
      updaters := addToVector (!updaters) update';
      (get, set)
    end

  fun stream update init =
    #1 (newStream update init)

  val lastTime = ref epoch

  fun updateTime set value =
    (lastTime := set (!lastTime, value); !lastTime)

  fun event () =
    let
      val (get, set) = newStream (fn _ => NONE) NONE
    in
      (get, updateTime set o SOME)
    end
end
