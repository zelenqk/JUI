surface = new Surface(100, 100, surface_rgba8unorm, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest,0, 0, 0, 100, 100, c_blue, 1);
	surface.reset();
}

main = new container({
	width: "50%",
	height: "50%",
	
	background: surface,
});

test = main.add({
	marginTop: 32,
	width: "50%",
	height: 23,
}, 10);

