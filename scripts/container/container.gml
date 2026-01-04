#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()
#macro auto -2
#macro identity matrix_build_identity()

#macro column 0
#macro row 1

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
	calculate_layout();
	
	draw = function(){
		if (!visible) return;
		
		if (background.type == asset_surface) {
			background.value.check()
			texture = background.value.texture;
		}
		
		matrix_set(matrix_world, matrix);
		vertex_submit(vbuff, pr_trianglelist, texture);
		matrix_set(matrix_world, identity);
		
		
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



