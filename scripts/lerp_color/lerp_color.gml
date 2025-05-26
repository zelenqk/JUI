function lerp_color(col1, col2, easing, func = lerp) {
	var r1 = color_get_red(col1);
	var g1 = color_get_green(col1);
	var b1 = color_get_blue(col1);

	var r2 = color_get_red(col2);
	var g2 = color_get_green(col2);
	var b2 = color_get_blue(col2);

	var r = func(r1, r2, easing);
	var g = func(g1, g2, easing);
	var b = func(b1, b2, easing);

	return make_color_rgb(r, g, b);
}
