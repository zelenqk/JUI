function textbox(width, height, range = "aA0-zZ9") constructor{
	self.width = width;
	self.height = height;
	self.range = [];
	
	color = c_dkgray;
	background = c_white;
	
	selected = false;
	
	var storage = string_split(range, "-", true);
	
	for(var i = 0; i < string_length(storage[0]); i++){
		var charLow = string_char_at(storage[0], i);
		var charHigh = charLow;
		if (array_length(storage) > 1) charHigh = string_char_at(storage[1], i);
		
		self.range[array_length(self.range)]= [charLow, charHigh];
	};
	
	cursor = cr_beam;
	text = "";
	overflow = fa_hidden;
	allowSelect = true;
	position = 0;
	
	step = function(){
		if (device_mouse_check_button_pressed(mouse, mb_left) and hover){
			selected = true;
			keyboard_string	= text;
		}
		
		if (keyboard_check_pressed(vk_backspace)){
			var clear = false;
			
			if (is_array(text)){
				for(var i = 0; i < array_length(highlight); i++){
					text[i] = string_delete(text[i], highlight[i][0], highlight[i][1] - highlight[i][0]);
				}
			}else{
				text = string_delete(text, highlight[0][0], highlight[0][1] - highlight[0][0]);
			}
			
			if (keyboard_check(vk_control) and !clear){
				var lastspace = string_last_pos(" ", text);
				
				keyboard_string = string_copy(text, 0, lastspace - 1);
			}
		}
		
		if (selected){
			position = string_length(text);
			text = keyboard_string;
		}
	}
}