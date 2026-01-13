function Slider(properties = {}, knob = {}, parent = self) constructor{
	self.properties = properties;
	
	width = get_default("width", 7);
	height = get_default("height", "100%");

	calculate(false);
	

}