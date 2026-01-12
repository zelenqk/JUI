function render_pipeline(){
	if (backgroundIsMySurface) pipeline_push(function(){
		background.check();
		
		texture = background.texture;
	});
	
	if (opacity > 0) pipeline_push(function(){
		matrix[12] = efficient.x;
		matrix[13] = efficient.y;
		
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