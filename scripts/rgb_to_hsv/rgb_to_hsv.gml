function rgb_to_hsv(color) {
	// Normalize RGB to [0,1]
	
	var h = color_get_hue(color);
	var s = color_get_saturation(color);
	var v = color_get_value(color);
	
	return make_color_hsv(h, s, v);
}
