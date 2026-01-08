function render_pipeline(){
	pipeline.length = 0;
	pipeline.content = [];
	
	if (step != auto) pipeline_push(method(self, step));
	
	pipeline_push(function(){
		matrix[12] = x + offset.x;
		matrix[13] = y + offset.y;
		
		matrix_set(matrix_world, matrix);
		vertex_submit(vbuff, pr_trianglelist, texture);
	});
	
	if (array_length(segments) > 0) pipeline_push(draw_content);	//draw children (debug stage atm)

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