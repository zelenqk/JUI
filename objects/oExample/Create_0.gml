main = new container({
	width: 600,
	aspect: 16/9,
	padding: 6,
	
	opacity: 0.6,
	
	direction: row,
	wrap: true,
	
	align: fa_center,
	justify: fa_center,
	
	position: absolute,
	
	background: #121212,
	
	overflow: fa_hidden,
	borderRadius: 8,
	marginLeft: auto,
	
	backdrop: {
		shader: shBlurH,
		pass: shBlurV,
		size: ["width", "height"],
		radius: 24,
	}
});


slider = main.add(new Slider({position: fixed, overflow: fa_hidden, width: 7, borderRadius: "50%", padding: 1, height: "100%", background: #121212}, , main));
slider.knob.size = 50;
