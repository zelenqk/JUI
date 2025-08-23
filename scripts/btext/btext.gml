//bozhi surfaces and now bozhi text? whats next bozhi sprites?

function btext(text, w = 0, normalize = true, style) constructor{
	if (w == 0) w = infinity;
	
	if (normalize){//normalizations
		text = string_replace_all(text, "\r\n", "\n")	//newlines/linebreaks
		text = string_replace_all(text, "\t", "    ")	//tabs
	}
	
	self.text = text;
	splitted = string_split(text, "\n", true);
	
	maximum = w;
	
	width = 0;
	height = 0;
	
	font = get_default_style(style, "font", fntMain);
	color = get_default_style(style, "color", c_white);
	alpha = get_default_style(style, "alpha", 1);
	
	separation = get_default_style(style, "separation", 1.35);
	fontSize = get_default_style(style, "fontSize", 20);
	
	fontScale = (fontSize / FONT_SIZES[font]);
	
	surface = new bsurface();

	calculate = function(){
		var sep = FONT_SIZES[font] * separation;
		var w = maximum / fontScale;
		
		var fnt = draw_get_font();
		var col = draw_get_color();
		var a = draw_get_alpha();
		
		draw_set_font(font);
		draw_set_color(color);
		draw_set_alpha(alpha);
		
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
	
		draw_set_font(fnt);
		draw_set_color(col);
		draw_set_alpha(a);
	}
	
	render = function(){
		surface.target();
		draw_clear_alpha(c_black, 0);
		gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
		
		var sep = fontSize * separation;
		
		for(var i = 0; i < array_length(splitted); i++){
			draw_text_transformed(0, sep * i, splitted[i], fontScale, fontScale, 0);	
		}
		
		gpu_set_blendmode(bm_normal);
		surface.reset();
	}
	
	draw = function(tx = 0, ty = 0){
		surface.draw(tx, ty);
	}
	
	calculate();
}