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
	
	overflow: fa_hidden,
	borderRadius: 18,
	marginLeft: "50%",
});


test = main.add(new container({
	width: "100%",
	height: "10%",
	marginBottom: 10,
	background: c_red,
	
	anchor: 0.5,
}), 5)
