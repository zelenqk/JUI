surface = new Surface(100, 100, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 100, 100, c_white, 1);
	surface.reset();
}

main = new container({
	width: "50%",
	height: "50%",
	padding: "1%",
	background: surface,
	wrap: true,
});

test = main.add({
	width: "100%",
	height: 23,
	margin: {
		bottom: 4	
	}
}, 12);
