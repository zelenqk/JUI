function get_default(name, fallback = auto){
	var value = style[$ name];
	
	if (value == undefined) return fallback;
	return value;
}