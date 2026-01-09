function render_pipeline(){
	pipeline.length = 0;
	pipeline.content = [];
	
	if (background.type == asset_surface) pipeline_push(function(){
		background.value.check();
		texture = background.value.texture;
	});
	
	if (step != auto) pipeline_push(method(self, step));
	
	if (borderRadius != auto) pipeline_push(function(){
		shader_set(shBorderRadius);
		
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "position"), realistic.x, realistic.y);
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "size"), (efficient.width / 2) * scale.x, (efficient.height / 2) * scale.y);
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "radius"), efficient.borderRadius.topRight, efficient.borderRadius.bottomRight, efficient.borderRadius.topLeft, efficient.borderRadius.bottomLeft);
	});
	
	pipeline_push(function(){
		realistic.x = x + efficient.margin.left + efficient.manualOffset.x + (efficient.width * anchor.x) * scale.x;
		realistic.y = y + efficient.margin.top + efficient.manualOffset.y + (efficient.height * anchor.y) * scale.y;
		
		matrix_build(realistic.x , realistic.y, 0, 0, 0, 0, scale.x, scale.y, 0, matrix);
		
		matrix_set(matrix_world, matrix);
		vertex_submit(vbuff, pr_trianglelist, texture);
	});
	
	if (borderRadius != auto) pipeline_push(function(){
		shader_reset();
	});
	
	if ((overflow.x != fa_allow or overflow.y != fa_allow) and (array_length(segments) > 0)){ pipeline_push(function(){
			var overflow = cache[CACHE.OVERFLOW];
			
			if (overflow.target()){
				draw_clear_alpha(c_black, 0);
				draw_content();
				overflow.reset();
				
				matrix_set(matrix_world, identity);	
				overflow.draw(realistic.x + efficient.padding.left, realistic.y + efficient.padding.top);
			}
		});
	}else pipeline_push(draw_content);	//draw children (debug stage atm)
	
	if (root == self) pipeline_push(function(){
		matrix_set(matrix_world, identity);	
	})
}

function pipeline_push(render){
	array_push(pipeline.content, render);
	pipeline.length++;
}

/*
		if (background.type == asset_surface) {
			background.value.check()
			texture = background.value.texture;
		}
		
		var mat = matrix_get(matrix_world);
		matrix = matrix_build(realistic.x + (efficient.width * anchor.x) + parent.efficient.x, realistic.y + (efficient.height * anchor.y) + parent.efficient.y, 0, 0, 0, 0, 1, 1, 1);

		var inmat = matrix_multiply(mat, matrix);
		matrix_set(matrix_world, inmat);

		shader_set(shBorderRadius);
		
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "position"), inmat[12] - efficient.width * anchor.x, inmat[13] - efficient.height * anchor.y);
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "size"), efficient.width / 2, efficient.height / 2);
		shader_set_uniform_f(shader_get_uniform(shBorderRadius, "radius"), efficient.borderRadius.bottomRight, efficient.borderRadius.topRight, efficient.borderRadius.bottomLeft, efficient.borderRadius.topLeft);
		
		vertex_submit(vbuff, pr_trianglelist, texture);
		shader_reset();
		
		draw_content(content);
		
		parent.efficient.x += (parent.direction == row) * realistic.width + efficient.margin.left + efficient.margin.right;
		parent.efficient.y += (parent.direction == column) * realistic.height + efficient.margin.top + efficient.margin.bottom;
		
		matrix_set(matrix_world, mat);