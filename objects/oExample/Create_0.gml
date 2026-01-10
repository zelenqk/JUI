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

sliderWrapper = new container({
	height: "100%",
	width: 7,
	position: fixed,
	opacity: 0,
	marginLeft: auto,
});

sliderWrapper.add(new Slider({width: 7,	overflow: fa_hidden, height: "100%", background: #121212}));
main.add(sliderWrapper);