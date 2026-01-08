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
	
	borderRadius: 32,
	
	wrap: true,
});

test = main.add(new container({
	width: "5%",
	height: "10%",
	
	borderRadius: "50%",

	opacity: 1,
	margin:{
		right: 1,
		top: 1,
	},
	background: c_blue,
}), 100);
