function mouse_in_box(x, y, width, height){
	for(var i = 0; i < 10; i++){
		if (point_in_rectangle(
			device_mouse_x_to_gui(i),
			device_mouse_y_to_gui(i),
			x, y,
			x + width, y + height)) return i;
	}
	
	return -1;
}