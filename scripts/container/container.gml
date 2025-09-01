function container(style) constructor{
	self.style = style;
	target = {};
	efficient = {};
	
	//layout properties
	width = get_default("width", GUIW);
	height = get_default("height", 0);
	
	display = get_default("display", fixed);
	direction = get_default("direction", column);
	
	aspect = get_default("aspect");
	
	background = get_default("background", c_white);
	
	//children
	content = get_default("content", []);
	overflow = get_default("display", fa_allow);

	//functions
	add = function(element, index = 1){
		index = array_length(content);
	}
	
	draw = function(){
		
	}
}