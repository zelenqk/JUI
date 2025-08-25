function generate_layout(){
	var wrap = (overflow == fa_wrap or overflow == fa_hidden_wrap);
	var layout = new layout_container(direction, target.width, target.height, wrap, self);
	
	calculate_content(content, 0, relative);
	
	if (direction == reverseColumn or direction == reverseRow) recurse_array_reverse(content, layout.calculate, 0)
	else recurse_array(content, layout.calculate, 0);
	
	//mitigate off by 1 error
	switch (direction) {
	case row:
	case reverseRow:
		layout.width = max(layout.width, layout.line.width);
		layout.height += layout.line.height;
		break;

	case column:
	case reverseColumn:
		layout.height = max(layout.height, layout.line.height);
		layout.width += layout.line.width;
		break;
	}
	
	if (target.gap == auto) layout.update()
	if (aspect != auto) target[$ secondary] = target[$ primary] / aspect;
	
	//calculate sprite scale
	if (sprite != -1){
		var ewidth = (target.width + target.padding.left + target.padding.right);
		var eheight = (target.height + target.padding.top + target.padding.bottom);
		target.spriteXscale = calculate_value(spriteXscale, ewidth);
		target.spriteYscale = calculate_value(spriteYscale, eheight);
		
		if (target.spriteXscale <= 0) target.spriteXscale = ewidth / sprite_get_width(sprite);
		if (target.spriteYscale <= 0) target.spriteYscale = eheight / sprite_get_height(sprite);
		
		if (target.spriteXscale <= 0) target.spriteXscale = 1;
		if (target.spriteYscale <= 0) target.spriteYscale = target.spriteXscale;
	}
	
	if (display == flex){
		target.width = layout.width - target.gap.left;
		target.height = layout.height - target.gap.top;

		if (sprite != -1){
			target.width = max(target.width, (sprite_get_width(sprite) * target.spriteXscale) - target.padding.left - target.padding.right);
			target.height = max(target.height, (sprite_get_height(sprite) * target.spriteYscale) - target.padding.bottom - target.padding.top);
		}
		
		if (text != ""){
			target.width = max(target.width, text.width);
			target.height = max(target.height, text.height);
		}
		
		if (aspect != auto) target[$ secondary] = target[$ primary] / aspect;
	}
	
	if (sprite != -1){
		var ewidth = (target.width + target.padding.left + target.padding.right);
		var eheight = (target.height + target.padding.top + target.padding.bottom);
	
		if (spriteXscale.value == auto and display != flex) target.spriteXscale = ewidth / sprite_get_width(sprite);
		if (spriteYscale.value == auto and display != flex) target.spriteYscale = eheight / sprite_get_height(sprite);
	}
	
	calculate_content(content, 0, fixed);
}

function layout_container(dir, mwidth, mheight, wrap, parent) constructor{
	direction = dir;
	width = 0;
	height = 0;
	
	self.parent = parent;
	
	x = 0;
	y = 0;
	
	self.wrap = wrap;
	self.mwidth = mwidth;
	self.mheight = mheight;
	
	lines = [new line_container(direction, x, y, mwidth, mheight, wrap, parent)];
	line = lines[0];

	calculate = function(element){
		if (element.position == fixed) return;
		
		var added = line.add(element, wrap);
		
		if (!added and wrap){
			switch (direction){
			case row:
			case reverseRow:
				width = max(width, line.width);
				height += line.height;
				
				x = 0;
				y += line.height;
				break;
			case column:
			case reverseColumn:
				height = max(height, line.height);
				width += line.width;
				
				x += line.width;
				y = 0;
				break;
			}
			
			line = new line_container(direction, x, y, mwidth, mheight, wrap, parent)
			array_push(lines, line);
			
			line.add(element, true);
		}
	}
	
	update = function(){
			
	}
}

function line_container(dir, tx, ty, mwidth, mheight, wrap, parent) constructor{
	x = tx;
	y = ty;
	width = 0;
	height = 0;
	
	self.parent = parent;
	
	maximum = {
		width: mwidth,
		height: mheight,
	}
	
	self.wrap = wrap;
	
	direction = dir;
	
	add = function(element){
		var twidth = element.efficient.width + parent.target.gap.left;
		var theight = element.efficient.height + parent.target.gap.top;
		
		switch (direction){
		case row:
		case reverseRow:
			if (wrap and (width + twidth > maximum.width)) return false;
			element.x = width;
			element.y = y;
			
			width += twidth;
			height = max(height, theight);
			break;
		case column:
		case reverseColumn:
			if (wrap and (height + theight > maximum.height)) return false;
			element.x = x;
			element.y = height

			height += theight;
			width = max(width, twidth);
			break;
		}
		
		return true;
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