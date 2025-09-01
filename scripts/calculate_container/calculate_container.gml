function calculate_container(){
	//dimensions
	target.width = calculate_value(width, parent.width);
	target.height = calculate_value(width, parent.height);

	target.padding = {};
	target.padding.left = calculate_value(padding.left, parent.width);
	target.padding.right = calculate_value(padding.right, parent.width);
	target.padding.top = calculate_value(padding.top, parent.height);
	target.padding.bottom = calculate_value(padding.bottom, parent.height);
	
	target.margin = {};
	target.margin.left = calculate_value(margin.left, parent.width);
	target.margin.right = calculate_value(margin.right, parent.width);
	target.margin.top = calculate_value(margin.top, parent.height);
	target.margin.bottom = calculate_value(margin.bottom, parent.height);
	
	generate_layout();
	
	
	//style
	
	////radius
	target.radius = {};
	target.radius.left = {};
	target.radius.right = {};
	target.radius.left.top = calculate_value(radius.left.top, efficient.height);
	target.radius.left.bottom = calculate_value(radius.left.bottom, efficient.height);
	target.radius.right.top = calculate_value(radius.right.top, efficient.height);
	target.radius.right.bottom = calculate_value(radius.right.bottom, efficient.height);
	
	////background
	target.background = (is_array(background) or background <= auto) ? get_rgb(c_white) : get_rgb(background);
	
	
	
	
	
}