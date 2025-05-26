function color_distance(c1, c2) {
	var r1 = color_get_red(c1);
	var g1 = color_get_green(c1);
	var b1 = color_get_blue(c1);

	var r2 = color_get_red(c2);
	var g2 = color_get_green(c2);
	var b2 = color_get_blue(c2);

	return point_distance_3d(r1, g1, b1, r2, g2, b2); // final distance in 0..1
}