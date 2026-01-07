function prepare_container(){
	//layout
	direction = get_default("direction", column);
	wrap = get_default("wrap", false);
	
	visible = get_default("visible", true);
	
	width = get_default("width", 0);
	height = get_default("height", 0);
	
	var bg = get_default("background", c_white);
	background = {
		type: asset_get_type(bg),
		value: bg,
	}
	
	opacity = get_default("opacity", 1);
	
	if (is_struct(bg)) background.type = bg.type;
	
	anchor = {
		x: get_overwrite("anchorx", "anchor", get_overwrite_struct("anchor", "x", 0.5)),
		y: get_overwrite("anchory", "anchor", get_overwrite_struct("anchor", "y", 0.5)),
	}
	
	//text
	font = get_default("font", -1);
	fontSize = get_default("fontSize", 24);
	color = get_default("color", c_black);
	alpha = get_default("alpha", 1);
	
	//border
	border = get_default("border", 0);
	borderColor = get_overwrite("borderColor", "borderColour", c_white);
	
	//padding
	padding = {
		top:	get_overwrite(	"paddingTop",	"paddingBlock",		"padding", get_overwrite_struct("padding", "top",		"block",	0)),
		bottom:	get_overwrite(	"paddingTop",	"paddingBlock",		"padding", get_overwrite_struct("padding", "bottom",	"block",	0)),
		left:	get_overwrite(	"paddingLeft",	"paddingInline",	"padding", get_overwrite_struct("padding", "left",		"inline",	0)),
		right:	get_overwrite(	"paddingLeft",	"paddingInline",	"padding", get_overwrite_struct("padding", "right",		"inline",	0)),
	}
	
	//margin
	margin = {
		top:	get_overwrite(	"marginTop",	"marginBlock",		"margin", get_overwrite_struct("margin", "top",		"block",	0)),
		bottom:	get_overwrite(	"marginTop",	"marginBlock",		"margin", get_overwrite_struct("margin", "bottom",	"block",	0)),
		left:	get_overwrite(	"marginLeft",	"marginInline",		"margin", get_overwrite_struct("margin", "left",	"inline",	0)),
		right:	get_overwrite(	"marginLeft",	"marginInline",		"margin", get_overwrite_struct("margin", "right",	"inline",	0)),
	}
	
	//border radius
	borderRadius = {
		topLeft:		get_overwrite("borderRadiusTopLeft",		"borderRadiusTop",		"borderRadiusLeft",		"borderRadius", get_overwrite_struct("borderRadius", "topLeft",		"top",		"left",		auto)),
		bottomLeft:		get_overwrite("borderRadiusBottomLeft",		"borderRadiusBottom",	"borderRadiusLeft",		"borderRadius", get_overwrite_struct("borderRadius", "topRight",	"bottom",	"left",		auto)),	
		topRight:		get_overwrite("borderRadiusTopRight",		"borderRadiusTop",		"borderRadiusRight",	"borderRadius", get_overwrite_struct("borderRadius", "bottomLeft",	"top",		"right",	auto)),	
		bottomRight:	get_overwrite("borderRadiusBottomRight",	"borderRadiusBottom",	"borderRadiusRight",	"borderRadius", get_overwrite_struct("borderRadius", "bottomRight",	"bottom",	"right",	auto)),	
	}
	
	if (borderRadius.topLeft == auto and borderRadius.bottomLeft == auto and borderRadius.topRight == auto and borderRadius.bottomRight == auto) borderRadius = auto;
}