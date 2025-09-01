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
	
	//style
	background = get_default("background", c_white);
	
	radius = {
		left: {
			top: get_default("radiusTopLeft", get_default("radiusLeft", get_default("radiusTop", get_default("radius", 0)))),
			bottom: get_default("radiusBottomLeft", get_default("radiusLeft", get_default("radiusBottom", get_default("radius", 0))))	
		},
		right: {
			top: get_default("radiusTopRight", get_default("radiusRight", get_default("radiusTop", get_default("radius", 0)))),
			bottom: get_default("radiusBottomRight", get_default("radiusRight", get_default("radiusBottom", get_default("radius", 0))))	
		}
	}
	
	//children
	content = get_default("content", []);
	overflow = get_default("overflow", fa_allow);

	//functions
	add = function(element, index = 1){
		index = array_length(content);
	}
	
	draw = function(){
		
	}
}