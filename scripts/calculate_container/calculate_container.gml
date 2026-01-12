function calculate_container(){
	if (root == self){
		efficient.x = 0;
		efficient.y = 0;
		
		realistic.width = GUIW;
		realistic.height = GUIH;
	}
	
	efficient.width = calculate_value(calculations.width, parent.realistic.width);
	efficient.height = calculate_value(calculations.height, parent.realistic.height);
	
	if (aspect != auto){
		if (efficient.width == 0) efficient.width = efficient.height / aspect;	
		if (efficient.height == 0) efficient.height = efficient.width / aspect;	
	}
	
//get the bigger axis (in pixels)
	var inlineAxis = (efficient.width > efficient.height);
	axis	= inlineAxis ? efficient.height	: efficient.width;
	cross	= inlineAxis ? efficient.width	: efficient.height;
	
//core box model properties

	//padding
	efficient.padding = {
		top:	calculate_value(calculations.padding.top, efficient.height),
		left:	calculate_value(calculations.padding.left, efficient.width),
		bottom: calculate_value(calculations.padding.bottom, efficient.height),
		right:	calculate_value(calculations.padding.right, efficient.width),
	}
	
	efficient.padding.inline = (efficient.padding.left + efficient.padding.right);
	efficient.padding.block = (efficient.padding.top + efficient.padding.bottom);
	
	//margin
	efficient.margin = {
		top:	calculate_value(calculations.margin.top, efficient.height),
		left:	calculate_value(calculations.margin.left, efficient.width),
		bottom:	calculate_value(calculations.margin.bottom, efficient.height),
		right:	calculate_value(calculations.margin.right, efficient.width),
	}
	
	efficient.margin.inline = (efficient.margin.left + efficient.margin.right);
	efficient.margin.block = (efficient.margin.top + efficient.margin.bottom);
	
	//border radius
	efficient.borderRadius = {
		topLeft:		calculate_value(calculations.borderRadius.topLeft, axis),
		bottomLeft:		calculate_value(calculations.borderRadius.bottomLeft, axis),
		topRight:		calculate_value(calculations.borderRadius.topRight, axis),
		bottomRight:	calculate_value(calculations.borderRadius.bottomRight, axis),
	}
	
	//realistic stuff
	realistic.width = efficient.width - efficient.padding.inline;
	realistic.height = efficient.height - efficient.padding.block;
	
	//render background
	if (vbuff != auto && vertex_buffer_exists(vbuff)) vertex_delete_buffer(vbuff);
	
	vbuff = vertex_create_buffer();
	vertex_begin(vbuff, JUI_FORMAT);
	
	// Defaults
	var bg_color = background;
	var tex = -1;
	var uv = EMPTY_UV;
	backgroundIsSurface = false;
	
	// Resolve background type
	var bg_type = asset_get_type(background);
	
	switch (bg_type) {
		case asset_sprite: {
			bg_color = c_white;
			tex = sprite_get_texture(background, image);
	
			var suv = sprite_get_uvs(background, image);
			uv.x = suv[0];
			uv.y = suv[1];
			uv.w = suv[2] - suv[0];
			uv.h = suv[3] - suv[1];
		} break;
	
		case -1: {
			// Struct-based background (e.g. surface wrapper)
			if (is_struct(background)) {
				backgroundIsMySurface = true;
				tex = background.texture;
			}
		} break;
	}
	
	// Build background quad
	build_quad(	vbuff, 0, 0,
				efficient.width, efficient.height,
				bg_color, opacity,
				uv
	);
	
	
	
//finalize
	calculated = root;
}