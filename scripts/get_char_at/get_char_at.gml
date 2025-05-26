function get_char_at(text, tx, ty, mx, my, w, h){
	if (my < ty or my > ty + h) return -1;
	
	return clamp(round((mx - tx) / w), 0, string_length(text));
}