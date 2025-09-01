function get_default(name, fallback = -1){
	var value = style[$ name];
	
	if (value == undefined) return fallback;
	return value;
}