function get_default(name, fallback = BASE_CONTAINER[$ name]){
	var value = style[$ name];
	if (value == undefined) return fallback;
	return value;
}