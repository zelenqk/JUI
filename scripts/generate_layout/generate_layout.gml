function generate_layout(){
	
	//positioning
	var eff = {
		"width": 0,
		"height": 0,
		"x": 0,
		"y": 0,
		"lines": [],
		"line": 0,
		"lWidth": (direction == column or direction == reverseColumn) ? infinity : target.width,
		"lHeight": !(direction == column or direction == reverseColumn) ? infinity : target.width,
	
		"twidth": 0,	//total width
		"theight": 0,	//total height
	}
	
	//create the first line
	eff.lines[eff.line] = new line_properties(eff.lWidth, eff.lHeight);
	
	if (direction == reverseColumn or direction == reverseRow) recurse_array_reverse(content, calculate_lines, efficient);
	else recurse_array(content, calculate_lines, eff);
	
	//flexing B)
	if (display == flex){
		self.efficient.width = eff.twidth + target.padding.left + target.padding.right;
		self.efficient.height = eff.theight + target.padding.top + target.padding.bottom;
		
		// efficient min/max
		self.efficient.width = max(self.efficient.width, target.minimum.width);
		self.efficient.height = max(self.efficient.height, target.minimum.height);
		
		self.efficient.width = min(self.efficient.width, target.maximum.width);
		self.efficient.height = min(self.efficient.height, target.maximum.height);
		
		cache.background.resize(self.efficient.width, self.efficient.height);
		cache.overflow.resize(self.efficient.width, self.efficient.height);
		
		render();
	}
	
	calculate_position(eff);
}

function line_properties(w = 0, h = 0) constructor{
	x = 0;
	y = 0;
	
	width = 0;
	height = 0;
	
	target = {
		width: w,
		height: h,
	}
	
	free = {
		width: 0,
		height: 0,
	}
	
	elements = [];
	
	add = function(element, force = false){
		var twidth = element.efficient.width + element.target.margin.left + element.target.margin.right;
		var theight = element.efficient.height + element.target.margin.top + element.target.margin.bottom;
		
		if (!force and (width + twidth > target.width or height + theight > target.height)) return false
		
		array_push(elements, element);
		
		if (target.width != infinity){
			width += twidth;
			free.width = target.width - width;
			
			height = max(height, element.efficient.height);
		}else{
			height += theight;
			free.height = target.height - height;
			
			width = max(width, element.efficient.width);
		}
		
		return true;
		
	}
}

function calculate_lines(element, efficient){
	var line = efficient.lines[efficient.line];
	var added = line.add(element, !(overflow == fa_wrap or overflow == fa_hidden_wrap));
	
	if (!added){
		efficient.line++
		efficient.lines[efficient.line] = new line_properties(efficient.lWidth, efficient.lHeight);
		
		line = efficient.lines[efficient.line];
		line.add(element, true);
	}
	
	switch (direction){
	case column:
	case reverseColumn:
		efficient.theight = max(efficient.theight, line.height);
		efficient.twidth += line.width;
		break;
	case row:
	case reverseRow:
		efficient.twidth = max(efficient.twidth, line.width);
		efficient.theight += line.height;
		break;
	}
}

function calculate_position(efficient){
	var twidth = 0;
	var theight = 0;
	var linesN = array_length(efficient.lines);
	var wrap = (overflow == fa_wrap or overflow == fa_hidden_wrap);
	
	for(var i = 0; i < linesN; i++){
		var line = efficient.lines[i];
		var elms = array_length(line.elements);
		
		var col = (direction == column or direction == reverseColumn);
		
		var isAuto = wrap and ((gap.left.value == auto or gap.top.value == auto) or ((gap.top.value == auto_first or gap.left.value == auto_first) and i == 0));
		
		if (isAuto){
			if (!col) target.gap.left = (line.free.width / (elms - 1));
			if (col) target.gap.top = (line.free.height / (elms));
		}

		if (isAuto){
			if (col) target.gap.left = target.gap.top ;
			if (!col) target.gap.top = target.gap.left;
		}
		
		for(var u = 0; u < elms; u++){
			var element = line.elements[u];
			
			switch (direction){
			case column:
			case reverseColumn:
				element.x = twidth;
				element.y = theight + element.target.margin.top;
				
				theight += element.efficient.height + target.gap.top;
				break;
			case row:
			case reverseRow:
				element.x = twidth + element.target.margin.left;
				element.y = theight;
				
				twidth += element.efficient.width + target.gap.left;
				break;
			}
		}
		
		if (direction == column or direction == reverseColumn){
			twidth += line.width + target.gap.left;
			theight = 0;
		}else{
			theight += line.height + target.gap.top;
			twidth = 0;
		}
	}
}


/* junk to look at when something doesnt work


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