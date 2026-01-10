#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()

#macro auto -2

//direction
#macro column 0
#macro row 1

//overflow
#macro fa_allow 0
#macro fa_scroll 1

//position
#macro relative 0
#macro fixed 1
#macro absolute 2
#macro sticky 3

enum CACHE { OVERFLOW, BACKDROP, BACKDROP_PASS, PICKER , SIZE};

function container(style, parent = self) constructor{
	properties = style;
	
	bake = get_default("bake", false);
	calculated = parent;
	
	x = 0;
	y = 0;
	
	arguments = get_default("arguments", auto);
	
	//caching
	picker = auto;

	vbuff = auto;
	cache = array_create(CACHE.SIZE, auto);
	segments = [];
	texture = get_default("texture", -1);
	backdrop = get_default("backdrop", auto);
	matrix = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	identity = matrix_build_identity();
	mask = 1;
	pipeline = {
		length: 0,
		content: [],
	};
	
	index = #000000;
	
	segment = new JUI_SEGMENT(0, 0, 0, 0, 0, 0, 0, fa_allow, 0, 0);
	
	overflow = {
		x: get_overwrite_struct("overflow", "x", get_overwrite("overflowx", "overflow", fa_allow)),
		y: get_overwrite_struct("overflow", "y", get_overwrite("overflowy", "overflow", fa_allow)),
		
		top: self,
	}
	
	scale = {
		x: get_overwrite_struct("scale", "x", get_overwrite("scalex", "scale", 1)),
		y: get_overwrite_struct("scale", "y", get_overwrite("scaley", "scale", 1)),
		z: 0,
	}
	
	step = get_default("step", auto);
	postStep = get_default("postStep", auto);
	
	root = self;
	self.parent = parent;
	if (parent != self) root = parent.root;
	
	content = {
		offset: {
			x: 0,
			y: 0,
		},
		
		children: get_default("content", []),
	}
	
	hover = function(){
		return mouse_in_box(target.x + offset.x, target.y + offset.y, efficient.width * scale.x, efficient.height * scale.y);	
	}

	add = function(element, amount = 1, index = array_length(content.children)){
		var final = [];
		var args = [index, final, false]
		
		repeat(amount){
			array_recurse(element, function(element, args){
				if (!is_callable(element[$ "draw"])) element = new container(element, self);
				else {
					element.parent = self;
					element.root = root;
					
					if (args[2]) element = new container(element.properties, self);
					else if (element.calculated != self){
						element.calculate();
					}
					
					args[2] = true;
				};
				
				array_insert(content.children, args[0]++, element);
				
				var segment = array_last(segments);
				if !(segment.add(element)){
					var segment = new JUI_SEGMENT(segment.left, segment.top, direction, segment.width, segment.height, segment.gap, segment.wrap, overflow.x, segment.efficient.x, segment.efficient.y, segment.realistic.x, segment.realistic.y);
					if (segment.add(element)) array_push(segments, segment);
				}
				
				array_push(args[1], element);
			}, args);
		}
		
		if (array_length(final) == 1) return final[0];
		return final;
	}
	
	draw = function(){
		if (vbuff == auto){
			render_background();
			
			calculate_layout();
			if (root == self){
				cache[CACHE.PICKER] = new Surface(efficient.width, efficient.height, true);
				identity = matrix_build_identity();
			}
			
		}
		
		render();
		draw = render;	
	}
	
	render = function(){
		if (!visible) return;

		var i = 0;
		repeat(pipeline.length){
			var pipe = pipeline.content[i++]
			pipe(realistic.x, realistic.y);
		}
	}
	
	cleanup = function(freeChildren = true){
		if (vbuff != auto) vertex_delete_buffer(vbuff);
		
		for(var i = 0; i < array_length(cache); i++){
			if (cache[i] != auto) cache[i].cleanup();
		}
		
		if (freeChildren) {
			for(var i = 0; i < array_length(segments); i++){
				var segment = segments[i];	
				segment.cleanup(freeChildren);
			}
		}
	}
	
	//render the container
	prepare_container();
	parse_calculations();
	calculate = method(self, calculate_container);
	calculate();
	
	render_pipeline();
	
}



