function get_default(name, fallback = BASE_CONTAINER[$ name]){
	var value = style[$ name];
	if (value == undefined) return fallback;
	return value;
}
function get_default_style(style, name, fallback = BASE_CONTAINER[$ name]){
	var value = style[$ name];
	if (value == undefined) return fallback;
	return value;
}