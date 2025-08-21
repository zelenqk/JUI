//bozhi surfaces and now bozhi text? whats next bozhi sprites?

function btext(text, w = infinity) constructor{
	self.text = text;
	splitted = string_split(text, " ", true);
	
	maximum = w;
	
	width = 0;
	height = 0;
	
	font = fntMain;
	fontSize = 24;
	fontScale = (FONT_SIZES[font] / fontSize);
	
	calculate = function(){
		width = string_width_ext(text, fontSize, maximum * fontScale);
		height = string_height_ext(text, fontSize, maximum * fontScale);
	}
}