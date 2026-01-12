function container(properties = {}, parent = self) constructor{
	self.properties = properties;
	self.parent = parent;
	root = parent;
	root = parent.root;
	
	calculated = parent;

	texture = -1;
	vbuff = vertex_create_buffer();
	matrix = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	cache = [];
	camera = auto;
	pipeline = [];
	
	content = [];
	fixedContent = [];
	absoluteContent = [];
	
	contentOffset = {
		x: 0,
		y: 0,
	}
	
	segments = [];
	
	target = {};
	efficient = {};
	scissor = {x: 0, y: 0, width: GUIW, height: GUIH};
	realistic = {
		x: 0,
		y: 0,
		width: 0,
		height: 0,
	};
	
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
		var length = array_length(pipeline);
		
		var i = 0;
		repeat(length){
			var render = pipeline[i++];
			render();
		}
	}
	
	cleanup = function(){
		vertex_delete_buffer(vbuff);
		
		if (camera != auto) camera_destroy(camera);
		
		array_foreach(cache, function(cache){
			if (cache != auto) cache.cleanup();
		});
	}
	
	//realize
	prepare_container();
	parse_calculations();
	
	calculate = method(self, calculate_container);
	calculate(false);
}