function calculate_layout(){
	segments = [new JUI_SEGMENT(efficient.padding.left, efficient.padding.top, direction, realistic.width, realistic.height, efficient.gap, wrap)];
	
	array_recurse(content.children, function(element, segments){
		var segment = array_last(segments);
		if (segment.add(element)) return false;
		
		segment = new JUI_SEGMENT(segment.left, segment.top, segment.direction, segment.width, segment.height, segment.gap, segment.wrap, segment.x, segment.y);
		array_push(segments, segment);
		segment.add(element);
		
		return false;
	}, segments);
	
	if (gap == auto){
		for(var i = 0; i < array_length(segments); i++){
			var segment = segments[i];
			segment.efficient.gap = abs((segment.width - segment.efficient.width) / (array_length(segment.content) - 1));
			
			segment.calculate();
		}
	}
}

function JUI_SEGMENT(left, top, direction, width, height, gap, wrap, tx = 0, ty = 0) constructor{
	self.left = left;
	self.top = top;
	
	self.direction = direction;
	
	self.width = width;
	self.height = height;
	
	self.gap = gap;
	
	self.wrap = wrap;
	
	x = tx;
	y = ty;
	
	efficient = {
		width: 0,
		height: 0,
		
		gap: (gap == auto ? 0 : gap),
		
		x: tx,
		y: ty
	}
	
	maximum = (direction == row) ? width : height;
	
	content = [];
	
	calculate = function(){
		efficient.x = 0;
		efficient.y = 0;
		
		for(var i = 0; i < array_length(content); i++){
			var element = content[i];
			if (direction == row) element.x = efficient.x
		}
	}
	
	add = function(element){
		element.segment = self;

		if (element.position == fixed or element.position == absolute){
			array_push(content, element);	//do not progress x and y if element is fixed/absolute
			return;
		}
		
		var ewidth = element.efficient.width + element.efficient.margin.inline;
		var eheight = element.efficient.height + element.efficient.margin.block;
		
		element.x = efficient.x + element.efficient.margin.left;
		element.y = efficient.y + element.efficient.margin.top;
		
		if (wrap){
			var check = (direction == row) ? element.x + ewidth : element.y + eheight;
			
			if (check > maximum){
				if (direction == row) {
					efficient.x = 0;
					efficient.y += efficient.height;
					return false;
				}
				
				efficient.x += efficient.width;
				efficient.y = 0;
				
				return false;
			}
			
			if (direction == row) efficient.x += ewidth;
			if (direction == column) efficient.y += eheight;
			
			efficient.width = max(efficient.width, ewidth);
			efficient.height = max(efficient.height, eheight);
			
			
			array_push(content, element);
			return true;
		}
		
		if (direction == row) element.x += efficient.width;
		if (direction == column) element.y += efficient.height;
		
		array_push(content, element);
		return true;
	}
	
	draw = function(){
		for(var i = 0; i < array_length(content); i++){
			var element = content[i];
			element.draw();
		}
	}
}