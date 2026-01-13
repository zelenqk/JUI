globalvar mouse_in_box;

mouse_in_box = function(x, y, width, height){
	for(var i = 0; i < 10; i++){
		if (point_in_rectangle(
			device_mouse_x_to_gui(i) - 0.001,
			device_mouse_y_to_gui(i) - 0.001,
			x, y,
			x + width, y + height)) return i;
	}
	
	return -1;
}

if (os_type == os_ios or os_type == os_android){
	mouse_in_box = function(x, y, width, height){
		for(var i = 0; i < 10; i++){
			if (device_mouse_check_button(i, mb_any) and point_in_rectangle(
				device_mouse_x_to_gui(i) - 0.001,
				device_mouse_y_to_gui(i) - 0.001,
				x, y,
				x + width, y + height)) return i;
		}
		
		return -1;
	}	
}