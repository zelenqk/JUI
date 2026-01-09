globalvar JUI_FORMAT;
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();

JUI_FORMAT = vertex_format_end();

function calculate_container(){
	efficient.width = 0;
	efficient.height = 0;
	
	coffset.x = - parent.efficient.width * parent.anchor.x;
	coffset.y = - parent.efficient.height * parent.anchor.y;
	
	realistic.width = GUIW;
	realistic.height = GUIH;
	
	//calculate dimensions
	efficient.width		= calculate_value(calculations.width,	parent.realistic.width	);
	efficient.height	= calculate_value(calculations.height,	parent.realistic.height	);
	efficient.opacity	= calculate_value(calculations.opacity, 1);
	
	//get the bigger axis
	axis	=	(efficient.width < efficient.height) ? efficient.width : efficient.height;
	cross	=	(efficient.width < efficient.height) ? efficient.height : efficient.width;
	
	if (efficient.width == 0 and aspect != auto) efficient.width = efficient.height * aspect;
	if (efficient.height == 0 and aspect != auto) efficient.height = efficient.width * aspect;
	
	//get the direct axis
	axis	=	(direction == row) ? efficient.width : efficient.height;
	cross	=	(direction == row) ? efficient.height : efficient.width;
	
	efficient.gap		= calculate_value(calculations.gap, axis);
	
	//calculate border
	efficient.border = calculate_value(calculations.border, axis);
	
	//calculate padding
	efficient.padding = {
		left:	calculate_value(calculations.padding.left,		axis),
		right:	calculate_value(calculations.padding.right,		axis),
		top:	calculate_value(calculations.padding.top,		axis),
		bottom:	calculate_value(calculations.padding.bottom,	axis),
	}
	
	//calculate margin
	efficient.margin = {
		left:	calculate_value(calculations.margin.left,		parent.realistic.width),
		right:	calculate_value(calculations.margin.right,		parent.realistic.width),
		top:	calculate_value(calculations.margin.top,		parent.realistic.height),
		bottom:	calculate_value(calculations.margin.bottom,		parent.realistic.height),
	}
	
	efficient.margin.inline = efficient.margin.left + efficient.margin.right;
	efficient.margin.block = efficient.margin.top + efficient.margin.bottom;
	
	offset = {
		x: calculate_value(calculations.offset.x, axis	),
		y: calculate_value(calculations.offset.y, cross	),	
	}
	
	//get the smaller axis
	axis	=	(efficient.width < efficient.height) ? efficient.width : efficient.height;
	cross	=	(efficient.width < efficient.height) ? efficient.height : efficient.width;

	if (borderRadius != auto){
		efficient.borderRadius = {
			topLeft:		calculate_value(calculations.borderRadius.topLeft,		axis),
			topRight:		calculate_value(calculations.borderRadius.topRight,		axis),
			bottomLeft:		calculate_value(calculations.borderRadius.bottomLeft,	axis),
			bottomRight:	calculate_value(calculations.borderRadius.bottomRight,	axis),
		}
	}
	
	//realistic dimensions
	if (margin.left == auto) efficient.margin.left = parent.realistic.width - efficient.width;
	if (margin.top == auto) efficient.margin.top = parent.realistic.height - efficient.height;
	
	switch (align){
	case fa_center:
		efficient.margin.left = (parent.realistic.width / 2) - efficient.width / 2;
		break;
	case fa_right:
		efficient.margin.left = (parent.realistic.width) - efficient.width;
		break;
	}
	
	switch (justify){
	case fa_center:
		efficient.margin.top = (parent.realistic.height / 2) - efficient.height / 2;
		break;
	case fa_bottom:
		efficient.margin.top = (parent.realistic.height) - efficient.height;
		break;
	}
	
	realistic.width		= efficient.width	-	efficient.padding.left	-	efficient.padding.right		;
	realistic.height	= efficient.height	-	efficient.padding.top	-	efficient.padding.bottom	;
	
	if (parent != self and parent.overflow == fa_allow){
		coffset.x += parent.efficient.padding.left;
		coffset.y += parent.efficient.padding.top;	
	}
	
	coffset.x += efficient.margin.left	+ efficient.border;
	coffset.y += efficient.margin.top	+ efficient.border;
	
	realistic.x = x + efficient.margin.left + offset.x;
	realistic.y = y + efficient.margin.top + offset.y;
	
	target.x = realistic.x;
	target.y = realistic.y;
	
	//background
	backdrop = {
		shader: get_overwrite_struct("backdrop", "shader", get_default("backdrop", auto)),
		arguments: is_struct(properties[$ "backdrop"]) ? get_shader_arguments(properties.backdrop) : [],
		pass: get_overwrite_struct("backdrop", "pass", get_default("pass", auto)),
	}
	
	if (overflow.x != fa_allow or overflow.y != fa_allow){
		cache[CACHE.OVERFLOW] = new Surface(realistic.width, realistic.height);
	}
	
	if (backdrop != auto){
		cache[CACHE.BACKDROP] = new Surface(efficient.width, efficient.height);
		cache[CACHE.BACKDROP_PASS] = new Surface(efficient.width, efficient.height);
	}
	
	calculate_layout();
}