function button(text, width, height, background) constructor{
	self.text = text;
	self.width = width;
	self.height = height;
	
	
	thickness = 2;
	
	defaultCol = background;
	self.background = defaultCol;
	color = c_white
	
	darken = (rgb_to_hsv(background)[2]) > 0.5 ? c_black : c_white;
	smoothing = 0.45;
	
	outline = merge_color(background, darken, 0.55);
	
	halign = fa_center;
	valign = fa_center;
	
	fontSize = height * 0.8;
	textFit = true;
	
	cursor = cr_handpoint;
	allowSelect = true;
	
	valign = fa_center;
	halign = fa_center;
	
	onHover = function(){
		
	}
	
	onClick = function(){
		
	}
	
	onStep = function(){
		
	}
	
	step = function(){
		var col = defaultCol;
		
		if (hover){
			onHover();
		
			if (mouse_check_button_pressed(mb_left)){
				onClick();	
			}
		}else onStep();
	}
}