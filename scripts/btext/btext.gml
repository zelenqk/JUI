//bozhi surfaces and now bozhi text? whats next bozhi sprites?

function btext(text, w = infinity) constructor{
	self.text = text;
	splitted = string_split(text, "\n", true);
	
	maximum = w;
	
	width = 0;
	height = 0;
	
	font = fntMain;
	fontSize = 24;
	fontScale = (FONT_SIZES[font] / fontSize);
	
	surface = new bsurface();
	
	style = {
		"lineSeparation": 1,
	}
	
	calculate = function(){
		var sep = fontSize * style.lineSeparation;
		var w = maximum * fontScale;
		
		width = string_width_ext(text, sep, w);
		height = string_height_ext(text, sep, w);
		
		if (width > maximum){
			for(var i = 0; i < array_length(splitted); i++){
				var t = splitted[i];
			}
			
			height = sep * array_length(splitted);
		}
		
		render();
	}
	
	render = function(){
		surface.target();
		draw_clear_alpha(c_black, 0);
		
		surface.reset();
	}
	
	draw = function(tx = 0, ty = 0){
		
	}
}