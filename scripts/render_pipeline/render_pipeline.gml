function render_pipeline(){
	pipeline = [];
	
	pipeline_push(function(){
		target.x = realistic.x + efficient.x + offset.x;	
		target.y = realistic.y + efficient.y + offset.y;
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
	
	if (overflow != fa_allow) pipeline_push(function(index){
		camera_set_view_pos(camera, -contentOffset.x, -contentOffset.y);
		
		cache[JUI_CACHE.OVERFLOW].target();
		draw_clear_alpha(c_black, 0);
		camera_apply(camera);
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
	
	if (root == self) pipeline_push(function(){
		matrix_set(matrix_world, matrix_build_identity());
	});
	
	if (overflow != fa_allow) pipeline_push(function(){
		var overflow = cache[JUI_CACHE.OVERFLOW];
		overflow.reset();
		
		overflow.draw(target.x + efficient.padding.left, target.y + efficient.padding.top);
	});
	
	if (overflow == fa_scroll) pipeline_push(function(){
		scroll.draw();	
	});


}

function pipeline_push(script){
	array_push(pipeline, script);
}