globalvar containersN;
containersN = 0; //used for tracking animation indexes and blabla

function container(style) constructor{
	dirty = true;
	parent = BASE_CONTAINER;
	
	id = containersN++;
	self.style = style;
	
	x = 0;
	y = 0;
	
	tx = 0;
	ty = 0;
	
	//properties
	position = get_default("position", relative);
	
	align = get_default("align", fa_left);
	justify = get_default("justify", fa_top);
	
	offsetx = get_default("offsetx", 0);
	offsety = get_default("offsety", 0);
	
	display = get_default("display");
	direction = get_default("direction");
	overflow = get_default("overflow", fa_allow);
	aspect = get_default("aspect", auto);
	
	tint = get_default("tint", c_white);
	
	blur = get_default("blur", -1);
	staticBlur = get_default("staticBlur", true);
	blurOpacity = get_default("blurOpacity", 1);
	blurStack = false;
	
	visible = get_default("visible", true);
	
	//axis
	primary = get_default("primary", "width");
	secondary = "height";
	
	gradient = get_default("gradient", -1);
	
	//scribble
	text = get_default("text", -1);
	
	axis = {	//the axises in pixels
		main: 0,	
		secondary: 0,
	}
	
	animations = [];
	
	//boundaries
	width = get_unit(get_default("width", 0));
	height = get_unit(get_default("height", 0));
	
	minimum = {
		"width": get_unit(get_default("minWidth", 0)),
		"height": get_unit(get_default("minHeight", 0)),
	}
	
	maximum = {}
	maximum.width = get_unit(get_default("maxWidth", infinity));
	maximum.height = get_unit(get_default("maxHeight", infinity));
	
	//background
	background = get_default("background");
	
	//sprite
	sprite = get_default("sprite", -1);
	
	image = get_default("image", 0);
	spriteXscale = get_unit(get_default("spriteXscale", -1));
	spriteYscale = get_unit(get_default("spriteYscale", -1));
	blend = get_default("blend", c_white);
	opacity = get_default("opacity", 1);
	
	object = get_default("object", -1);
	instance = -1;
	
	//children
	content = get_default("content", []);

	add = function(element, index = 1){
		if (!is_array(content)) content = [content];
		
		element = assign_parent(element, self);
		array_insert(content, index * array_length(content), element);
		dirty = true;
		
		return element;
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
		left: get_unit(get_default("gapLeft", get_default("gap"))),
		top: get_unit(get_default("gapTop", get_default("gap"))),
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
			top: 0,
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
		},
		
		aa: 0,
	};
	
	animations = get_default("animations", []);
	
	efficient = {
		width: 0,
		height: 0,
		x: 0,
		y: 0,
	}
	
	cache = {
		"background": new bsurface(),
		"overflow": new bsurface(),
		"gradient": new bsurface(),
		"blurA": new bsurface(),
		"blurB": new bsurface(),
	}
	
	render = function(){
		cache.background.target();
		draw_clear_alpha(background, 0);
		
		shader_set(shBorderRadius);
		
		shader_set_uniform_f(uRadius, target.radius.topLeft, target.radius.topRight, target.radius.bottomRight, target.radius.bottomLeft);
		shader_set_uniform_f(uSize, efficient.width, efficient.height);
		
		draw_sprite_stretched_ext(sPixel, 0, 0, 0, efficient.width, efficient.height, background, 1);
		
		shader_reset();
		
		if (sprite != -1){
			gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_alpha);
			draw_sprite_tiled_ext(sprite, image, 0, 0, target.spriteXscale, target.spriteYscale, tint, 1);
			gpu_set_blendmode(bm_normal);
		}
		
		cache.background.reset();
		
		if (gradient != -1){
			cache.gradient.target()
			draw_clear(c_white);
			
			shader_set(shLinearGradient);
			
			shader_set_uniform_f(uColN, 2);
			shader_set_uniform_f(uDirection, gradient[1]);
			shader_set_uniform_f_array(uColor, gradient[2]);
			shader_set_uniform_f_array(uFactor, gradient[3]);
			
			draw_sprite_stretched(sPixel, 0, 0, 0, width, height);
			
			shader_reset();
			cache.gradient.reset();
			
			cache.background.free();
			cache.background = cache.gradient;
		}
		
		dirty = false;
	}

	switch (overflow){
	case fa_hidden_wrap:
	case fa_hidden:
		drawType = draw_overflow;
		break;
	default:
		drawType = draw_vanilla;
		break;
	}
	
	draw = function(tx = 0, ty = 0){
		if (!visible) return;
		if (dirty) calculate_container(true);
		
		self.tx = tx;
		self.ty = ty;
		
		tx = x + tx + offsetx;
		ty = y + ty + offsety;
		
		if (instance != -1){
			instance.x = tx;
			instance.y = ty;
		}
		
		if (blur > 0){
			if (!staticBlur or blurStack == false) render_blur();
			cache.blurB.draw(tx, ty, blurOpacity);
		}
		
		cache.background.draw(tx, ty, opacity);
		
		drawType(tx, ty);
	}
}

function draw_content(content, mx = 0, my = 0){
	var contentLength = array_length(content);
	
	for(var i = 0; i < contentLength; i++){
		var element = content[i];
		
		if (is_array(element)) draw_content(element, mx, my);
		else{
			if (overflow == fa_hidden or overflow == fa_hidden_wrap) and (element.x > efficient.width or element.y > efficient.height) continue;
			
			element.draw(mx, my);
		}
	}
}

function assign_parent(element, parent){
	if (!is_array(element)){
		if (!is_callable(element[$ "draw"])){
			element = new container(element);	
		}
		
		element.parent = parent;
		return element;
	}
	
	var contentLength = array_length(element);
	for(var i = 0; i < contentLength; i++){
		element[i] = assign_parent(element[i], parent);
	}
	
	return element;
}