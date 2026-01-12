function calculate_container(recalculate = true){
	if (recalculate) cleanup();
	
	if (root == self){
		efficient.x = 0;
		efficient.y = 0;
		efficient.width = 0;
		efficient.height = 0;
		
		realistic.x = 0;
		realistic.y = 0;
		
		realistic.width = GUIW;
		realistic.height = GUIH;
	}
	
	opacity = calculate_value(calculations.opacity, 1);

	efficient.width = calculate_value(calculations.width, parent.realistic.width);
	efficient.height = calculate_value(calculations.height, parent.realistic.height);
	
	if (aspect != auto){
		if (efficient.width == 0) efficient.width = efficient.height / aspect;
		if (efficient.height == 0) efficient.height = efficient.width / aspect;	
	}
	
	switch (align){
	case fa_center:
		offset.x += parent.realistic.width / 2 - efficient.width / 2;
		break;
	case fa_right:
		offset.x += parent.realistic.width - efficient.width;
		break;
	}
	
	switch (justify){
	case fa_center:
		offset.y += parent.realistic.height / 2 - efficient.height / 2;
		break;
	case fa_right:
		offset.y += parent.realistic.height - efficient.height;
		break;
	}
	
	//get the direction axis (in pixels)
	axis	= (direction == row) ? efficient.width	: efficient.height;
	cross	= (direction == column) ? efficient.height	: efficient.width;
	
//core box model properties
	//padding
	efficient.padding = {
		top:	calculate_value(calculations.padding.top, axis),
		left:	calculate_value(calculations.padding.left, axis),
		bottom: calculate_value(calculations.padding.bottom, axis),
		right:	calculate_value(calculations.padding.right, axis),
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
	
	if (efficient.margin.left == auto) efficient.margin.left = parent.realistic.width - efficient.width;
	if (efficient.margin.top == auto) efficient.margin.top = parent.realistic.height - efficient.height;
	
	efficient.margin.inline = (efficient.margin.left + efficient.margin.right);
	efficient.margin.block = (efficient.margin.top + efficient.margin.bottom);
	
	//get the bigger axis (in pixels)
	var inlineAxis = (efficient.width > efficient.height);
	axis	= inlineAxis ? efficient.height	: efficient.width;
	cross	= inlineAxis ? efficient.width	: efficient.height;
	
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
	
	//cache render masks
	if (borderRadiusEnabled){
		var br = new Surface(efficient.width, efficient.height, true);
		if (br.target()){
			shader_set(shBorderRadius);
		
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "size"), efficient.width / 2, efficient.height / 2);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "radius"), efficient.borderRadius.topRight, efficient.borderRadius.bottomRight, efficient.borderRadius.topLeft, efficient.borderRadius.bottomLeft);
			
			vertex_submit(vbuff, pr_trianglelist, -1);
			shader_reset();
			br.reset();
		}
		
		cache[JUI_CACHE.BORDER_RADIUS] = br;
	}
	
	if (overflow != fa_allow){
		camera = camera_create();
		cache[JUI_CACHE.OVERFLOW] = new Surface(realistic.width, realistic.height);
		camera_set_view_size(camera, realistic.width, realistic.height);
	}
	
	
//finalize
	calculated = root;
	calculate_layout(recalculate);
	render_pipeline();
}