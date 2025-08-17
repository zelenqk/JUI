globalvar SURFACE_LIST, TARGET;
SURFACE_LIST = [];
TARGET = -1;

function bsurface(w = 1, h = 1, format = surface_rgba8unorm) constructor{
	self.format = format;
	
	width = w;
	height = h;
	
	surface = surface_create(width, height, format);
	pointer = surface_get_texture(surface);
	
	upper = -1;
	
	resurface = function(){
		var exists = surface_exists(surface);
		
		if (!exists and window_has_focus()){
			surface_free(surface);
			
			surface = surface_create(width, height, format)	
			pointer = surface_get_texture(surface);	
			
			return true;
		}
		
		return exists;
	}
	
	target = function(stack = true){
		if (!resurface()) return;
		
		surface_set_target(surface);
	}
	
	reset = function(){
		surface_reset_target();
		
	}
	
	free = function(){
		if (surface_exists(surface)) surface_free(surface);	
	}
	
	resize = function(w, h){
		width = w;
		height = h;
		
		if (resurface()) surface_resize(surface, width, height);
	}
	
	draw = function(tx = 0, ty = 0, w = width, h = height){
		if (resurface()) draw_surface(surface, tx, ty);
	}
}


function surface_purge(){
	for(var i = 0; i < array_length(SURFACE_LIST); i++){
		var surface = SURFACE_LIST[i];
		surface.free();
	}
}