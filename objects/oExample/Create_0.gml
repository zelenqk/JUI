surface = new Surface(1000, 1000, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 1000, 1000, c_white, 1);
	surface.reset();
}

main = new container({
	width: 500,
	height: 300,
	padding: 10,
	
	direction: row,
	wrap: true,
	borderRadius: 18,
});

main.add(new container({
	width: "10%",
	height: "10%",
	borderRadius: "50%",

	background: c_red,
	
}))

test = main.add(new container({
	width: "5%",
	height: "10%",
	
	borderRadius: "50%",
	opacity: 0.75,

	background: c_blue,
}), 100);

