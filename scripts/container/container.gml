/*
	This constructor is what the whole ui system is built off of
	
	ps. Dont forget to purge on cleanup!
*/

function container(style) constructor{
	self.style = style;
	parent = BASE_CONTAINER;
	
	dirty = true;
	
	perspective = get_default("perspective", false);
	target = new target_container();
	efficient = new target_container();	//might not use an efficient holder doe idk yet
	
	texture = -1;
	
	cache = {
		vbuff: vertex_create_buffer(),
	}
	
	line = [];
	
	x = 0;
	y = 0;
	
	//matrixes
	matrix = {
		scale: get_default("scale", auto),
		position: get_default("scale", auto),
		rotation: get_default("rotation", auto),
	}
	
	offset = {
		x: get_default("offsetx", 0),	
		y: get_default("offsety", 0),	
	}
	
	anchorx = get_default("anchorx", fa_center);
	anchory = get_default("anchory", fa_center);
	
	//layout properties
	width = get_unit(get_default("width", GUIW));
	height = get_unit(get_default("height", 0));
	
	display = get_default("display", fixed);
	position = get_default("position", relative);
	direction = get_default("direction", column);
	
	aspect = get_default("aspect");
	
	padding = {
		top: get_unit(get_overwrites(0, "paddingTop", "paddingVertical", "padding")),
		left: get_unit(get_overwrites(0, "paddingLeft", "paddingHorizontal", "padding")),
		right: get_unit(get_overwrites(0, "paddingRight", "paddingHorizontal", "padding")),
		bottom: get_unit(get_overwrites(0, "paddingBottom", "paddingVertical", "padding")),
	}
	
	margin = {
		top: get_unit(get_overwrites(0, "marginTop", "marginVertical", "margin")),
		left: get_unit(get_overwrites(0, "marginLeft", "marginHorizontal", "margin")),
		right: get_unit(get_overwrites(0, "marginRight", "marginHorizontal", "margin")),
		bottom: get_unit(get_overwrites(0, "marginBottom", "marginVertical", "margin")),
	}
	
	//style
	sprite = get_default("sprite");
	image = get_default("image", 0);
	
	background = get_default("background", c_white);
	opacity = get_default("opacity", 1);
	
	radius = {
		top: {
			left: get_unit(get_overwrites(0, "radiusTopLeft", "radiusTop", "radius")),
			right: get_unit(get_overwrites(0, "radiusTopRight", "radiusTop", "radius")),
		},
		bottom: {
			left: get_unit(get_overwrites(0, "radiusBottomLeft", "radiusBottom", "radius")),
			right: get_unit(get_overwrites(0, "radiusBottomRight", "radiusBottom", "radius")),	
		}
	}
	
	//children
	content = get_default("content", []);
	overflow = get_default("overflow", fa_allow);

	//functions
	add = function(element, index = 1){
		if (!is_array(content)) content = [content];
		
		//index is a multiplier value meaning 0 is start of the array 1 the end of the array + 1 and 0.5 is the middle
		index = array_length(content) * index;
		if (!is_callable(element[$ "draw"])) element = new container(element);
		
		element.parent = self;
		array_insert(content, index, element);
		dirty = true;
	
		return element;
	}
	
	draw = function() {
		if (dirty) calculate_container();
		
		if (perspective) {
			var w = GUIW;
			var h = GUIH;
			var aspect = w / h;
			var fov = 90;
			
			// Set up perspective projection
			var perspMat = matrix_build_projection_perspective_fov(
				fov,
				aspect,
				0.1,
				2000
			);
			matrix_set(matrix_projection, perspMat);
			
			// Calculate perfect camera Z for 1:1 scaling
			var fov_rad = degtorad(fov);
			var camZ = (h * 0.5) / sin(fov_rad * 0.5) * cos(fov_rad * 0.5); 
			// Equivalent to h/2 / tan(fov/2)
			
			// Build camera view matrix
			var camMat = matrix_build_lookat(
				w * 0.5, h * 0.5, camZ,   // Camera position
				w * 0.5, h * 0.5, 0,      // Look at center of screen
				0, -1, 0                 // Up vector
			);
			matrix_set(matrix_view, camMat);
		}
		
		var prvMat = matrix_get(matrix_world);
		var fmat = matrix_multiply(matrix.rotation, matrix.scale);
		
		fmat[MAT.X] = x + target.x;
		fmat[MAT.Y] = y + target.y;
		var tmat = matrix_multiply(fmat, prvMat);
		matrix_set(matrix_world, tmat);
		
		shader_set(shBorderRadius);
		shader_set_uniform_f(uRadius, target.radius.bottom.right, target.radius.top.right, target.radius.bottom.left, target.radius.top.left);
		shader_set_uniform_f(uSize, efficient.width / 2, efficient.height / 2);
		shader_set_uniform_f(uPos, 0, 0);
		
		vertex_submit(cache.vbuff, pr_trianglestrip, texture);
		shader_reset();
	
		draw_content(content);
	
		matrix_set(matrix_world, identity);
		matrix_set(matrix_projection, identity);
	};

	
	destroy = function(){
		vertex_delete_buffer(cache.vbuff);
	}
	
	//save to purge later
	JUI_CONTAINERS_LIST[array_length(JUI_CONTAINERS_LIST)] = self;
}


globalvar JUI_CONTAINERS_LIST;
JUI_CONTAINERS_LIST = [];

function container_purge(){
	var containersN = array_length(JUI_CONTAINERS_LIST);
	
	for(var i = 0; i < containersN; i++){
		var con = JUI_CONTAINERS_LIST[i];
		
		con.destroy();
		
	}
}