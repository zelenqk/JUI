/*
	This constructor is a simple way to use surfaces
	it even checks if you're inside a surface already
	and when you reset target it will re-target back to the "upper" surface
	
	currently i plan to use vertex buffers so i might not use it in the future
*/

globalvar SURFACE_LIST, TARGET;
SURFACE_LIST = [];
TARGET = -1;

function bsurface(w = 0, h = 0, format = surface_rgba8unorm) constructor{
	self.format = format;
	
	width = w;
	height = h;
	
	render = (width > 0 and height > 0);
	
	surface = (render) ? surface_create(width, height, format) : -1;
	pointer = (render) ? surface_get_texture(surface) : -1;
	
	upper = -1;
	exists = false;
	
	
	resurface = function(){
		exists = surface_exists(surface);
		
		if (!exists and render and window_has_focus()){
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
		if (TARGET == self) surface_reset_target();

		if (upper != -1) upper.target(false);
		else TARGET = -1;
		
		upper = -1;
	}
	
	free = function(){
		if (surface_exists(surface)) surface_free(surface);	
	}
	
	resize = function(w, h){
		width = abs(ceil(w));
		height = abs(ceil(h));
		
		if (width <= 1) render = false;
		if (height <= 1) render = false;
		
		render = true;
		if (resurface()) surface_resize(surface, width, height);
	}
	
	draw = function(tx = 0, ty = 0, opacity = 1){
		if (render and resurface()) draw_surface_ext(surface, tx, ty, 1, 1, 0, c_white, opacity);
	}
}


function surface_purge(){
	for(var i = 0; i < array_length(SURFACE_LIST); i++){
		var surface = SURFACE_LIST[i];
		surface.free();
	}
}