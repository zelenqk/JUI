function calculate_container(layout = true){
	if (parent == BASE_CONTAINER) position = fixed;
	
	//calculate min/max
	target.maximum.width = calculate_value(maximum.width, parent.target.width);
	target.maximum.height = calculate_value(maximum.height, parent.target.height);

	target.minimum.width = calculate_value(minimum.width, parent.target.width);
	target.minimum.height = calculate_value(minimum.height, parent.target.height);

	//target dimensions
	target.width = calculate_value(width, parent.target.width);
	target.height = calculate_value(height, parent.target.height);

	// target min/max
	target.width = max(target.width, target.minimum.width);
	target.height = max(target.height, target.minimum.height);

	target.width = min(target.width, target.maximum.width);
	target.height = min(target.height, target.maximum.height);

	//find main axis
	switch (primary){
	case "width":
		axis.main = target.width;
		axis.secondary = target.height;
		secondary = "height";
		break;
	case "height":
		axis.main = target.height;
		axis.secondary = target.width;
		secondary = "width";
		break;
	default:
		axis.main = target.width;
		axis.secondary = target.height;
		primary = "width";
		secondary = "height";

		if (direction == column or direction == reverseColumn){
			axis.main = target.height;
			axis.secondary = target.width;
			primary = "height";
			secondary = "width";
		}
		break;
	}

	//calculate aspect ratio
	if (aspect != auto) target[$ secondary] = target[$ primary] / aspect;

	//styling dimensions
	target.margin.left = calculate_value(margin.left, target.width);
	target.margin.right = calculate_value(margin.right, target.width);
	target.margin.top = calculate_value(margin.top, target.height);
	target.margin.bottom = calculate_value(margin.bottom, target.height);

	target.padding.left = calculate_value(padding.left, target.width);
	target.padding.right = calculate_value(padding.right, target.width);
	target.padding.top = calculate_value(padding.top, target.height);
	target.padding.bottom = calculate_value(padding.bottom, target.height);

	target.gap.left = calculate_value(gap.left, target.width);
	target.gap.top = calculate_value(gap.top, target.height);

	//calculate radius
	target.radius.topLeft = calculate_radius(radius.topLeft, axis.main);
	target.radius.topRight = calculate_radius(radius.topRight, axis.main);
	target.radius.bottomLeft = calculate_radius(radius.bottomLeft, axis.main);
	target.radius.bottomRight = calculate_radius(radius.bottomRight, axis.main);

	if (text != -1){
		text = scribble(text);
		
		text.wrap(target.width);
	}
	
	if (layout) generate_layout();

	//calculate efficient width
	efficient.width = target.width + target.padding.left + target.padding.right;
	efficient.height = target.height + target.padding.top + target.padding.bottom;

	// efficient min/max
	efficient.width = max(efficient.width, target.minimum.width);
	efficient.height = max(efficient.height, target.minimum.height);

	efficient.width = round(min(efficient.width, target.maximum.width));
	efficient.height = round(min(efficient.height, target.maximum.height));

	if (position == fixed){
		switch (align){
		case fa_center:
			x = parent.target.width / 2 - efficient.width / 2;
			break;
		case fa_right:
			x = parent.target.width - efficient.width;
			break;
		}
		
		switch (justify){
		case fa_center:
			y = parent.target.height / 2 - efficient.height / 2;
			break;
		case fa_bottom:
			y = parent.target.height - efficient.height;
			break;
		}
	}

	instance = (object == -1) ? -1 : instance_create_depth(x, y, -1, object, {parent: self, width: efficient.width, height: efficient.height, persistent: other.persistent});

	if (instance != -1) instance.width = efficient.width;
	if (instance != -1) instance.height = efficient.height;

	//update cache
	//var aa = 12;
	//target.aa = aa * (target.radius.topLeft != 0 or target.radius.topRight != 0 or target.radius.bottomLeft != 0 or target.radius.bottomRight != 0);

	cache.background.resize(efficient.width , efficient.height);

	if (gradient != -1) cache.gradient.resize(efficient.width , efficient.height);
	if (overflow == fa_hidden_wrap or overflow == fa_hidden) cache.overflow.resize(efficient.width, efficient.height);
	if (blur > 0 and opacity < 1) cache.blurA.resize(efficient.width, efficient.height);
	if (blur > 0 and opacity < 1) cache.blurB.resize(efficient.width, efficient.height);

	render();
}