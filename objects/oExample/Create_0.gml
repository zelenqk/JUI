surface = new Surface(100, 100, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 100, 100, c_white, 1);
	surface.reset();
}

main = new container({
	width: 300,
	height: 300,
	padding: 10,
	wrap: true,
});

test = main.add(new container({
	width: "100%",
	height: "100%",
	
	opacity: 1,
	background: sTest,
}), 100);


