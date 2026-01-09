surface = new Surface(1000, 1000, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 1000, 1000, c_white, 1);
	surface.reset();
}

main = new container({
	width: 500,
	height: 300,
	padding: 10,
	
	opacity: 0.6,
	
	direction: row,
	wrap: true,
	
	align: fa_center,
	justify: fa_center,
	
	position: absolute,
	
	background: #121212,
	
	overflow: fa_hidden,
	borderRadius: 18,
	marginLeft: auto,
	
	backdrop: {
		shader: shBlurH,
		pass: shBlurV,
		size: ["width", "height"],
		radius: 5,
	}
});


test = main.add(new container({
	width: "100%",
	height: "10%",
	marginBottom: 10,
	background: c_red,
	
	padding: 3,
	borderRadius: "50%",
	overflow: fa_hidden,
}), 5)


test[0].add({
	width: "50%",
	borderRadius: "50%",
	height: "100%",
})