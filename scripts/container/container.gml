function container(style) constructor{
	dirty = true;
	parent = self;
	
	self.style = style;
	
	x = 0;
	y = 0;
	
	//properties
	position = get_default("position");
	
	display = get_default("display");
	direction = get_default("direction");
	overflow = get_default("overflow");
	aspect = get_default("aspect", auto);
	primary = get_default("primary", "height");
	secondary = "width";
	
	axis = {	//the axises in pixels
		main: 0,	
		secondary: 0,
	}
	
	//boundaries
	width = get_unit(get_default("width"));
	height = get_unit(get_default("height"));
	
	minimum = {
		"width": get_unit(get_default("minWidth", 0)),
		"height": get_unit(get_default("minHeight", 0)),
	}
	
	maximum = {}
	maximum.width = get_unit(get_default("maxWidth", GUIW));
	maximum.height = get_unit(get_default("maxHeight", GUIH));
	
	//background
	background = get_default("background");
	
	//sprite
	sprite = get_default("sprite", sPixel);
	
	image = get_default("image", 0);
	spriteXscale = get_unit(get_default("spriteXscale", -1));
	spriteYscale = get_unit(get_default("spriteYscale", -1));
	blend = get_default("blend", c_white);
	opacity = get_default("opacity", 1);
	
	object = get_default("object", -1);
	instance = (object == -1) ? -1 : instance_create_depth(x, y, -1, object, {parent: self, width: 0, height: 0});
	
	//children
	content = get_default("content", []);

	add = function(element, index = 1){
		if (!is_array(content)) content = [content];
		
		assign_parent(element, self);
		array_insert(content, index * array_length(content), element);
		dirty = true;
	}
	
	
	//style
	radius = {
		topLeft: get_unit(get_default("radiusTopLeft", get_default("radiusTop", get_default("radiusLeft", get_default("radius"))))),	
		topRight: get_unit(get_default("radiusTopRight", get_default("radiusTop", get_default("radiusRight", get_default("radius"))))),	
		bottomLeft: get_unit(get_default("radiusBottomLeft", get_default("radiusBottom", get_default("radiusLeft", get_default("radius"))))),	
		bottomRight: get_unit(get_default("radiusBottomRight", get_default("radiusBottom", get_default("radiusRight", get_default("radius"))))),	
	}
	
	margin = {
		left: get_unit(get_default("marginLeft", get_default("marginHorizontal", get_default("margin")))),
		right: get_unit(get_default("marginRight", get_default("marginHorizontal", get_default("margin")))),
		top: get_unit(get_default("marginTop", get_default("marginVertical", get_default("margin")))),
		bottom: get_unit(get_default("marginBottom", get_default("marginVertical", get_default("margin")))),
	}
	
	padding = {
		left: get_unit(get_default("paddingLeft", get_default("paddingHorizontal", get_default("padding")))),
		right: get_unit(get_default("paddingRight", get_default("paddingHorizontal", get_default("padding")))),
		top: get_unit(get_default("paddingTop", get_default("paddingVertical", get_default("padding")))),
		bottom: get_unit(get_default("paddingBottom", get_default("paddingVertical", get_default("padding")))),
	}
	
	gap = {
		left: get_unit(get_default("gapLeft", get_default("gapHorizontal", get_default("gap")))),
		right: get_unit(get_default("gapRight", get_default("gapHorizontal", get_default("gap")))),
		top: get_unit(get_default("gapTop", get_default("gapVertical", get_default("gap")))),
		bottom: get_unit(get_default("gapBottom", get_default("gapVertical", get_default("gap")))),
	}
	
	target = {
		width: 0,
		height: 0,
		
		//
		margin: {
			left: 0,
			right: 0,
			top: 0,
			bottom: 0,
		},
		
		padding: {
			left: 0,
			right: 0,
			top: 0,
			bottom: 0,
		},
		
		gap: {
			left: 0,
			right: 0,
			top: 0,
			bottom: 0,
		},
		
		//
		radius: {
			topLeft: 0,
			topRight: 0,
			bottomLeft: 0,
			bottomRight: 0,
		},
		
		minimum: {
			width: 0,
			height: 0,
		},
		
		maximum: {
			width: 0,
			height: 0,
		}
	};
	
	efficient = {
		width: 0,
		height: 0,
		x: 0,
		y: 0,
	}
	
	cache = {
		"background": new bsurface(),
		"overflow": new bsurface(),
	}
	
	calculate = function(parent = self.parent){
		target.width = GUIW;
		target.height = GUIH;
		
		//calculate min/max
		target.maximum.width = calculate_value(maximum.width, parent.target.width);
		target.maximum.height = calculate_value(maximum.height, parent.target.height);
		
		target.minimum.width = calculate_value(minimum.width, parent.target.width);
		target.minimum.height = calculate_value(minimum.height, parent.target.height);
		
		//target dimensions
		target.width = calculate_value(width, parent.target.width);
		target.height = calculate_value(height, parent.target.height);
		
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
		if (aspect != auto) target[$ secondary] = target[$ primary] * aspect;
		
		// target min/max
		target.width = max(target.width, target.minimum.width);
		target.height = max(target.height, target.minimum.height);
		
		target.width = min(target.width, target.maximum.width);
		target.height = min(target.height, target.maximum.height);
		
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
		target.gap.right = calculate_value(gap.right, target.width);
		target.gap.top = calculate_value(gap.top, target.height);
		target.gap.bottom = calculate_value(gap.bottom, target.height);	
		
		//calculate radius
		target.radius.topLeft = calculate_radius(radius.topLeft, axis.main);
		target.radius.topRight = calculate_radius(radius.topRight, axis.main);
		target.radius.bottomLeft = calculate_radius(radius.bottomLeft, axis.main);
		target.radius.bottomRight = calculate_radius(radius.bottomRight, axis.main);
		
		//calculate efficient width
		efficient.width = target.width + target.padding.left + target.padding.right;
		efficient.height = target.height + target.padding.top + target.padding.bottom;
		
		if (instance != -1) instance.width = efficient.width;
		if (instance != -1) instance.height = efficient.height;
		
		// efficient min/max
		efficient.width = max(efficient.width, target.minimum.width);
		efficient.height = max(efficient.height, target.minimum.height);
		
		efficient.width = min(efficient.width, target.maximum.width);
		efficient.height = min(efficient.height, target.maximum.height);
		
		//calculate sprite scale
		target.spriteXscale = (spriteXscale.unit == UNIT.PERCENT) ? calculate_value(spriteXscale, efficient.width / sprite_get_width(sprite)) :  calculate_value(spriteXscale, 0);
		target.spriteYscale = (spriteYscale.unit == UNIT.PERCENT) ? calculate_value(spriteYscale, efficient.height / sprite_get_height(sprite)) :  calculate_value(spriteYscale, 0);
		
		generate_layout();
		
		//update cache
		cache.background.resize(efficient.width, efficient.height);
		if (overflow == fa_hidden_wrap or overflow == fa_hidden) cache.overflow.resize(efficient.width, efficient.height);
		
		render();
	}
	
	render = function(){
		cache.background.target();
		draw_clear_alpha(c_black, 0);
		
		shader_set(shBorderRadius);
		
		shader_set_uniform_f(uRadius, target.radius.topLeft, target.radius.topRight, target.radius.bottomRight, target.radius.bottomLeft);
		shader_set_uniform_f(uSize, efficient.width / 2, efficient.height / 2);
		
		if (target.spriteXscale == -1) target.spriteXscale = efficient.width / sprite_get_width(sprite);
		if (target.spriteYscale == -1) target.spriteYscale = efficient.height / sprite_get_height(sprite);
		draw_sprite_stretched_ext(sPixel, 0, 0, 0, efficient.width, efficient.height, background, 1);
		
		shader_reset();
		
		gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_alpha);
		draw_sprite_tiled_ext(sprite, image, 0, 0, target.spriteXscale, target.spriteYscale, background, 1);
		gpu_set_blendmode(bm_normal);
		
		cache.background.reset();
		
		dirty = false;
	}
	
	draw = function(tx = 0, ty = 0){
		if (dirty) calculate();
		cache.background.draw(x + tx, y + ty, opacity);
		
		if (overflow == fa_hidden or overflow == fa_hidden_wrap){
			cache.overflow.target(){
				draw_clear_alpha(c_black, 0);
				draw_content(content, target.padding.left, target.padding.top);	
			}
			
			cache.overflow.reset();
			
			cache.overflow.draw();
		}else{
			draw_content(content, x + tx + target.padding.left, y + ty + target.padding.top);
		}
	}
	
	
	calculate();
}

function draw_content(content, mx = 0, my = 0){
	var contentLength = array_length(content);
	
	for(var i = 0; i < contentLength; i++){
		var element = content[i];
	
		if (is_array(element)) draw_content(element, mx, my);
		else element.draw(mx, my);
	}
}

function assign_parent(element, parent){
	if (!is_array(element)){
		element.parent = parent;
		return;
	}
	
	var contentLength = array_length(element);
	for(var i = 0; i < contentLength; i++){
		assign_parent(element[i], parent);
	}
}