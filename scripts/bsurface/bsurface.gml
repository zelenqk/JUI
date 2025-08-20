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
		if (stack){
			if (TARGET != -1){
				upper = TARGET;
				surface_reset_target();
			}
		}
		
		if (resurface()){
			surface_set_target(surface);
			TARGET = self;
		}
	}
	
	reset = function(){
		if (TARGET == self)surface_reset_target();

		if (upper != -1) upper.target(false);
		else TARGET = -1;
		
		upper = -1;
	}
	
	free = function(){
		if (surface_exists(surface)) surface_free(surface);	
	}
	
	resize = function(w, h){
		width = w;
		height = h;
		
		if (w == 0) width = 1;
		if (h == 0) height = 1;

		if (resurface()) surface_resize(surface, round(width), round(height));
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