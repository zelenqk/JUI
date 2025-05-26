function invert_color(c) {
	var r = color_get_red(c);
	var g = color_get_green(c);
	var b = color_get_blue(c);
	return make_color_rgb(255 - r, 255 - g, 255 - b);
}
