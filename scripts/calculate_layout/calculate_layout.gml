//cleaned and commented by gpt

function calculate_layout(){
	// start with a single root segment
	segments = [new JUI_SEGMENT(self)];
	
	// push each element into the active segment
	for (var i = 0; i < array_length(content); i++){
		var element = content[i];
		var segment = array_last(segments);
		
		segment.add(element);
	}
}

function JUI_SEGMENT(owner) constructor{
	parent = owner;
	
	// resolved layout metrics for this segment
	efficient = {
		x: 0,
		y: 0,
		width: 0,
		height: 0,
	};
	
	// elements belonging to this segment
	content = [];
	
	add_inline = function(element){
		// non-relative elements bypass layout
		if (element.position != relative){
			array_push(content, element);
			return self;
		}
		
		// inline size including margins
		var w = element.efficient.width + element.efficient.margin.left;
		var h = element.efficient.height + element.efficient.margin.block;
		
		// wrapping behavior
		if (parent.wrap){
			// fits in current segment
			if (efficient.width + w < parent.realistic.width){
				element.efficient.x = efficient.width + element.efficient.margin.left;
				element.efficient.y = efficient.y + element.efficient.margin.top;
				
				efficient.width += w + element.efficient.margin.right;
				efficient.height = max(efficient.height, h);
				
				array_push(content, element);
				return self;
			}
			
			// overflow creates a new segment
			var segment = new JUI_SEGMENT(parent);
			segment.efficient.y = efficient.y + efficient.height;
			segment.add(element);
			
			array_push(parent.segments, segment);
			return segment;
		}
		
		// no wrapping
		element.efficient.x = efficient.width + element.efficient.margin.left;
		element.efficient.y = element.efficient.margin.top;
		
		efficient.width += w + element.efficient.margin.right;
		efficient.height = max(efficient.height, h + element.efficient.margin.top);
		
		array_push(content, element);
		return self;
	};
	
	add_block = function(element){
		// non-relative elements bypass layout
		if (element.position != relative){
			array_push(content, element);
			return self;
		}
		
		// block size including margins
		var w = element.efficient.width + element.efficient.margin.inline;
		var h = element.efficient.height + element.efficient.margin.top;
		
		// wrapping behavior
		if (parent.wrap){
			// fits in current segment
			if (efficient.height + h < parent.realistic.height){
				element.efficient.x = efficient.x + element.efficient.margin.left;
				element.efficient.y = efficient.height + element.efficient.margin.top;
				
				efficient.width = max(efficient.width, w);
				efficient.height += h + element.efficient.margin.bottom;
				
				array_push(content, element);
				return self;
			}
			
			// overflow creates a new segment
			var segment = new JUI_SEGMENT(parent);
			segment.efficient.x = efficient.x + efficient.width + element.efficient.margin.left;
			segment.add(element);
			
			array_push(parent.segments, segment);
			return segment;
		}
		
		// no wrapping
		element.efficient.x = element.efficient.margin.left;
		element.efficient.y = efficient.height + element.efficient.margin.top;
		
		efficient.width = max(efficient.width, w + element.efficient.margin.left);
		efficient.height += h + element.efficient.margin.bottom;
		
		array_push(content, element);
		return self;
	};
	
	// select layout mode based on parent direction
	add = (parent.direction == column) ? add_block : add_inline;
	
	// draw all elements in this segment
	draw = function(){
		array_foreach(content, function(element){
			element.draw();
		});
	};
}

/* --- Original ---



function calculate_layout(){
	segments = [new JUI_SEGMENT(self)];
	
	for(var i = 0; i < array_length(content); i++){
		var element = content[i];
		var segment = array_last(segments);
		
		segment.add(element);
	}
}

function JUI_SEGMENT(owner) constructor{
	parent = owner;
	
	efficient = {
		x: 0,
		y: 0,
		width: 0,
		height: 0,
	}
	
	content = [];
	
	add_inline = function(element){
		if (element.position != relative){
			array_push(content, element);
			return;
		}
		
		var w = element.efficient.width + element.efficient.margin.left;
		var h = element.efficient.height + element.efficient.margin.block;
		
		if (parent.wrap){
			if (efficient.width + w < parent.realistic.width){
				element.efficient.x = efficient.width + element.efficient.margin.left;
				element.efficient.y = efficient.y + element.efficient.margin.top;
				
				efficient.width += w + element.efficient.margin.right;
				efficient.height = max(efficient.height, h);
				
				array_push(content, element);
				return self;
			}
			
			var segment = new JUI_SEGMENT(parent);
			segment.efficient.y = efficient.y + efficient.height;
			segment.add(element);
			
			array_push(parent.segments, segment);
			
			return segment;
		}
		
		element.efficient.x = efficient.width + element.efficient.margin.left;
		element.efficient.y = element.efficient.margin.top;
		
		efficient.width += w + element.efficient.margin.right;
		efficient.height = max(efficient.height, h + element.efficient.margin.top);

		array_push(content, element);
	}
	
	add_block = function(element){
		if (element.position != relative){
			array_push(content, element);
			return;
		}
		
		var w = element.efficient.width + element.efficient.margin.inline;
		var h = element.efficient.height + element.efficient.margin.top;
		
		if (parent.wrap){
			if (efficient.height + h < parent.realistic.height){
				element.efficient.x = efficient.x + element.efficient.margin.left;
				element.efficient.y = efficient.height + element.efficient.margin.top;
				
				efficient.width = max(efficient.width, w);
				efficient.height += h + element.efficient.margin.bottom;
				
				array_push(content, element);
				return self;
			}
			
			var segment = new JUI_SEGMENT(parent);
			segment.efficient.x = efficient.x + efficient.width + element.efficient.margin.left;
			segment.add(element);
			
			array_push(parent.segments, segment);
			
			return segment;
		}
		
		element.efficient.x = element.efficient.margin.left;
		element.efficient.y = efficient.height + element.efficient.margin.top;
		
		efficient.width = max(efficient.width, w + element.efficient.margin.left);
		efficient.height += h + element.efficient.margin.bottom;
		array_push(content, element);
		
		return true;
	}
	
	add = (parent.direction == column) ? add_block : add_inline;
	
	draw = function(){
		array_foreach(content, function(element){
			element.draw();
		});
	}
}