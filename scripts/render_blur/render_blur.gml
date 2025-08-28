function render_blur(){
	//horizontal pass
	cache.blurA.target();
	
	shader_set(shBlurH);
	
	shader_set_uniform_f(uBlurSizeH, efficient.width, efficient.height);
	shader_set_uniform_f(uBlurRadiusH, blur);
	
	draw_surface(application_surface, -(x + tx + offsetx), -(y + ty + offsety));
	
	shader_reset();
	

	
	cache.blurA.reset();
	
	//vertical pass
	cache.blurB.target();
	
	shader_set(shBlurV);
	shader_set_uniform_f(uBlurSizeV, efficient.width, efficient.height);
	shader_set_uniform_f(uBlurRadiusV, blur);
	
	cache.blurA.draw();
	
	shader_reset();
	
	gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
	cache.background.draw();
	gpu_set_blendmode(bm_normal);
	
	cache.blurB.reset();
	
	blurStack = true;
}