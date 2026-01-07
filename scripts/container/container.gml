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
	
	bake = get_default("bake", false);
	calculated = parent;
	
	x = 0;
	y = 0;
	
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
					else if (element.calculated != self) element.calculate();
					
					args[2] = true;
				};
				
				array_insert(content.children, args[0]++, element);
				
				var segment = array_last(segments);
				if !(segment.add(element)){
					var segment = new JUI_SEGMENT(segment.left, segment.top, direction, segment.width, segment.height, segment.wrap);
					if (segment.add(element)) array_push(segment);
				}
				
				array_push(args[1], element);
			}, args);
		}
		
		if (array_length(final) == 1) return final[0];
		return final;
	}
	
	render = function(){
		if (vbuff != auto) vertex_delete_buffer(vbuff);
		vbuff = vertex_create_buffer();
		
		vertex_begin(vbuff, JUI_FORMAT);
		switch (background.type){
		case asset_surface:
			var surface = background.value;
			texture = surface.texture;
			
			build_quad(vbuff, x + anchor.x, y + anchor.y, efficient.width, efficient.height, c_white, efficient.opacity);
			break;
		case asset_sprite:
			var sprite = background.value;
			var uv = sprite_get_uvs(background.value, 0);
			
			build_quad(vbuff, x + anchor.x, y + anchor.y, efficient.width, efficient.height, c_white, efficient.opacity, {
				x: uv[0],	
				y: uv[1],
				width: uv[2] - uv[0],
				height: uv[3] - uv[1],
			});
			
			texture = sprite_get_texture(sprite, 0);
			break;
		default:
			var color = c_white;
			if (is_ptr(background.value)) texture = background.value;
			else color = background.value;
			
			build_quad(vbuff, x + anchor.x, y + anchor.y, efficient.width, efficient.height, color, efficient.opacity);
			break;
		}	
	}
	
	draw = function(){
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



