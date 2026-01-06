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
	calculate = method(self, calculate_container);
	
	calculate();
	
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
		
		if (background.type == asset_surface) {
			background.value.check()
			texture = background.value.texture;
		}
		
		var mat = matrix_get(matrix_world);
		matrix = matrix_build(realistic.x + efficient.width	* anchor.x, realistic.y + efficient.height	* anchor.y, 0, 0, 0, 0, 1, 1, 1);

		var inmat = matrix_multiply(mat, matrix);
		matrix_set(matrix_world, inmat);

		shader_set(shBorderRadius);
		
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "position"), inmat[12] - efficient.width * anchor.x, inmat[13] - efficient.height * anchor.y);
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "size"), efficient.width / 2, efficient.height / 2);
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "radius"), efficient.borderRadius.bottomRight, efficient.borderRadius.topRight, efficient.borderRadius.bottomLeft, efficient.borderRadius.topLeft);
		
		vertex_submit(vbuff, pr_trianglelist, texture);
		shader_reset();
		
		draw_content(content);
		
		parent.efficient.x += (parent.direction == row) * realistic.width + efficient.margin.left + efficient.margin.right;
		parent.efficient.y += (parent.direction == column) * realistic.height + efficient.margin.top + efficient.margin.bottom;
		
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



