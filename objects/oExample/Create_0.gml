surface = new Surface(100, 100, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 100, 100, c_white, 1);
	surface.reset();
}

main = new container({
	width: "50%",
	height: "50%",
	padding: "1%",
	marginLeft: "50%",
	background: surface,
	borderRadius: 12,
	wrap: true,
});

test = main.add(new container({
	width: "100%",
	height: 23,
	opacity: 0.5,
	background: c_blue,
	margin: {
		bottom: 4	
	}
}), 100);


show_message(matrix_build(123,123,123, 0, 0, 0, 1, 1,1 ));