function render_pipeline(){
	if (step != auto) pipeline_push(method(self, step));
	
	if (backgroundIsMySurface) pipeline_push(function(){
		background.check();
		
		texture = background.texture;
	});
	
	if (opacity > 0) pipeline_push(function(){
		matrix[0] = scale.x;
		matrix[6] = scale.y;
		
		matrix[12] = efficient.x + offset.x;
		matrix[13] = efficient.y + offset.y;
		
		matrix_set(matrix_world, matrix);
		vertex_submit(vbuff, pr_trianglelist, texture);
	});
	
	pipeline_push(function(){
		array_foreach(segments, function(segment){
			segment.draw();
		});
	});
	
	if (root == self) pipeline_push(function(){
		matrix_set(matrix_world, matrix_build_identity());
	});
}

function pipeline_push(script){
	array_push(pipeline, script);
}