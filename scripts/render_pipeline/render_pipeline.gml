function render_pipeline(){
	pipeline = [];
	
	if (parent != self and position == relative) pipeline_push(function(){
		realistic.x = parent.target.x + parent.efficient.padding.left + parent.contentOffset.x;
		realistic.y = parent.target.y + parent.efficient.padding.top + parent.contentOffset.y;
					  
		target.x = realistic.x + efficient.x + offset.x;	
		target.y = realistic.y + efficient.y + offset.y;
		
				
		boundaries.x = target.x;
		boundaries.y = target.y;
		boundaries.width = efficient.width;
		boundaries.height = efficient.height;
	})
	
	if (parent != self and position == fixed) pipeline_push(function(){
		realistic.x = parent.target.x + parent.efficient.padding.left;
		realistic.y = parent.target.y + parent.efficient.padding.top;
					  
		target.x = realistic.x + efficient.x + offset.x;	
		target.y = realistic.y + efficient.y + offset.y;
		
				
		boundaries.x = target.x;
		boundaries.y = target.y;
		boundaries.width = efficient.width;
		boundaries.height = efficient.height;
	})
	
	if (parent == self) pipeline_push(function(){
		target.x = efficient.x + offset.x;	
		target.y = efficient.y + offset.y;
				
		boundaries.x = target.x;
		boundaries.y = target.y;
		boundaries.width = efficient.width;
		boundaries.height = efficient.height;

	})
	
	if (create != auto) method(self, create)();
	if (step != auto) pipeline_push(method(self, step));
	
	if (backgroundIsMySurface) pipeline_push(function(){
		background.check();
		
		texture = background.texture;
	});
	
	//cookie
	if (root == self){
		pipeline_push(function(){
			matrix[12] = target.x;
			matrix[13] = target.y;
			
			matrix[0] = scale.x;
			matrix[6] = scale.y;
				
			matrix_set(matrix_world, matrix);
		});
	}else{
		pipeline_push(function(){
			matrix[12] = target.x;
			matrix[13] = target.y;
			
			matrix[0] = scale.x;
			matrix[6] = scale.y;
				
			matrix_set(matrix_world, matrix);
		});
	}
	//cookie cutter
	if (borderRadiusEnabled and inOverflow == false){
		pipeline_push(function(){
			shader_set(shBorderRadius);
		
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "color"), colour_get_red(color) / 256, colour_get_green(color) / 256, colour_get_blue(color) / 256, alpha);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "position"), target.x, target.y);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "size"), efficient.width / 2, efficient.height / 2);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "radius"), efficient.borderRadius.topRight, efficient.borderRadius.bottomRight, efficient.borderRadius.topLeft, efficient.borderRadius.bottomLeft);
			
			vertex_submit(vbuff, pr_trianglelist, texture);
			shader_reset();
		});
	}else if (borderRadiusEnabled and inOverflow){
		pipeline_push(function(){
			shader_set(shBorderRadius);
		
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "color"), colour_get_red(color) / 256, colour_get_green(color) / 256, colour_get_blue(color) / 256, alpha);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "position"), efficient.x + parent.contentOffset.x, efficient.y + parent.contentOffset.y);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "size"), efficient.width / 2, efficient.height / 2);
			shader_set_uniform_f(shader_get_uniform(shBorderRadius, "radius"), efficient.borderRadius.topRight, efficient.borderRadius.bottomRight, efficient.borderRadius.topLeft, efficient.borderRadius.bottomLeft);
			
			vertex_submit(vbuff, pr_trianglelist, texture);
			shader_reset();
		});
	}else{
		pipeline_push(function(){
			shader_set(shOverride);
			shader_set_uniform_f(shader_get_uniform(shOverride, "color"), colour_get_red(color) / 256, colour_get_green(color) / 256, colour_get_blue(color) / 256, alpha);
			vertex_submit(vbuff, pr_trianglelist, texture);
			shader_reset();
		});
	}
	
	if (self.overflow != fa_allow) pipeline_push(function(index){
		camera_set_view_pos(camera, target.x + efficient.padding.left, target.y + efficient.padding.top);
		var overflow = cache[JUI_CACHE.OVERFLOW];
		
		if (overflow.target()){
			draw_clear_alpha(c_black, 0);
			camera_apply(camera);
		}
	});
	
	pipeline_push(function(){
		array_foreach(segments, function(segment){
			segment.draw();
		});
	});
	
	pipeline_push(function(){
		array_foreach(fixedContent, function(element){
			element.draw();
		});
	});
	
	if (self.overflow != fa_allow) pipeline_push(function(){
		var overflow = cache[JUI_CACHE.OVERFLOW];
		
		if (overflow.reset()){
			matrix_set(matrix_world, matrix);
			overflow.draw(efficient.padding.left, efficient.padding.top);
		}
	});
	
	if (overflow == fa_scroll) pipeline_push(scroll.draw);
	
	if (root == self) pipeline_push(function(){
		matrix_set(matrix_world, matrix_build_identity());
	});
		

}

function pipeline_push(script){
	array_push(pipeline, script);
}