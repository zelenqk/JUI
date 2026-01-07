function calculate_layout(){
	segments = [new JUI_SEGMENT(direction, realistic.width, realistic.height, wrap, overflow)];
	
	array_recurse(content.children, function(element, segments){
		var segment = array_last(segments);
		if (segment.add(element)) return false;
		
		segment = new JUI_SEGMENT(segment.width, segment.height, segment.wrap);
		array_push(segments, segment);
		segment.add(element);
		
		return false;
	}, segments);
}

function JUI_SEGMENT(width, height, wrap, overflow) constructor{
	self.width = width;
	self.height = height;
	
	self.wrap = wrap;
	
	self.overflow = overflow;
	
	content = [];
	
	add = function(element){
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