function generate_layout(){
	//positioning
	var e = {	//original efficient width/height
		"width": 0,
		"height": 0,
		"x": 0,
		"y": 0,
	}
	
	if (direction == reverseColumn or direction == reverseRow) calculate_content(content, e);
	else calculate_content_reverse(content, e);
	
	//flexing B)
	if (display == flex){
		efficient.width = e.width;
		efficient.height = e.height;
	}
}


function calculate_content(content, efficient, index = 0){
	var contentLength = array_length(content)
	
	for(var i = 0; i < contentLength; i++){
		var element = content[i];
		
		if (is_array(element)) calculate_content(element, efficient, index + i);
		else{
			element.calculate();
			calculate_position(element, efficient, index + i);
		}
	}
}

function calculate_content_reverse(content, efficient, index = 0){
	var contentLength = array_length(content)
	
	for(var i = contentLength - 1; i >= 0 ; i--){
		var element = content[i];
		
		if (is_array(element)) calculate_content(element, efficient, index + ( contentLength - 1 - i));
		else{
			element.calculate();
			calculate_position(element, efficient, index + ( contentLength - 1 - i));
		}
	}
}


function calculate_position(element, efficient, index = 0){
	var xoffset = element.target.margin.left;
	var yoffset = element.target.margin.top;
	element.x = efficient.x + xoffset;
	element.y = efficient.y + yoffset;
	
	if (instance != -1) element.instance.x = element.x;
	if (instance != -1) element.instance.y = element.y;
	
	var twidth = element.efficient.width + element.target.margin.left + element.target.margin.right;
	var theight = element.efficient.height + element.target.margin.top + element.target.margin.bottom;
	
	switch (direction){
	case column:
		efficient.width = max(efficient.width, twidth);
		
		var wrap = (overflow == fa_wrap or overflow == fa_hidden_wrap);
		if (wrap){
			if (efficient.y + theight > self.target.height){
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
				efficient.x = 0;
				efficient.y += efficient.height + target.gap.top;
				efficient.height = 0;
				
				element.x = efficient.x + xoffset;
				element.y = efficient.y + yoffset;
				
				if (instance != -1) element.instance.x = element.x;
				if (instance != -1) element.instance.y = element.y;
			}
		}
		
		efficient.x += twidth + target.gap.right;
		
		if (wrap and efficient.x >= self.target.width){
			efficient.x = 0;
			efficient.y += efficient.height + target.gap.top;
			efficient.height = 0;
		}
		break;
	}
}
