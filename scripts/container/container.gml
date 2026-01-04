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

function container(style, parent = self) constructor{
	properties = style;
	
	efficient = {
		width: GUIW,
		height: GUIH,
		
		x: 0,
		y: 0,
	}
	
	realistic = {
		width: 0,
		height: 0,
		
		x: 0,
		y: 0,
	}
	
	vbuff = auto;
	cache = [];
	texture = get_default("texture", -1);
	matrix = identity;
	
	root = self;
	self.parent = parent;
	if (parent != self) root = parent.root;
	
	content = [];
	
	prepare_container();
	parse_calculations();
	calculate_container();
	
	add = function(element, amount = 1, index = array_length(content)){
		var final = [];
		var args = [index, final]
		
		repeat(amount){
			array_recurse(element, function(element, args){
				if (!is_callable(element[$ "draw"])) element = new container(element, self);
				else {
					element.parent = self;
					element.root = root;
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
		
		if (background.type == asset_surface) {
			background.value.check()
			texture = background.value.texture;
		}
		
		var mat = matrix_get(matrix_world);
		matrix_set(matrix_world, matrix_multiply(mat, matrix));
		vertex_submit(vbuff, pr_trianglelist, texture);
		matrix_set(matrix_world, mat);
		
		draw_content(content);
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



