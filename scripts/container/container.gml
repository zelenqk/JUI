#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()
#macro identity matrix_build_identity()
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

function container(style, parent = self) constructor{
	properties = style;
	
	efficient = {
		width: 0,
		height: 0,
		
		x: 0,
		y: 0,
	}
	
	realistic = {
		width: 0,
		height: 0,
		
		x: 0,
		y: 0,
	}
	
	target = {};
	
	scale = {
		x: 0,
		y: 0,
		z: 0
	}
	
	vbuff = auto;
	cache = [];
	segments = []
	texture = get_default("texture", -1);
	matrix = identity;
	inmat = identity;
	pipeline = {
		length: 0,
		content: [],
	};
	
	overflow = get_default("overflow", fa_hidden);
	
	step = get_default("step", auto);
	
	root = self;
	self.parent = parent;
	if (parent != self) root = parent.root;
	
	contentoffset = {
		x: get_default("contentOffsetX", 0),
		y: get_default("contentOffsetY", 0),
	}
		
	content = get_default("content", []);
	
	prepare_container();
	parse_calculations();
	calculate = method(self, calculate_container);
	calculate();
	
	render_pipeline();
	
	add = function(element, amount = 1, index = array_length(content)){
		var final = [];
		var args = [index, final, false]
		
		repeat(amount){
			array_recurse(element, function(element, args){
				if (!is_callable(element[$ "draw"])) element = new container(element, self);
				else {
					element.parent = self;
					element.root = root;
					
					if (args[2]) element = new container(element.properties, self);
					else element.calculate();
					
					args[2] = true;
				};
				
				array_insert(content, args[0]++, element)
				array_push(args[1], element);
			}, args);
		}
		
		if (array_length(final) == 1) return final[0];
		return final;
	}
	
	draw = function(){
		if (!visible) return;
		
		efficient.x = 0;
		efficient.y = 0;
		
		var i = 0;
		repeat(pipeline.length){
			var render = pipeline.content[i++]
			render();
		}
		
		matrix_set(matrix_world, mat);
	}
	
	cleanup = function(freeChildren = true){
		if (vbuff != auto) vertex_delete_buffer(vbuff);
			
		for(var i = 0; i < array_length(cache); i++){
			
		}
		
		if (freeChildren) array_recurse(content, function(element){
			element.cleanup();	
		});
	}
	
}



