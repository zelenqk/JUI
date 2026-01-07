function calculate_layout(){
	segments = [new JUI_SEGMENT(efficient.padding.left, efficient.padding.top, direction, realistic.width, realistic.height, wrap)];
	
	array_recurse(content.children, function(element, segments){
		var segment = array_last(segments);
		if (segment.add(element)) return false;
		
		segment = new JUI_SEGMENT(segment.left, segment.top, segment.direction, segment.width, segment.height, segment.wrap, segment.x, segment.y);
		array_push(segments, segment);
		segment.add(element);
		
		return false;
	}, segments);
}

function JUI_SEGMENT(left, top, direction, width, height, wrap, tx = 0, ty = 0) constructor{
	self.left = left;
	self.top = top;
	
	direction = direction;
	
	self.width = width;
	self.height = height;
	
	self.wrap = wrap;
	
	x = 0;
	y = 0;
	
	efficient = {
		width: 0,
		height: 0,
	}
	
	content = [];
	
	add = function(element){
		if (element.position == fixed or element.position == absolute){
			array_push(content, element);	//do not progress x and y if element is fixed/absolute
			return;
		}
		
		if (wrap){
			var check = (false);
			
			if (check){
				y += efficient.height;
				return false;
			}
			
			
			array_push(content, element);
			element.render();
			return true;
		}
		
		array_push(content, element);
		element.render();
		return true;
	}
	
	draw = function(){
		for(var i = 0; i < array_length(content); i++){
			var element = content[i];
			element.draw();
		}
	}
}