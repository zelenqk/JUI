function render_backdrop(){
	var backdrop = cache[CACHE.BACKDROP];
	
	var t = surface_get_target();
	t = (t == -1) ? application_surface : t;
	
	if (backdrop.target()){
		draw_clear_alpha(c_black, 1);
		
		shader_set(self.backdrop.shader);
		for(var i = 0; i < array_length(self.backdrop.arguments); i++){
			var arg = self.backdrop.arguments[i];
			shader_set_uniform_f_array(arg.uniform, arg.value);	
		}
		
		draw_surface_part(t, realistic.x, realistic.y, efficient.width, efficient.height, 0, 0);
		
		shader_reset();
		backdrop.reset();
		
		if (self.backdrop.pass != auto){
			var pass = cache[CACHE.BACKDROP_PASS];
			
			if (pass.target()){
				shader_set(self.backdrop.pass);
				for(var i = 0; i < array_length(self.backdrop.arguments); i++){
					var arg = self.backdrop.arguments[i];
					shader_set_uniform_f_array(arg.uniform, arg.value);	
				}
				
				backdrop.draw(0, 0);
				shader_reset();
				
				pass.reset();
			}
		}
	}
}