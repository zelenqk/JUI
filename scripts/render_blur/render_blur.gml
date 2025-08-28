function render_blur(){
	cache.blurA.target();
	cache.background.draw();
	
	shader_set(shBlurH);
	
	shader_set_uniform_f(uBlurSizeH, efficient.width, efficient.height);
	shader_set_uniform_f(uBlurRadiusH, blur);
	
	gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_alpha);
	draw_surface(application_surface, -(x + tx+ offsetx), -(y + ty + offsety));
	gpu_set_blendmode(bm_normal);
	
	shader_reset();
	cache.blurA.reset();
	
	cache.blurB.target();
	draw_clear_alpha(c_black, 0);
	
	shader_set(shBlurV);
	shader_set_uniform_f(uBlurSizeV, efficient.width, efficient.height);
	shader_set_uniform_f(uBlurRadiusV, blur);
	
	cache.blurA.draw();
	
	shader_reset();
	cache.blurB.reset();
}