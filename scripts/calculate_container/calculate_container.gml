globalvar JUI_FORMAT;
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();

JUI_FORMAT = vertex_format_end();

function calculate_container(){
	efficient.width = 0;
	efficient.height = 0;
	
	offset.x = - parent.efficient.width * parent.anchor.x;
	offset.y = - parent.efficient.height * parent.anchor.y;
	
	realistic.width = GUIW;
	realistic.height = GUIH;
	
	//calculate dimensions
	efficient.width		= calculate_value(calculations.width,	parent.realistic.width	);
	efficient.height	= calculate_value(calculations.height,	parent.realistic.height	);
	efficient.opacity	= calculate_value(calculations.opacity, 1);
	
	
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
	
	efficient.manualOffset = {
		x: calculate_value(calculations.offset.x, axis	),
		y: calculate_value(calculations.offset.y, cross	),	
	}
	
	//get the bigger axis
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
	
	//realistic dimensions
	if (margin.left == auto) efficient.margin.left = parent.realistic.width - efficient.width;
	if (margin.top == auto) efficient.margin.top = parent.realistic.height - efficient.height;
	
	realistic.width		= efficient.width	-	efficient.padding.left	-	efficient.padding.right		;
	realistic.height	= efficient.height	-	efficient.padding.top	-	efficient.padding.bottom	;
	
	if (parent != self and parent.overflow == fa_allow){
		offset.x += parent.efficient.padding.left;
		offset.y += parent.efficient.padding.top;	
	}
	
	offset.x += efficient.margin.left	+ efficient.border;
	offset.y += efficient.margin.top	+ efficient.border;
	
	realistic.x = x + efficient.margin.left + efficient.manualOffset.x;
	realistic.y = y + efficient.margin.top + efficient.manualOffset.y;
	
	if (overflow.x != fa_allow or overflow.y != fa_allow){
		cache[CACHE.OVERFLOW] = new Surface(realistic.width, realistic.height);
	}
	
	calculate_layout();
}