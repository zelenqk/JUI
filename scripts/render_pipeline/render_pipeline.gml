function render_pipeline(){
	if (step != auto) pipeline_push(method(self, step));
	
	if (backgroundIsMySurface) pipeline_push(function(){
		background.check();
		
		texture = background.texture;
	});
	
	if (opacity > 0) pipeline_push(function(){
		var cx = (parent == self) ? 0 : parent.contentOffset.x
		var cy = (parent == self) ? 0 : parent.contentOffset.y
		
		matrix[12] = realistic.x + efficient.x + offset.x + cx;
		matrix[13] = realistic.y + efficient.y + offset.y + cy;
		
		matrix[0] = scale.x;
		matrix[6] = scale.y;
			
		matrix_set(matrix_world, matrix);
		vertex_submit(vbuff, pr_trianglelist, texture);
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
	
	if (overflow == fa_scroll) pipeline_push(function(){
		scroll.draw();	
	});

	if (root == self) pipeline_push(function(){
		matrix_set(matrix_world, matrix_build_identity());
	});
}

function pipeline_push(script){
	array_push(pipeline, script);
}