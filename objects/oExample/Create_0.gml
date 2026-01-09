main = new container({
	width: 600,
	aspect: 16/9,
	padding: 10,
	
	opacity: 0.6,
	
	direction: row,
	wrap: true,
	
	align: fa_center,
	justify: fa_center,
	
	position: absolute,
	
	background: #121212,
	
	overflow: fa_hidden,
	borderRadius: 12,
	marginLeft: auto,
	
	backdrop: {
		shader: shBlurH,
		pass: shBlurV,
		size: ["width", "height"],
		radius: 24,
	}
});

test = main.add(new Slider());
