function container(properties = {}, parent = self) constructor{
	self.properties = properties;
	self.parent = parent;
	root = parent;
	root = parent.root;
	
	calculated = parent;
	
	boundaries = {x: 0, y: 0, width: 0, height: 0};
	inOverflow = false;
	hovering = -1;
	
	texture = -1;
	vbuff = vertex_create_buffer();
	matrix = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	cache = array_create(JUI_CACHE.LENGTH, auto);
	camera = auto;
	pipeline = [];
	
	content = [];
	fixedContent = [];
	absoluteContent = [];
	
	depth = 0;
	depth = parent.depth + 1;
	
	contentOffset = {
		x: 0,
		y: 0,
	}
	
	segments = [];
	
	target = {x: 0, y: 0};
	efficient = {x: 0, y: 0};
	mask = 1;
	topMask = 0;
	realistic = {x: 0, y: 0, width: 0, height: 0};
	
	//methods
	append = function(element){
		if (!is_callable(element[$ "draw"])) element = new container(element, self);
		
		if (element.calculated != root){
			element.parent = self;
			element.root = root;
			
			element.calculate();
		}

		array_push(content, element);
		
		var segment = array_last(segments);
		segment.add(element);
		return element;
	}
	
	add = function(element, amount = 1){
		var list = [];
		
		if (is_array(element)){
			for(var i = 0; i < array_length(element); i++){
				var e = element[i];
				array_push(list, append(e));
			}
			
			return list;
		}
		
		if (amount > 1){
			repeat(amount) array_push(list, append(element));
			return list;
		}
		
		return append(element);
	}
	
	draw = function(){
		if (!visible) return;
		var length = array_length(pipeline);
		
		var i = 0;
		repeat(length){
			var render = pipeline[i++];
			render(i - 1);
		}
	}
	
	cleanup = function(){
		vertex_delete_buffer(vbuff);
		
		if (camera != auto) camera_destroy(camera);
		
		array_foreach(cache, function(element){
			if (element != auto) element.cleanup();
		});
	}
	
	//utils
	hover_overflow = function(){
	    boundaries.x = target.x;
	    boundaries.y = target.y;
		
	    mouse = mouse_in_box(boundaries.x, boundaries.y, efficient.width, efficient.height);
	
	    if (mouse != -1 and (root.hovering == -1 or depth > root.hovering.depth)) root.hovering = self;
		else if (mouse == -1 and root.hovering == self) root.hovering = -1;
		
	    return (root.hovering == self);
	}
	
	hover_default = function()
	{
	    boundaries.x = target.x;
	    boundaries.y = target.y;
	
	    mouse = mouse_in_box(target.x, target.y, efficient.width, efficient.height);
	
	    if (mouse != -1 and (root.hovering == -1 or depth > root.hovering.depth)) root.hovering = self;
		else if (mouse == -1 and root.hovering == self) root.hovering = -1;
		
	    return (root.hovering == self);
	}
		
	hover = auto;
	
	//realize
	prepare_container();
	parse_calculations();
	
	calculate = method(self, calculate_container);
	calculate(false);
}