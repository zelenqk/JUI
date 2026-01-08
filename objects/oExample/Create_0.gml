surface = new Surface(1000, 1000, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 1000, 1000, c_white, 1);
	surface.reset();
}

main = new container({
	width: 300,
	height: 300,
	padding: 10,
	
	direction: row,
	
	wrap: true,
});

test = main.add(new container({
	width: "10%",
	height: "10%",
	
	opacity: 1,
	background: surface,
}), 1000);
