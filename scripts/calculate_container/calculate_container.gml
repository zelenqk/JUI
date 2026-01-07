globalvar JUI_FORMAT;
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();

JUI_FORMAT = vertex_format_end();

function calculate_container(){
	efficient.width = 0;
	efficient.height = 0;
	
	realistic.x = -parent.efficient.width * parent.anchor.x;
	realistic.y = -parent.efficient.height * parent.anchor.y;
	
	realistic.width = GUIW;
	realistic.height = GUIH;
	
	efficient.width		= calculate_value(calculations.width,	parent.realistic.width	);
	efficient.height	= calculate_value(calculations.height,	parent.realistic.height	);
	efficient.opacity	= calculate_value(calculations.opacity, 1);
	
	axis	=	(direction == row) ? efficient.width : efficient.height;
	cross	=	(direction == row) ? efficient.height : efficient.width;

	efficient.border = calculate_value(calculations.border, axis);
	
	efficient.padding = {
		left:	calculate_value(calculations.padding.left,		axis),
		right:	calculate_value(calculations.padding.right,		axis),
		top:	calculate_value(calculations.padding.top,		axis),
		bottom:	calculate_value(calculations.padding.bottom,	axis),
	}
	
	efficient.margin = {
		left:	calculate_value(calculations.margin.left,		parent.realistic.width),
		right:	calculate_value(calculations.margin.right,		parent.realistic.width),
		top:	calculate_value(calculations.margin.top,		parent.realistic.height),
		bottom:	calculate_value(calculations.margin.bottom,		parent.realistic.height),
	}
	
	axis	=	(efficient.width > efficient.height) ? efficient.width : efficient.height;
	cross	=	(efficient.width > efficient.height) ? efficient.height : efficient.width;

	if (borderRadius != auto){
		efficient.borderRadius = {
			topLeft:		calculate_value(calculations.borderRadius.topLeft,		axis),
			topRight:		calculate_value(calculations.borderRadius.topRight,		axis),
			bottomLeft:		calculate_value(calculations.borderRadius.bottomLeft,	axis),
			bottomRight:	calculate_value(calculations.borderRadius.bottomRight,	axis),
		}
	}
	
	realistic.width		= efficient.width	-	efficient.padding.left	-	efficient.padding.right		;
	realistic.height	= efficient.height	-	efficient.padding.top	-	efficient.padding.bottom	;
	
	if (vbuff != auto) vertex_delete_buffer(vbuff);
	vbuff = vertex_create_buffer();
	
	vertex_begin(vbuff, JUI_FORMAT);
	switch (background.type){
	case asset_surface:
		var surface = background.value;
		texture = surface.texture;
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, c_white, efficient.opacity);
		break;
	case asset_sprite:
		var sprite = background.value;
		var uv = sprite_get_uvs(background.value, 0);
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, c_white, efficient.opacity, {
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
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, color, efficient.opacity);
		break;
	}
	
	if (parent != self){
		realistic.x += parent.efficient.padding.left
		realistic.y += parent.efficient.padding.top;	
	}
	
	realistic.x += efficient.margin.left	+ efficient.border;
	realistic.y += efficient.margin.top		+ efficient.border;
	
	matrix = matrix_build(realistic.x + efficient.width	* anchor.x, realistic.y + efficient.height	* anchor.y, 0, 0, 0, 0, 1, 1, 1);
}