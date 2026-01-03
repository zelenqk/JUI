function prepare_container(){
	//layout
	visible = get_default("visible", true);
	
	width = get_default("width", 0);
	height = get_default("height", 0);
	
	var bg = get_default("background", c_white);
	background = {
		type: asset_get_type(bg),
		value: bg,
	}
	
	if (is_struct(bg)) background.type = bg.type;
			
	
	
	anchor = {
		x: get_overwrite("anchorx", "anchor", 0.5),
		y: get_overwrite("anchory", "anchor", 0.5),
	}
	
	opacity = get_default("opacity", 0);
	
	//text
	font = get_default("font", -1);
	fontSize = get_default("fontSize", 24);
	color = get_default("color", c_black);
	alpha = get_default("alpha", 1);
	
	
	
	
	
	
	//padding
	padding = {
		top: get_overwrite("paddingTop", "paddingBlock", "padding"),
		bottom: get_overwrite("paddingTop", "paddingBlock", "padding"),
		left: get_overwrite("paddingLeft", "paddingInline", "padding"),
		right: get_overwrite("paddingLeft", "paddingInline", "padding"),
	}
	
	//margin
	margin = {
		top: get_overwrite("marginTop", "marginBlock", "margin"),
		bottom: get_overwrite("marginTop", "marginBlock", "margin"),
		left: get_overwrite("marginLeft", "marginInline", "margin"),
		right: get_overwrite("marginLeft", "marginInline", "margin"),
	}
	
	//border radius
	borderRadius = {
		topLeft: get_overwrite("borderRadiusTopLeft", "borderRadiusTop", "borderRadiusLeft", "borderRadius", 0),	
		topRight: get_overwrite("borderRadiusTopRight", "borderRadiusTop", "borderRadiusRight", "borderRadius", 0),	
		bottomLeft: get_overwrite("borderRadiusBottomLeft", "borderRadiusBottom", "borderRadiusLeft", "borderRadius", 0),	
		bottomRight: get_overwrite("borderRadiusBottomRight", "borderRadiusBottom", "borderRadiusRight", "borderRadius", 0),	
	}
	


}