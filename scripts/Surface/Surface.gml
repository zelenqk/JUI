globalvar SURFACE_LIST, SURFACE_ENTRIES;
SURFACE_LIST = [];
SURFACE_ENTRIES = {};

#macro asset_surface 14

function Surface(w, h, persist = false, format = surface_rgba8unorm) constructor{
	width = w;
	height = h;
	persistent = persist;
	self.format = format;
	
	camera = -1;
	
	surface = surface_create(width, height, format);
	texture = surface_get_texture(surface);

	size = get_format_size(format);
	
	checked = false;
	output = false;
	
	buffer = -1;
	top = -1;
	if (persistent) buffer = buffer_create(w * h * size, buffer_fixed, 1);
	
	type = asset_surface;
	
	check = function(resurface = persistent){
		if (surface_exists(surface)) return true;
		
		if (window_has_focus() and resurface) {	//на майка му путката човек
			surface_free(surface);		//for some reason without this we get a slight memory leak
										//this should not happen... like ever
			
			surface = surface_create(width, height, format);
			texture = surface_get_texture(surface);
			
			if (persistent) {
				if (!buffer_exists(buffer)) {
					size = get_format_size(format);
					buffer = buffer_create(width * height * size, buffer_fixed, 1);
				}
				
				buffer_set_surface(buffer, surface, 0);
			}
			
			return true;
		}
		
		texture = -1;
		return false;
	}
	
	resize = function(w, h){
		width = w;
		height = h;
		
		if (check(false)){
			if (persistent) {
				if (!buffer_exists(buffer)) {
					size = get_format_size(format);
					
					if (buffer_exists(buffer)) buffer_delete(buffer);
					buffer = buffer_create(w * h * size, buffer_fixed, 1);
				}
				
				buffer_set_surface(buffer, surface, 0);
			}
			
			surface_resize(surface, width, height);
		}
	}
	
	target = function(resurface = true){
		if (check(resurface) == false) return false;
		
		top = surface_get_target();
		topCamera = camera_get_active();
		if (top != -1) surface_reset_target();
		
		surface_set_target(surface);
		if (camera != -1) camera_apply(camera);
		return true;
	}
	
	reset = function(){
		if (surface_get_target() == surface) surface_reset_target();
		
		if (top != -1){
			surface_set_target(top);
			if (topCamera != -1) camera_apply(topCamera);
		}
		
		if (persistent and check(false)) buffer_get_surface(buffer, surface, 0);
		return true;
	};
	
	draw = function(tx, ty, w = width, h = height, resurface = false){
		if (check(persistent or resurface) == false) return;
		
		draw_surface_stretched(surface, tx, ty, w, h);
	}
	
	cleanup = function(){
		if (buffer_exists(buffer)) buffer_delete(buffer);
		if (check(false)) surface_free(surface);
	}
	
	//aliases
	free = cleanup;
	
	array_push(SURFACE_LIST, self);
}

function surface_purge(){
	for(var i = 0; i < array_length(SURFACE_LIST); i++){
		var surface = SURFACE_LIST[i];
		
		surface.free();
	}
}

function get_format_size(format){
	switch (format){
	//4u
	case surface_rgba4unorm:
		return 2;
	//8u
	case surface_r8unorm:
		return 1;
	case surface_rg8unorm:
		return 2;
	case surface_rgba8unorm:
		return 4;
	//16f
	case surface_rgba16float:
		return 8;
	case surface_r16float:
		return 2;
	//32f
	case surface_r32float:
		return 4;
	case surface_rgba32float:
		return 16;	

	default:
		show_error("unknown surface format", true);
	}
}