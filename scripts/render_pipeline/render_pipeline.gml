function render_pipeline(){
	pipeline_push(function(){
		var cx = (parent == self) ? 0 : parent.contentOffset.x;
		var cy = (parent == self) ? 0 : parent.contentOffset.y;
		
		target.x = realistic.x + efficient.x + offset.x + cx;	
		target.y = realistic.y + efficient.y + offset.y + cy;
	})
	
	if (step != auto) pipeline_push(method(self, step));
	
	if (backgroundIsMySurface) pipeline_push(function(){
		background.check();
		
		texture = background.texture;
	});
	
	//cookie
	pipeline_push(function(){
		matrix[12] = target.x;
		matrix[13] = target.y;
		
		matrix[0] = scale.x;
		matrix[6] = scale.y;
			
		matrix_set(matrix_world, matrix);
		
	});
	
	//cookie cutter
	if (borderRadiusEnabled){
		pipeline_push(function(){
			var br = cache[JUI_CACHE.BORDER_RADIUS];
			br.draw(0, 0);
		});
	}else{
		pipeline_push(function(){
			vertex_submit(vbuff, pr_trianglelist, texture);	
		});
	}
	
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