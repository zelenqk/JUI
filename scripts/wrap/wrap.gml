function wrap(val, min, max) {
	var range = max - min;
	if (range == 0) return min; // or show_error("Invalid range", true);
	return ((val - min) mod range + range) mod range + min;
}
