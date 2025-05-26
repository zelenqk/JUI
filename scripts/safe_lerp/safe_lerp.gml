function safe_lerp(a, b, amt) {
	return lerp(a, b, clamp(amt, 0, 1));
}
