function mouse_in_box(tx, ty, w, h){
	for(var i = 0; i < 10; i++){
		if (point_in_rectangle(device_mouse_x_to_gui(i), device_mouse_y_to_gui(i), tx, ty, tx + w, ty + h))	return i;
	}
	
	return -1;
}