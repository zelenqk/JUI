function line_properties() constructor{
	width = 0;
	height = 0;
	
	elements = 0;
	
	gap = {
		left: 0,
		top: 0,
	}	
}

function generate_layout(){
	//positioning
	var e = {	//original efficient width/height
		"width": 0,
		"height": 0,
		"x": 0,
		"y": 0,
		"lines": [new line_properties()],
		"line": 0,
	}
	
	if (target.gap.left == auto or target.gap.top == auto){
		if (direction == reverseColumn or direction == reverseRow) recurse_array_reverse(content, calculate_lines, e);
		else recurse_array(content, calculate_lines, e);
	}
	
	if (direction == reverseColumn or direction == reverseRow) calculate_content_position_reverse(content, e);
	else calculate_content_position(content, e);
	
	//flexing B)
	if (display == flex){
		efficient.width = e.width;
		efficient.height = e.height;
	}
}



function calculate_position(element, efficient, index = 0, wrapOnly){
	var xoffset = element.target.margin.left;
	var yoffset = element.target.margin.top;
	
	element.x = efficient.x + xoffset;
	element.y = efficient.y + yoffset;

	var line = efficient.lines[efficient.line % array_length(efficient.lines)];
	var wrap = (overflow == fa_wrap or overflow == fa_hidden_wrap);

	var twidth = element.efficient.width + element.target.margin.left + element.target.margin.right;
	var theight = element.efficient.height + element.target.margin.top + element.target.margin.bottom;
	
	if (wrapOnly) line.elements++;
	
	switch (direction){
	case column:
		if (wrap){
			if (target.gap.top == auto) target.gap.top = line.gap.top; 
			
			if (element.y + element.efficient.height > target.height){
				efficient.x += line.width + target.gap.left;
				efficient.y = 0;
				
				if (wrapOnly) line.elements--;
				
				efficient.line++;
				
				if (wrapOnly) array_push(efficient.lines, new line_properties());
				line = efficient.lines[efficient.line % array_length(efficient.lines)];
				
				element.x = efficient.x + xoffset;
				element.y = efficient.y + yoffset;
			}
		}
		
		efficient.y += theight + target.gap.top;
		
		line.width = max(line.width, twidth);
		line.height = efficient.y;
		
		if (wrap and efficient.y >= self.target.height){
			line.height -= theight + target.gap.top;
			efficient.line++;
			
			if (wrapOnly) efficient.lines[efficient.line] = new line_properties();
			
			efficient.y = 0;
			efficient.x += line.width + target.gap.left;
		}
		break;
	}
	
	
	
}

/*
function calculate_position(element, efficient, index = 0, full = true){
	var xoffset = element.target.margin.left;
	var yoffset = element.target.margin.top;
	element.x = efficient.x + xoffset;
	element.y = efficient.y + yoffset;
	
	efficient.peraxis[efficient.currentAxis]++;
	
	if (instance != -1) element.instance.x = element.x;
	if (instance != -1) element.instance.y = element.y;
	
	if (full and gap == auto){
		target.gap.left = 
	}
	
	var twidth = element.efficient.width + element.target.margin.left + element.target.margin.right;
	var theight = element.efficient.height + element.target.margin.top + element.target.margin.bottom;
	
	switch (direction){
	case column:
		efficient.width = max(efficient.width, twidth);
		
		var wrap = (overflow == fa_wrap or overflow == fa_hidden_wrap);
		if (wrap){
			if (efficient.y + theight > self.target.height){
				efficient.peraxis[efficient.axis++]--;
				
				efficient.y = 0;
				efficient.x += efficient.width + target.gap.right;
				
				element.x = efficient.x + xoffset;
				element.y = efficient.y + yoffset;
				
				if (instance != -1) element.instance.x = element.x;
				if (instance != -1) element.instance.y = element.y;
			}
		}
		
		efficient.y += theight + target.gap.bottom;
		
		if (wrap and efficient.y >= self.target.height){
			efficient.axis++
			efficient.y = 0;
			efficient.x += efficient.width;
			efficient.width = 0;
		}
		break;
	case row:
		efficient.height = max(efficient.height, theight);
		
		var wrap = (overflow == fa_wrap or overflow == fa_hidden_wrap);
		if (wrap){
			if (efficient.x + twidth > self.target.width){
				efficient.peraxis[efficient.axis++]--;
				efficient.x = 0;
				efficient.y += efficient.height + target.gap.top;
				
				element.x = efficient.x + xoffset;
				element.y = efficient.y + yoffset;
				
				if (instance != -1) element.instance.x = element.x;
				if (instance != -1) element.instance.y = element.y;
			}
		}
		
		efficient.x += twidth + target.gap.right;
		
		if (wrap and efficient.x >= self.target.width){
			efficient.axis++
			efficient.x = 0;
			efficient.y += efficient.height + target.gap.top;
			efficient.height = 0;
		}
		break;
	}
	
	efficient.twidth[efficient.axis] = max(efficient.twidth[efficient.axis], element.x + element.efficient.width);
	efficient.theight[efficient.axis] = max(efficient.theight[efficient.axis], element.y + element.efficient.height);
}