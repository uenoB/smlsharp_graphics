val commandName = CommandLine.name ()
val commandArgs = CommandLine.arguments ()
val commandArgs = commandArgs @ ["-r", "./toplevel.smi"]
val _ = Pthread.Thread.create
          (fn _ => OS.Process.exit (Main.main (commandName, commandArgs)))
val _ = draw empty
