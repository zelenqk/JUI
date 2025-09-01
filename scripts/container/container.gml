function container(style) constructor{
	self.style = style;
	dirty = true;
	
	target = {};
	efficient = {};
	
	texture = -1;
	vertexBuffer = vertex_create_buffer();
	
	x = 0;
	y = 0;
	
	//layout properties
	width = get_default("width", GUIW);
	height = get_default("height", 0);
	
	display = get_default("display", fixed);
	position = get_default("position", relative);
	direction = get_default("direction", column);
	
	aspect = get_default("aspect");
	
	//style
	sprite = get_default("sprite");
	image = get_default("image", 0);
	
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
		//index is a multiplier value meaning 0 is start of the array 1 the end of the array + 1 and 0.5 is the middle
		index = array_length(content) * index;
		
		array_insert(element);
		dirty = true;
	}
	
	draw = function(){
		if (dirty) calculate_container();
	
		
	}
}