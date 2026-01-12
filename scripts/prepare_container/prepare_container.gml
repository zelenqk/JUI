function prepare_container(){
	//matrix applicable (real only)
	offset = {
		x: get_default_struct("offset", "x", get_overwrite("offsetx", "offset", 0)),
		y: get_default_struct("offset", "y", get_overwrite("offsety", "offset", 0)),
	}
	
	scale = {
		x: get_default_struct("scale", "x", get_overwrite("scalex", "scale", 1)),
		y: get_default_struct("scale", "y", get_overwrite("scaley", "scale", 1)),
	}
	
	//more methods
	step = get_default("step", auto)
	
	//dimensions
	width = get_default("width", "100%");
	height = get_default("height", 0);
	
	aspect = get_default("aspect", auto);
	
	//layout
	position = get_default("position", relative);
	
	direction = get_default("direction", column);
	wrap = get_default("wrap", false);
	
	overflow = get_default("overflow", fa_allow);
	
	align = get_default("align", fa_left);	//self
	justify = get_default("justify", fa_top);

	alignContent = get_default("alignContent", fa_left);	//segments
	justifyContent = get_default("justifyContent", fa_top);
	
	alignItems = get_default("alignItems", fa_left);		//elements in segments
	justifyItems = get_default("justifyItems", fa_top);

	//render properties
	background = get_default("background", c_white);
	image = get_default("image", 0);
	backgroundIsMySurface = false;
	backgroundIsSurface = get_default("surface", false);
	
	opacity = get_default("opacity", 1);
	
	//padding
	padding = {
		left: get_overwrite_struct("padding", "left", "inline", get_overwrite("paddingLeft", "paddingInline", "padding", 0)),
		right: get_overwrite_struct("padding", "right", "inline", get_overwrite("paddingRight", "paddingInline", "padding", 0)),
		top: get_overwrite_struct("padding", "top", "inline", get_overwrite("paddingTop", "paddingBlock", "padding", 0)),
		bottom: get_overwrite_struct("padding", "bottom", "inline", get_overwrite("paddingBottom", "paddingBlock", "padding", 0)),
	}
	
	//margin
	margin = {
		left: get_overwrite_struct("margin", "left", "inline", get_overwrite("marginLeft", "marginInline", "margin", 0)),
		right: get_overwrite_struct("margin", "right", "inline", get_overwrite("marginRight", "marginInline", "margin", 0)),
		top: get_overwrite_struct("margin", "top", "inline", get_overwrite("marginTop", "marginBlock", "margin", 0)),
		bottom: get_overwrite_struct("margin", "bottom", "inline", get_overwrite("marginBottom", "marginBlock", "margin", 0)),
	}

	//border radius
	borderRadius = {
		topLeft: get_overwrite_struct("borderRadius", "topLeft", "left", "top", get_overwrite("borderRadiusTopLeft", "borderRadiusLeft", "borderRadiusTop", "borderRadius", 0)),
		topRight: get_overwrite_struct("borderRadius", "topLeft", "left", "top", get_overwrite("borderRadiusTopRight", "borderRadiusRight", "borderRadiusTop", "borderRadius", 0)),
		bottomLeft: get_overwrite_struct("borderRadius", "bottomLeft", "left", "bottom", get_overwrite("borderRadiusBottomLeft", "borderRadiusLeft", "borderRadiusBottom", "borderRadius", 0)),
		bottomRight: get_overwrite_struct("borderRadius", "bottomLeft", "left", "bottom", get_overwrite("borderRadiusBottomRight", "borderRadiusRight", "borderRadiusBottom", "borderRadius", 0)),
	}
}