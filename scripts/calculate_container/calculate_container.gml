globalvar JUI_FORMAT;
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();

JUI_FORMAT = vertex_format_end();

function calculate_container(){
	efficient.width = GUIW;
	efficient.height = GUIH;
	
	efficient.width = calculate_value(calculations.width, parent.efficient.width);
	efficient.height = calculate_value(calculations.height, parent.efficient.height);
	
	efficient.border = calculate_value(calculations.border, (direction == row) ? efficient.width : efficient.height);
	
	efficient.padding = {
		left:	calculate_value(calculations.padding.left,		efficient.width),
		right:	calculate_value(calculations.padding.right,		efficient.width),
		top:	calculate_value(calculations.padding.top,		efficient.height),
		bottom:	calculate_value(calculations.padding.bottom,	efficient.height),
	}
	
	efficient.margin = {
		left:	calculate_value(calculations.margin.left,	efficient.width),
		right:	calculate_value(calculations.margin.right,	efficient.width),
		top:	calculate_value(calculations.margin.top,	efficient.height),
		bottom:	calculate_value(calculations.margin.bottom,	efficient.height),
	}
	
	efficient.borderRadius = {
		topLeft:		calculate_value(calculations.borderRadius.topLeft,		efficient.width),
		topRight:		calculate_value(calculations.borderRadius.topRight,		efficient.width),
		bottomLeft:		calculate_value(calculations.borderRadius.bottomLeft,	efficient.height),
		bottomRight:	calculate_value(calculations.borderRadius.bottomRight,	efficient.height),
	}
	
	realistic.width		= efficient.width	+	efficient.padding.left	+	efficient.padding.right		;
	realistic.height	= efficient.height	+	efficient.padding.top	+	efficient.padding.bottom	;
	
	if (vbuff != auto) vertex_delete_buffer(vbuff);
	vbuff = vertex_create_buffer();
	
	vertex_begin(vbuff, JUI_FORMAT);
	switch (background.type){
	case asset_surface:
		var surface = background.value;
		texture = surface.texture;
		
		build_quad(vbuff, anchor.x, anchor.y, realistic.width, realistic.height, c_white, 1);
		break;
	case asset_sprite:
		var sprite = background.value;
		var uv = sprite_get_uvs(background.value, 0);
		
		build_quad(vbuff, anchor.x, anchor.y, realistic.width, realistic.height, c_white, 1, {
			x: uv[0],	
			y: uv[1],
			width: uv[2] - uv[0],
			height: uv[3] - uv[1],
		});
		
		texture = sprite_get_texture(sprite, 0);
		break;
	default:
		var color = c_white;
		if (is_ptr(background.value)) texture = background.value;
		else color = background.value;
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, color, 1);
		break;
	}

	realistic.x += efficient.width	* anchor.x + efficient.margin.left	+ efficient.border ;
	realistic.y += efficient.height	* anchor.y + efficient.margin.top		+ efficient.border;
	matrix = matrix_build(realistic.x, realistic.y, 0, 0, 0, 0, 1, 1, 1);
}