function container(style) constructor{
	self.style = style;
	
	target = {};
	
	width = get_default("width", GUIW);
	height = get_default("height", 0);
	
	background = get_default("background", c_white);
}