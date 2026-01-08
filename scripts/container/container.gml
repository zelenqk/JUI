#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()
globalvar identity;
identity = matrix_build_identity()

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

enum CACHE { OVERFLOW, BACKDROP };

function container(style, parent = self) constructor{
	properties = style;
	
	bake = get_default("bake", false);
	calculated = parent;
	
	x = 0;
	y = 0;
	
	vbuff = auto;
	cache = [];
	segments = [];
	texture = get_default("texture", -1);
	matrix = identity;
	inmat = identity;
	pipeline = {
		length: 0,
		content: [],
	};
	
	overflow = {
		x: get_overwrite_struct("overflow", "x", get_overwrite("overflowx", "overflow", fa_allow)),
		y: get_overwrite_struct("overflow", "y", get_overwrite("overflowy", "overflow", fa_allow)),
		
		top: self,
	}
	
	scale = {
		x: 1,
		y: 1,
	}
	
	step = get_default("step", auto);
	
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
					var segment = new JUI_SEGMENT(segment.left, segment.top, direction, segment.width, segment.height, segment.wrap);
					if (!segment.add(element)) return false;
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
			draw = render;	
			return;
		}
		
		render();
	}
	
	render = function(){
		if (!visible) return;
		
		efficient.x = 0;
		efficient.y = 0;
		
		var i = 0;
		repeat(pipeline.length){
			var pipe = pipeline.content[i++]
			pipe();
		}
	}
	
	cleanup = function(freeChildren = true){
		if (vbuff != auto) vertex_delete_buffer(vbuff);
		
		if (freeChildren) array_recurse(content.children, function(element){
			element.cleanup();	
		});
	}
	
	//render the container
	prepare_container();
	parse_calculations();
	calculate = method(self, calculate_container);
	calculate();
	
	render_pipeline();
	
}



