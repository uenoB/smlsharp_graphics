smlsharp_graphics_repl.wsl: smlsharp_graphics_repl.tar
	xz -c smlsharp_graphics_repl.tar > $@

smlsharp_graphics_repl.tar: Dockerfile
	podman buildx build -t smlsharp_graphics_repl -f Dockerfile ..
	podman run --name=smlsharp_graphics_repl smlsharp_graphics_repl sh -c :
	podman export -o $@ smlsharp_graphics_repl
	podman rm smlsharp_graphics_repl
