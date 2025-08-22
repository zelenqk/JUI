//bozhi surfaces and now bozhi text? whats next bozhi sprites?

function btext(text, w = infinity) constructor{
	self.text = text;
	splitted = string_split(text, "\n", true);
	
	maximum = w;
	
	width = 0;
	height = 0;
	
	font = fntMain;
	fontSize = 15.5;
	fontScale = (fontSize / FONT_SIZES[font]);
	
	surface = new bsurface();
	
	style = {
		"lineSeparation": 1.3,
	}
	
	calculate = function(){
		var sep = FONT_SIZES[font] * style.lineSeparation;
		var w = maximum / fontScale;
		
		draw_set_font(font);
		width = string_width_ext(text, sep, w) * fontScale;
		height = string_height_ext(text, sep, w) * fontScale;	
		
		if (width > maximum){
			for(var i = 0; i < array_length(splitted); i++){
				var t = splitted[i];
				width = max(width, string_width(t) * fontScale);
			}
			
			height = sep * array_length(splitted);
		}
		
		surface.resize(width, height);
		
		render();
	}
	
	render = function(){
		surface.target();
		draw_clear_alpha(c_black, 0);
		gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
		
		var sep = fontSize * style.lineSeparation;
		
		draw_set_font(font);
		for(var i = 0; i < array_length(splitted); i++){
			draw_text_transformed(0, sep * i, splitted[i], fontScale, fontScale, 0);	
		}
		
		gpu_set_blendmode(bm_normal);
		surface.reset();
	}
	
	draw = function(tx = 0, ty = 0){
		surface.draw(tx, ty);
	}
}