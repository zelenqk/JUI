function calculate_layout(){
	segments = [new JUI_SEGMENT(efficient.padding.left, efficient.padding.top, direction, realistic.width, realistic.height, efficient.gap, wrap, overflow.x, realistic.x * (overflow.x == fa_allow), realistic.y * (overflow.y == fa_allow), target.x, target.y)];
	
	array_recurse(content.children, function(element, segments){
		if !is_callable(element[$ "draw"]) element = new container(element, self);
		
		var segment = array_last(segments);
		if (segment.add(element)) return false;
		
		segment = new JUI_SEGMENT(segment.left, segment.top, segment.direction, segment.width, segment.height, segment.gap, segment.wrap, segment.overflow, segment.efficient.x, segment.efficient.y, segment.realistic.x, segment.realistic.y);
		array_push(segments, segment);
		segment.add(element);
		
		return false;
	}, segments);
	
}

function JUI_SEGMENT(left, top, direction, width, height, gap, wrap, overflow, tx, ty, rx, ry) constructor{
	self.left = left;
	self.top = top;

	self.overflow = overflow;
	self.direction = direction;
	
	self.width = width;
	self.height = height;
	
	self.gap = gap;
	
	self.wrap = wrap;
	
	x = tx;
	y = ty;
	
	realistic = {
		x: rx,
		y: ry,
	}
	
	efficient = {
		width: 0,
		height: 0,
		
		gap: (gap == auto ? 0 : gap),
		
		x: tx + ((overflow == fa_allow) ? left : 0),
		y: ty + ((overflow == fa_allow) ? top : 0)
	}
	
	maximum = (direction == row) ? width : height;
	
	content = [];
	amount = 0;
	
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
		
		element.target.x = efficient.x + realistic.x + left;
		element.target.y = efficient.y + realistic.y + top;
		
		if (wrap){
			var check = (direction == row) ? efficient.width + ewidth : efficient.height + eheight;
			
			if (check > maximum){
				if (direction == row) {
					efficient.x = x;
					efficient.y += efficient.height;
					return false;
				}
				
				efficient.x += efficient.width;
				efficient.y = y;
				return false;
			}
		}
		
		if (direction == row){
			efficient.x += ewidth;
			efficient.width += ewidth;
			efficient.height = max(efficient.height, eheight);
		}
		
		if (direction == column){
			efficient.y += eheight;
			efficient.height += eheight;
			efficient.width = max(efficient.width, ewidth);
		}
			
		array_push(content, element);
		amount++;
		return true;
	}
	
	draw = function(){
		for(var i = 0; i < array_length(content); i++){
			var element = content[i];
			element.draw();
		}
	}
	
	cleanup = function(cleanChildren){
		for(var i = 0; i < array_length(content); i++){
			var element = content[i];
			element.cleanup(cleanChildren);
		}
	}
}