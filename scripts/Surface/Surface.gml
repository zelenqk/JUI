globalvar SURFACE_LIST;
SURFACE_LIST = [];

#macro asset_surface 14

function Surface(w, h, Format = surface_rgba8unorm, persist = false) constructor{
	width = w;
	height = h;
	
	persistent = persist;
	format = Format;
	surface = surface_create(width, height, format);
	texture = surface_get_texture(surface);

	size = get_format_size(format);
	
	buffer = -1;
	if (persistent) buffer = buffer_create(w * h * size, buffer_fixed, 1);
	
	type = asset_surface;
	
	check = function(resurface = true){
		if (surface_exists(surface)) return true;
		
		if (window_has_focus() and resurface) {
			surface = surface_create(width, height, format);
			texture = surface_get_texture(surface);
			
			if (persistent) {
				if (!buffer_exists(buffer)) {
					size = get_format_size(format);
					
					if (buffer_exists(buffer)) buffer_delete(buffer);
					buffer = buffer_create(w * h * size, buffer_fixed, 1);
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
	
	target = function(){
		if (check() == false) return false;
		if (surface_get_target() != -1) surface_reset_target();
		
		surface_set_target(surface);
		return true;
	}
	
	reset = function(){
		surface_reset_target();
		if (persistent and check(false)) buffer_get_surface(buffer, surface, 0);
	};
	
	draw = function(tx, ty, w = width, h = height){
		if (check(persistent) == false) return;
		
		draw_surface_stretched(surface, tx, ty, w, h)
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
	case surface_r8unorm:
		return 1;
	case surface_rg8unorm:
		return 2;
	case surface_rgba8unorm:
		return 4;
	case surface_rgba4unorm:
		return 2;
	case surface_rgba16float:
		return 8;
	case surface_r16float:
		return 2;	
	case surface_rgba32float:
		return 16;	
	case surface_r32float:
		return 4;
	default:
		show_error("unknown surface format", true);
	}
}